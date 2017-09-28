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

module test_surface

  use, intrinsic :: iso_c_binding, only: c_bool, c_double
  use surface, only: &
       de_casteljau_one_round, evaluate_barycentric
  use types, only: dp
  use unit_test_helpers, only: print_status, get_random_nodes
  implicit none
  private &
       test_de_casteljau_one_round, test_evaluate_barycentric
  public surface_all_tests

contains

  subroutine surface_all_tests(success)
    logical(c_bool), intent(inout) :: success

    call test_de_casteljau_one_round(success)
    call test_evaluate_barycentric(success)

  end subroutine surface_all_tests

  subroutine test_de_casteljau_one_round(success)
    logical(c_bool), intent(inout) :: success
    ! Variables outside of signature.
    real(c_double) :: nodes1(3, 2), nodes2(6, 2), nodes3(10, 2)
    real(c_double) :: new_nodes1(1, 2), new_nodes2(3, 2), new_nodes3(6, 2)
    real(c_double) :: expected1(1, 2), expected2(3, 2), expected3(6, 2)
    real(c_double) :: lambda1, lambda2, lambda3
    integer :: case_id
    character(:), allocatable :: name

    case_id = 1
    name = "de_casteljau_one_round"

    ! CASE 1: Linear reference triangle (just goes to point).
    nodes1(1, :) = 0
    nodes1(2, :) = [1.0_dp, 0.0_dp]
    nodes1(3, :) = [0.0_dp, 1.0_dp]
    lambda1 = 0.125_dp
    lambda2 = 0.5_dp
    lambda3 = 0.375_dp
    expected1(1, :) = [lambda2, lambda3]
    call de_casteljau_one_round( &
         3, 2, nodes1, 1, &
         lambda1, lambda2, lambda3, new_nodes1)
    if (all(new_nodes1 == expected1)) then
       call print_status(name, case_id, .TRUE.)
    else
       call print_status(name, case_id, .FALSE.)
       success = .FALSE.
    end if

    ! CASE 2: Quadratic surface.
    call get_random_nodes(nodes2, 790931, 1483, num_bits=8)
    ! NOTE: Use a fixed seed so the test is deterministic and round
    !       the nodes to 8 bits of precision to avoid round-off.
    lambda1 = 0.625_dp
    lambda2 = 0.25_dp
    lambda3 = 0.125_dp
    expected2(1, :) = ( &
         lambda1 * nodes2(1, :) + &  ! p200
         lambda2 * nodes2(2, :) + &  ! p110
         lambda3 * nodes2(4, :))  ! p101
    expected2(2, :) = ( &
         lambda1 * nodes2(2, :) + &  ! p110
         lambda2 * nodes2(3, :) + &  ! p020
         lambda3 * nodes2(5, :))  ! p011
    expected2(3, :) = ( &
         lambda1 * nodes2(4, :) + &  ! p101
         lambda2 * nodes2(5, :) + &  ! p011
         lambda3 * nodes2(6, :))  ! p002
    call de_casteljau_one_round( &
         6, 2, nodes2, 2, &
         lambda1, lambda2, lambda3, new_nodes2)
    if (all(new_nodes2 == expected2)) then
       call print_status(name, case_id, .TRUE.)
    else
       call print_status(name, case_id, .FALSE.)
       success = .FALSE.
    end if

    ! CASE 3: Cubic surface.
    nodes3(1, :) = [0.0_dp, 0.0_dp]
    nodes3(2, :) = [3.25_dp, 1.5_dp]
    nodes3(3, :) = [6.5_dp, 1.5_dp]
    nodes3(4, :) = [10.0_dp, 0.0_dp]
    nodes3(5, :) = [1.5_dp, 3.25_dp]
    nodes3(6, :) = [5.0_dp, 5.0_dp]
    nodes3(7, :) = [10.0_dp, 5.25_dp]
    nodes3(8, :) = [1.5_dp, 6.5_dp]
    nodes3(9, :) = [5.25_dp, 10.0_dp]
    nodes3(10, :) = [0.0_dp, 10.0_dp]
    lambda1 = 0.375_dp
    lambda2 = 0.25_dp
    lambda3 = 0.375_dp
    expected3(1, :) = ( &
         lambda1 * nodes3(1, :) + &  ! p300
         lambda2 * nodes3(2, :) + &  ! p210
         lambda3 * nodes3(5, :))  ! p201
    expected3(2, :) = ( &
         lambda1 * nodes3(2, :) + &  ! p210
         lambda2 * nodes3(3, :) + &  ! p120
         lambda3 * nodes3(6, :))  ! p111
    expected3(3, :) = ( &
         lambda1 * nodes3(3, :) + &  ! p120
         lambda2 * nodes3(4, :) + &  ! p030
         lambda3 * nodes3(7, :))  ! p021
    expected3(4, :) = ( &
         lambda1 * nodes3(5, :) + &  ! p201
         lambda2 * nodes3(6, :) + &  ! p111
         lambda3 * nodes3(8, :))  ! p102
    expected3(5, :) = ( &
         lambda1 * nodes3(6, :) + &  ! p111
         lambda2 * nodes3(7, :) + &  ! p021
         lambda3 * nodes3(9, :))  ! p012
    expected3(6, :) = ( &
         lambda1 * nodes3(8, :) + &  ! p102
         lambda2 * nodes3(9, :) + &  ! p012
         lambda3 * nodes3(10, :))  ! p003

    call de_casteljau_one_round( &
         10, 2, nodes3, 3, &
         lambda1, lambda2, lambda3, new_nodes3)
    if (all(new_nodes3 == expected3)) then
       call print_status(name, case_id, .TRUE.)
    else
       call print_status(name, case_id, .FALSE.)
       success = .FALSE.
    end if

  end subroutine test_de_casteljau_one_round

  subroutine test_evaluate_barycentric(success)
    logical(c_bool), intent(inout) :: success
    ! Variables outside of signature.
    real(c_double) :: nodes1(3, 2), nodes2(6, 2), nodes3(6, 3)
    real(c_double) :: nodes4(10, 2), nodes5(15, 2)
    real(c_double) :: point1(1, 2), point2(1, 3)
    real(c_double) :: expected1(1, 2), expected2(1, 3)
    real(c_double) :: lambda1, lambda2, lambda3
    integer :: index_, i, j, k, trinomial
    integer :: case_id
    character(:), allocatable :: name

    case_id = 1
    name = "evaluate_barycentric"

    ! CASE 1: Linear surface.
    nodes1(1, :) = 0
    nodes1(2, :) = [1.0_dp, 0.5_dp]
    nodes1(3, :) = [0.0_dp, 1.25_dp]
    lambda1 = 0.25_dp
    lambda2 = 0.5_dp
    lambda3 = 0.25_dp
    expected1(1, :) = [0.5_dp, 0.5625_dp]
    call evaluate_barycentric( &
         3, 2, nodes1, 1, lambda1, lambda2, lambda3, point1)
    if (all(point1 == expected1)) then
       call print_status(name, case_id, .TRUE.)
    else
       call print_status(name, case_id, .FALSE.)
       success = .FALSE.
    end if

    ! CASE 2: Quadratic surface.
    lambda1 = 0.0_dp
    lambda2 = 0.25_dp
    lambda3 = 0.75_dp
    nodes2(1, :) = [0.0_dp, 0.0_dp]
    nodes2(2, :) = [0.5_dp, 0.0_dp]
    nodes2(3, :) = [1.0_dp, 0.5_dp]
    nodes2(4, :) = [0.5_dp, 1.25_dp]
    nodes2(5, :) = [0.0_dp, 1.25_dp]
    nodes2(6, :) = [0.0_dp, 0.5_dp]
    expected1(1, :) = [0.0625_dp, 0.78125_dp]
    call evaluate_barycentric( &
         6, 2, nodes2, 2, lambda1, lambda2, lambda3, point1)
    if (all(point1 == expected1)) then
       call print_status(name, case_id, .TRUE.)
    else
       call print_status(name, case_id, .FALSE.)
       success = .FALSE.
    end if

    ! CASE 3: Quadratic surface in 3D.
    nodes3(1, :) = [0.0_dp, 0.0_dp, 1.0_dp]
    nodes3(2, :) = [0.5_dp, 0.0_dp, 0.25_dp]
    nodes3(3, :) = [1.0_dp, 0.5_dp, 0.0_dp]
    nodes3(4, :) = [0.5_dp, 1.25_dp, 1.25_dp]
    nodes3(5, :) = [0.0_dp, 1.25_dp, 0.5_dp]
    nodes3(6, :) = [0.0_dp, 0.5_dp, -1.0_dp]
    lambda1 = 0.125_dp
    lambda2 = 0.375_dp
    lambda3 = 0.5_dp
    expected2(1, :) = [0.25_dp, 0.8203125_dp, 0.1328125_dp]
    call evaluate_barycentric( &
         6, 3, nodes3, 2, lambda1, lambda2, lambda3, point2)
    if (all(point2 == expected2)) then
       call print_status(name, case_id, .TRUE.)
    else
       call print_status(name, case_id, .FALSE.)
       success = .FALSE.
    end if

    ! CASE 4: Cubic surface.
    nodes4(1, :) = [0.0_dp, 0.0_dp]
    nodes4(2, :) = [0.25_dp, 0.0_dp]
    nodes4(3, :) = [0.75_dp, 0.25_dp]
    nodes4(4, :) = [1.0_dp, 0.0_dp]
    nodes4(5, :) = [0.0_dp, 0.25_dp]
    nodes4(6, :) = [0.375_dp, 0.25_dp]
    nodes4(7, :) = [0.5_dp, 0.25_dp]
    nodes4(8, :) = [0.0_dp, 0.5_dp]
    nodes4(9, :) = [0.25_dp, 0.75_dp]
    nodes4(10, :) = [0.0_dp, 1.0_dp]
    lambda1 = 0.125_dp
    lambda2 = 0.5_dp
    lambda3 = 0.375_dp
    expected1(1, :) = [0.447265625_dp, 0.37060546875_dp]
    call evaluate_barycentric( &
         10, 2, nodes4, 3, lambda1, lambda2, lambda3, point1)
    if (all(point1 == expected1)) then
       call print_status(name, case_id, .TRUE.)
    else
       call print_status(name, case_id, .FALSE.)
       success = .FALSE.
    end if

    ! CASE 5: Quartic (random) surface.
    call get_random_nodes(nodes5, 64441, 222, num_bits=8)
    ! NOTE: Use a fixed seed so the test is deterministic and round
    !       the nodes to 8 bits of precision to avoid round-off.
    lambda1 = 0.125_dp
    lambda2 = 0.375_dp
    lambda3 = 0.5_dp
    ! We will manually compute the expected output.
    expected1 = 0
    index_ = 1
    do k = 0, 4
       do j = 0, 4 - k
          i = 4 - j - k
          if (maxval([i, j, k]) == 4) then
             trinomial = 1
          else if (maxval([i, j, k]) == 3) then
             trinomial = 4
          else if (minval([i, j, k]) == 0) then
             trinomial = 6
          else
             trinomial = 12
          end if
          expected1(1, :) = ( &
               expected1(1, :) + &
               ( &
               trinomial * lambda1**i * lambda2**j * lambda3**k * &
               nodes5(index_, :)))
          ! Update the index.
          index_ = index_ + 1
       end do
    end do
    call evaluate_barycentric( &
         15, 2, nodes5, 4, lambda1, lambda2, lambda3, point1)
    if (all(point1 == expected1)) then
       call print_status(name, case_id, .TRUE.)
    else
       call print_status(name, case_id, .FALSE.)
       success = .FALSE.
    end if

  end subroutine test_evaluate_barycentric

end module test_surface