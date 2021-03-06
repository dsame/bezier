// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef BEZIER_TRIANGLE_H
#define BEZIER_TRIANGLE_H

#include <stdbool.h>

#if defined(__cplusplus)
extern "C" {
#endif

void BEZ_de_casteljau_one_round(const int* num_nodes, const int* dimension,
    const double* nodes, const int* degree, const double* lambda1,
    const double* lambda2, const double* lambda3, double* new_nodes);
void BEZ_evaluate_barycentric(const int* num_nodes, const int* dimension,
    const double* nodes, const int* degree, const double* lambda1,
    const double* lambda2, const double* lambda3, double* point);
void BEZ_evaluate_barycentric_multi(const int* num_nodes, const int* dimension,
    const double* nodes, const int* degree, const int* num_vals,
    const double* param_vals, double* evaluated);
void BEZ_evaluate_cartesian_multi(const int* num_nodes, const int* dimension,
    const double* nodes, const int* degree, const int* num_vals,
    const double* param_vals, double* evaluated);
void BEZ_jacobian_both(const int* num_nodes, const int* dimension,
    const double* nodes, const int* degree, double* new_nodes);
void BEZ_jacobian_det(const int* num_nodes, const double* nodes,
    const int* degree, const int* num_vals, const double* param_vals,
    double* evaluated);
void BEZ_specialize_triangle(const int* num_nodes, const int* dimension,
    const double* nodes, const int* degree, const double* weights_a,
    const double* weights_b, const double* weights_c, double* specialized);
void BEZ_subdivide_nodes_triangle(const int* num_nodes, const int* dimension,
    const double* nodes, const int* degree, double* nodes_a, double* nodes_b,
    double* nodes_c, double* nodes_d);
void BEZ_compute_edge_nodes(const int* num_nodes, const int* dimension,
    const double* nodes, const int* degree, double* nodes1, double* nodes2,
    double* nodes3);
void BEZ_compute_area(int* num_edges, int* sizes,
    const double* const* nodes_pointers, double* area, bool* not_implemented);

#if defined(__cplusplus)
}
#endif

#endif /* BEZIER_TRIANGLE_H */
