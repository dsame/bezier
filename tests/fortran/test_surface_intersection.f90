! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     https://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.

module test_surface_intersection

  use, intrinsic :: iso_c_binding, only: c_bool, c_double, c_int
  use curve, only: CurveData, LOCATE_MISS
  use curve_intersection, only: Intersection
  use surface_intersection, only: &
       IntersectionClassification_SAME_CURVATURE, &
       IntersectionClassification_BAD_TANGENT, &
       IntersectionClassification_EDGE_END, IntersectionClassification_FIRST, &
       IntersectionClassification_SECOND, IntersectionClassification_OPPOSED, &
       IntersectionClassification_TANGENT_FIRST, &
       IntersectionClassification_TANGENT_SECOND, &
       IntersectionClassification_IGNORED_CORNER, newton_refine, &
       locate_point, classify_intersection
  use types, only: dp
  use unit_test_helpers, only: print_status
  implicit none
  private test_newton_refine, test_locate_point, test_classify_intersection
  public surface_intersection_all_tests

contains

  subroutine surface_intersection_all_tests(success)
    logical(c_bool), intent(inout) :: success

    call test_newton_refine(success)
    call test_locate_point(success)
    call test_classify_intersection(success)

  end subroutine surface_intersection_all_tests

  subroutine test_newton_refine(success)
    logical(c_bool), intent(inout) :: success
    ! Variables outside of signature.
    logical :: case_success
    integer :: case_id
    character(:), allocatable :: name
    real(c_double) :: nodes(6, 2)
    real(c_double) :: updated_s, updated_t

    case_id = 1
    name = "newton_refine (Surface)"

    ! CASE 1: Quadratic surface.
    ! NOTE: This surface is given by
    !     [(4 s - t^2) / 4, (4 s^2 + 4 s t - t^2 - 4 s + 8 t) / 8]
    nodes(1, :) = [0.0_dp, 0.0_dp]
    nodes(2, :) = [0.5_dp, -0.25_dp]
    nodes(3, :) = [1.0_dp, 0.0_dp]
    nodes(4, :) = [0.0_dp, 0.5_dp]
    nodes(5, :) = [0.5_dp, 0.5_dp]
    nodes(6, :) = [-0.25_dp, 0.875_dp]
    ! At our point (s, t) = (1/4, 1/2), the Jacobian is
    !     [1, -1/4]
    !     [0,  1  ]
    ! hence there will be no round-off when applying the inverse.
    call newton_refine( &
         6, nodes, 2, 0.484375_dp, 0.1796875_dp, &
         0.25_dp, 0.5_dp, updated_s, updated_t)
    case_success = ( &
         updated_s == 247.0_dp / 512 .AND. &
         updated_t == 31.0_dp / 128)
    call print_status(name, case_id, case_success, success)

    ! CASE 2: Solution is **exact**.
    ! NOTE: This surface is given by [s, t]
    nodes(1, :) = [0.0_dp, 0.0_dp]
    nodes(2, :) = [0.5_dp, 0.0_dp]
    nodes(3, :) = [1.0_dp, 0.0_dp]
    nodes(4, :) = [0.0_dp, 0.5_dp]
    nodes(5, :) = [0.5_dp, 0.5_dp]
    nodes(6, :) = [0.0_dp, 1.0_dp]
    ! Since x(s) = s and y(t) = t, we simply use the same x/y and s/t.
    call newton_refine( &
         6, nodes, 2, 0.375_dp, 0.75_dp, &
         0.375_dp, 0.75_dp, updated_s, updated_t)
    case_success = ( &
         updated_s == 0.375_dp .AND. &
         updated_t == 0.75_dp)
    call print_status(name, case_id, case_success, success)

  end subroutine test_newton_refine

  subroutine test_locate_point(success)
    logical(c_bool), intent(inout) :: success
    ! Variables outside of signature.
    logical :: case_success
    integer :: case_id
    real(c_double), allocatable :: nodes(:, :)
    integer(c_int) :: degree
    real(c_double) :: x_val, y_val, s_val, t_val
    real(c_double) :: expected_s, expected_t
    character(:), allocatable :: name

    case_id = 1
    name = "newton_refine (Surface)"

    ! CASE 1: B(s, t) = (s, t), match.
    allocate(nodes(3, 2))
    nodes(1, :) = 0
    nodes(2, :) = [1.0_dp, 0.0_dp]
    nodes(3, :) = [0.0_dp, 1.0_dp]
    x_val = 0.25_dp
    y_val = 0.625_dp
    call locate_point( &
         3, nodes, 1, x_val, y_val, s_val, t_val)
    case_success = (x_val == s_val .AND. y_val == t_val)
    call print_status(name, case_id, case_success, success)

    ! CASE 2: B(s, t) = (s, t), no match.
    x_val = -0.125_dp
    y_val = 0.25_dp
    call locate_point( &
         3, nodes, 1, x_val, y_val, s_val, t_val)
    case_success = (s_val == LOCATE_MISS)
    call print_status(name, case_id, case_success, success)

    ! CASE 3: B(s, t) = (-2 (s + 2 t) (t - 1), 2 (s + 1) t), one extra
    !         Newton refinement required (verified by hand).
    deallocate(nodes)
    allocate(nodes(6, 2))
    nodes(1, :) = 0
    nodes(2, :) = [1.0_dp, 0.0_dp]
    nodes(3, :) = [2.0_dp, 0.0_dp]
    nodes(4, :) = [2.0_dp, 1.0_dp]
    nodes(5, :) = [2.0_dp, 2.0_dp]
    nodes(6, :) = [0.0_dp, 2.0_dp]
    x_val = 0.59375_dp
    y_val = 0.25_dp
    call locate_point( &
         6, nodes, 2, x_val, y_val, s_val, t_val)
    ! NOTE: We can use the resultant to find that the **true** answers
    !       are roots of the following polynomials.
    !           64 s^3 + 101 s^2 + 34 s - 5 = 0
    !           128 t^3 - 192 t^2 + 91 t - 8 = 0
    !       Using extended precision, we can find these values to more
    !       digits than what is supported by IEEE-754.
    expected_s = 0.109190958136897160638_dp
    expected_t = 0.11269475204698919699_dp
    case_success = ( &
         abs(s_val - expected_s) <= 5 * spacing(expected_s) .AND. &
         abs(t_val - expected_t) <= spacing(expected_t))
    call print_status(name, case_id, case_success, success)

  end subroutine test_locate_point

  subroutine test_classify_intersection(success)
    logical(c_bool), intent(inout) :: success
    ! Variables outside of signature.
    logical :: case_success
    integer :: case_id
    character(:), allocatable :: name
    type(Intersection) :: intersection_
    type(CurveData) :: edges_first(3), edges_second(3)
    real(c_double) :: nodes1(2, 2), nodes2(3, 2)
    integer(c_int) :: enum_

    case_id = 1
    name = "classify_intersection"

    ! CASE 1: Intersection is on "the end" of the first edge.
    intersection_%s = 1.0_dp
    intersection_%t = 0.5_dp
    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_EDGE_END)
    call print_status(name, case_id, case_success, success)

    ! CASE 2: Intersection is on "the end" of the second edge.
    intersection_%s = 0.5_dp
    intersection_%t = 1.0_dp
    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_EDGE_END)
    call print_status(name, case_id, case_success, success)

    ! CASE 3: Intersection is on interior, "second".
    nodes1(1, :) = 0
    nodes1(2, :) = 1
    edges_first(1)%nodes = nodes1

    nodes1(1, :) = [0.25_dp, 0.0_dp]
    nodes1(2, :) = [0.75_dp, 1.0_dp]
    edges_second(1)%nodes = nodes1

    intersection_%s = 0.5_dp
    intersection_%index_first = 1
    intersection_%t = 0.5_dp
    intersection_%index_second = 1

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_SECOND)
    call print_status(name, case_id, case_success, success)

    ! CASE 4: Intersection is on interior, "first".
    call classify_intersection(edges_second, edges_first, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_FIRST)
    call print_status(name, case_id, case_success, success)

    ! CASE 5: Intersection is tangent, "first".
    nodes2(1, :) = 0
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [3.0_dp, 0.0_dp]
    edges_first(1)%nodes = nodes2

    nodes2(1, :) = [1.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [2.0_dp, 0.0_dp]
    edges_second(1)%nodes = nodes2

    intersection_%s = 0.5_dp
    intersection_%index_first = 1
    intersection_%t = 0.5_dp
    intersection_%index_second = 1

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_TANGENT_FIRST)
    call print_status(name, case_id, case_success, success)

    ! CASE 6: Intersection is tangent, "second".
    call classify_intersection(edges_second, edges_first, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_TANGENT_SECOND)
    call print_status(name, case_id, case_success, success)

    ! CASE 7: Intersection is an ignored corner.
    ! NOTE: The curves in ``edges_first`` are the edges of the
    !       "unit simplex" ...
    nodes1(1, :) = 0
    nodes1(2, :) = [1.0_dp, 0.0_dp]
    edges_first(1)%nodes = nodes1
    nodes1(1, :) = [1.0_dp, 0.0_dp]
    nodes1(2, :) = [0.0_dp, 1.0_dp]
    edges_first(2)%nodes = nodes1
    nodes1(1, :) = [0.0_dp, 1.0_dp]
    nodes1(2, :) = 0
    edges_first(3)%nodes = nodes1
    ! ... and those in ``edges_second`` are the edges in the surface given by
    !           [ 0,  0]
    !           [-1,  0]
    !           [ 0, -1]
    nodes1(1, :) = [-1.0_dp, 0.0_dp]
    nodes1(2, :) = [0.0_dp, -1.0_dp]
    edges_second(1)%nodes = nodes1
    nodes1(1, :) = [0.0_dp, -1.0_dp]
    nodes1(2, :) = 0
    edges_second(2)%nodes = nodes1
    nodes1(1, :) = 0
    nodes1(2, :) = [-1.0_dp, 0.0_dp]
    edges_second(3)%nodes = nodes1

    intersection_%s = 0.0_dp
    intersection_%index_first = 1
    intersection_%t = 0.0_dp
    intersection_%index_second = 3

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_IGNORED_CORNER)
    call print_status(name, case_id, case_success, success)

    ! CASE 8: Intersection is a corner.
    nodes1(1, :) = [0.0_dp, 0.5_dp]
    nodes1(2, :) = 1
    edges_first(1)%nodes = nodes1
    nodes1(1, :) = 1
    nodes1(2, :) = 0
    edges_first(2)%nodes = nodes1
    deallocate(edges_first(3)%nodes)  ! Unset.

    deallocate(edges_second(1)%nodes)  ! Unset.
    nodes1(1, :) = [1.0_dp, 0.0_dp]
    nodes1(2, :) = [1.0_dp, 2.0_dp]
    edges_second(2)%nodes = nodes1
    deallocate(edges_second(3)%nodes)  ! Unset.

    intersection_%s = 0.0_dp
    intersection_%index_first = 2
    intersection_%t = 0.5_dp
    intersection_%index_second = 2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_FIRST)
    call print_status(name, case_id, case_success, success)

    ! CASE 9: Intersection is tangent, use curvature of "first".
    deallocate(edges_first(1)%nodes)  ! Unset.
    nodes2(1, :) = [2.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [1.0_dp, 0.0_dp]
    edges_first(2)%nodes = nodes2

    nodes2(1, :) = [3.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [0.0_dp, 0.0_dp]
    edges_second(2)%nodes = nodes2

    intersection_%s = 0.5_dp
    intersection_%index_first = 2
    intersection_%t = 0.5_dp
    intersection_%index_second = 2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_TANGENT_FIRST)
    call print_status(name, case_id, case_success, success)

    ! CASE 10: Intersection is tangent, use curvature of "second".
    nodes2(1, :) = [1.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [2.0_dp, 0.0_dp]
    edges_first(2)%nodes = nodes2

    nodes2(1, :) = [0.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [3.0_dp, 0.0_dp]
    edges_second(2)%nodes = nodes2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_TANGENT_SECOND)
    call print_status(name, case_id, case_success, success)

    ! CASE 11: Intersection is tangent, same curvature and direction.
    nodes2(1, :) = [1.0_dp, 0.25_dp]
    nodes2(2, :) = [-0.5_dp, -0.25_dp]
    nodes2(3, :) = [0.0_dp, 0.25_dp]
    edges_first(2)%nodes = nodes2

    nodes2(1, :) = [0.75_dp, 0.25_dp]
    nodes2(2, :) = [-0.25_dp, -0.25_dp]
    nodes2(3, :) = [-0.25_dp, 0.25_dp]
    edges_second(2)%nodes = nodes2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_SAME_CURVATURE)
    call print_status(name, case_id, case_success, success)

    ! CASE 12: Intersection is tangent, same curvature, opposite direction.
    nodes2(1, :) = [0.0_dp, 0.25_dp]
    nodes2(2, :) = [-0.5_dp, -0.25_dp]
    nodes2(3, :) = [1.0_dp, 0.25_dp]
    edges_first(2)%nodes = nodes2

    nodes2(1, :) = [0.75_dp, 0.25_dp]
    nodes2(2, :) = [-0.25_dp, -0.25_dp]
    nodes2(3, :) = [-0.25_dp, 0.25_dp]
    edges_second(2)%nodes = nodes2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_SAME_CURVATURE)
    call print_status(name, case_id, case_success, success)

    ! CASE 13: Intersection is tangent, opposite direction, curvatures have
    !          same sign and there is no overlap.
    nodes2(1, :) = [2.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [1.0_dp, 0.0_dp]
    edges_first(2)%nodes = nodes2

    nodes2(1, :) = 1
    nodes2(2, :) = [1.5_dp, 0.0_dp]
    nodes2(3, :) = [2.0_dp, 1.0_dp]
    edges_second(2)%nodes = nodes2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_OPPOSED)
    call print_status(name, case_id, case_success, success)

    ! CASE 14: Intersection is tangent, opposite direction, curvatures have
    !          same sign and there **is** overlap.
    nodes2(1, :) = [1.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [2.0_dp, 0.0_dp]
    edges_first(2)%nodes = nodes2

    nodes2(1, :) = [2.0_dp, 1.0_dp]
    nodes2(2, :) = [1.5_dp, 0.0_dp]
    nodes2(3, :) = 1
    edges_second(2)%nodes = nodes2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_BAD_TANGENT)
    call print_status(name, case_id, case_success, success)

    ! CASE 15: Intersection is tangent, opposite direction, curvatures have
    !          opposite sign and there is no overlap.
    nodes2(1, :) = [2.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [1.0_dp, 0.0_dp]
    edges_first(2)%nodes = nodes2

    nodes2(1, :) = [0.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [3.0_dp, 0.0_dp]
    edges_second(2)%nodes = nodes2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_OPPOSED)
    call print_status(name, case_id, case_success, success)

    ! CASE 16: Intersection is tangent, opposite direction, curvatures have
    !          opposite sign and there **is** overlap.
    nodes2(1, :) = [1.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [2.0_dp, 0.0_dp]
    edges_first(2)%nodes = nodes2

    nodes2(1, :) = [3.0_dp, 0.0_dp]
    nodes2(2, :) = [1.5_dp, 1.0_dp]
    nodes2(3, :) = [0.0_dp, 0.0_dp]
    edges_second(2)%nodes = nodes2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_BAD_TANGENT)
    call print_status(name, case_id, case_success, success)

    ! CASE 17: Intersection at corner, but the corner "staddles" an edge.
    nodes1(1, :) = 0
    nodes1(2, :) = [1.0_dp, 0.0_dp]
    edges_first(2)%nodes = nodes1

    nodes1(1, :) = [1.0_dp, 1.0_dp]
    nodes1(2, :) = [0.5_dp, 0.0_dp]
    edges_second(1)%nodes = nodes1
    nodes1(1, :) = [0.5_dp, 0.0_dp]
    nodes1(2, :) = [1.5_dp, -1.0_dp]
    edges_second(2)%nodes = nodes1

    intersection_%s = 0.5_dp
    intersection_%index_first = 2
    intersection_%t = 0.0_dp
    intersection_%index_second = 2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_FIRST)
    call print_status(name, case_id, case_success, success)

    ! CASE 18: Intersection at corner of **both** edges, the corners just
    !          "kiss", hence are ignored.
    nodes1(1, :) = [0.5_dp, 1.0_dp]
    nodes1(2, :) = [1.0_dp, 0.0_dp]
    edges_first(1)%nodes = nodes1
    nodes1(1, :) = [1.0_dp, 0.0_dp]
    nodes1(2, :) = [1.5_dp, 0.25_dp]
    edges_first(2)%nodes = nodes1

    nodes1(1, :) = 0
    nodes1(2, :) = [1.0_dp, 0.0_dp]
    edges_second(1)%nodes = nodes1
    nodes1(1, :) = [1.0_dp, 0.0_dp]
    nodes1(2, :) = [0.0_dp, 1.0_dp]
    edges_second(2)%nodes = nodes1

    intersection_%s = 0.0_dp
    intersection_%index_first = 2
    intersection_%t = 0.0_dp
    intersection_%index_second = 2

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_IGNORED_CORNER)
    call print_status(name, case_id, case_success, success)

    ! CASE 19: Intersection at corner of **both** edges, "first" is interior.
    nodes1(1, :) = 0
    nodes1(2, :) = [1.0_dp, 0.0_dp]
    edges_first(1)%nodes = nodes1
    nodes1(1, :) = [1.0_dp, 0.0_dp]
    nodes1(2, :) = [0.0_dp, 1.0_dp]
    edges_first(2)%nodes = nodes1

    nodes1(1, :) = [0.5_dp, 0.25_dp]
    nodes1(2, :) = [1.0_dp, 0.0_dp]
    edges_second(1)%nodes = nodes1
    nodes1(1, :) = [1.0_dp, 0.0_dp]
    nodes1(2, :) = [1.0_dp, 1.0_dp]
    edges_second(2)%nodes = nodes1

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_FIRST)
    call print_status(name, case_id, case_success, success)

    ! CASE 20: Intersection at corner of **both** edges, "second" is interior.
    nodes1(1, :) = [0.5_dp, 0.25_dp]
    nodes1(2, :) = [1.0_dp, 0.0_dp]
    edges_first(1)%nodes = nodes1
    nodes1(1, :) = [1.0_dp, 0.0_dp]
    nodes1(2, :) = [1.0_dp, 1.0_dp]
    edges_first(2)%nodes = nodes1

    nodes1(1, :) = 0
    nodes1(2, :) = [1.0_dp, 0.0_dp]
    edges_second(1)%nodes = nodes1
    nodes1(1, :) = [1.0_dp, 0.0_dp]
    nodes1(2, :) = [0.0_dp, 1.0_dp]
    edges_second(2)%nodes = nodes1

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_SECOND)
    call print_status(name, case_id, case_success, success)

    ! CASE 21: Intersection at corner of **both** edges, one corner is
    !          completely contained in the area of the other corner.
    nodes1(1, :) = [0.5_dp, 1.0_dp]
    nodes1(2, :) = 0
    edges_first(1)%nodes = nodes1
    nodes1(1, :) = 0
    nodes1(2, :) = [1.0_dp, 0.5_dp]
    edges_first(2)%nodes = nodes1

    nodes1(1, :) = [0.0_dp, 1.0_dp]
    nodes1(2, :) = 0
    edges_second(1)%nodes = nodes1
    nodes1(1, :) = 0
    nodes1(2, :) = [1.0_dp, 0.0_dp]
    edges_second(2)%nodes = nodes1

    call classify_intersection(edges_first, edges_second, intersection_, enum_)
    case_success = (enum_ == IntersectionClassification_FIRST)
    call print_status(name, case_id, case_success, success)

  end subroutine test_classify_intersection

end module test_surface_intersection