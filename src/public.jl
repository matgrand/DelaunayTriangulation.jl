@static if VERSION >= v"1.11.0-DEV.469"
    eval(
        Meta.parse(
            """
            public Adjacent,
                Adjacent2Vertex,
                Graph,
                InsertionEventHistory,
                ZeroWeight,
                all_ghost_vertices,
                check_args,
                compute_representative_points!,
                contains_boundary_edge,
                delete_ghost_vertices_from_graph!,
                dist,
                get_all_boundary_nodes,
                get_curve_index,
                get_edges,
                get_insertion_order,
                get_left_boundary_node,
                get_representative_point_coordinates,
                get_representative_point_list,
                get_right_boundary_node,
                get_section_index,
                get_vertices,
                has_ghost_vertices,
                has_vertex,
                is_exterior_ghost_vertex,
                is_interior_ghost_vertex,
                iterated_neighbourhood,
                num_curves,
                num_points,
                num_sections,
                validate_triangulation,
                add_boundary_information!,
                clear_empty_features!,
                complete_split_edge_and_legalise!,
                complete_split_triangle_and_legalise!,
                delete_holes!,
                get_surrounding_polygon,
                get_boundary_polygons,
                get_centroid,
                get_circumcenter_to_triangle,
                get_cocircular_circumcenters,
                get_generators,
                get_polygon_points,
                get_polygons,
                get_triangle_to_circumcenter,
                get_triangulation,
                get_unbounded_polygons,
                num_generators,
                polygon_features,
                toggle_inf_warn!,
                AbstractParametricCurve,
                angle_between,
                arc_length,
                curvature,
                differentiate,
                get_circle_intersection,
                get_closest_point,
                get_equidistant_split,
                get_equivariation_split,
                get_inverse,
                marked_total_variation,
                orientation_markers,
                point_position_relative_to_curve,
                thrice_differentiate,
                total_variation,
                twice_differentiate,
                each_boundary_edge,
                each_point,
                each_point_index,
                each_unbounded_polygon,
                Certificate,
                contains_segment,
                contains_triangle,
                edge_exists,
                find_edge,
                has_boundary_nodes,
                has_ghost_triangles,
                has_multiple_curves,
                has_multiple_intersections,
                has_multiple_sections,
                has_no_intersections,
                has_one_intersection,
                is_above,
                is_acute,
                is_below,
                is_boundary_edge,
                is_boundary_node,
                is_boundary_triangle,
                is_closer,
                is_collinear,
                is_constrained,
                is_degenerate,
                is_equidistant,
                is_further,
                is_ghost_edge,
                is_ghost_triangle,
                is_ghost_vertex,
                is_illegal,
                is_inside,
                is_left,
                is_legal,
                is_multiple,
                is_negatively_oriented,
                is_negativelyoriented,
                is_none,
                is_obtuse,
                is_on,
                is_outside,
                is_positively_oriented,
                is_positivelyoriented,
                is_right,
                is_single,
                is_touching,
                is_weighted,
                line_segment_intersection_type,
                opposite_angle,
                point_closest_to_line,
                point_position_on_line_segment,
                point_position_relative_to_circle,
                point_position_relative_to_circumcircle,
                point_position_relative_to_diametral_circle,
                point_position_relative_to_diametral_lens,
                point_position_relative_to_line,
                point_position_relative_to_oriented_outer_halfplane,
                point_position_relative_to_triangle,
                point_position_relative_to_witness_plane,
                triangle_line_segment_intersection,
                triangle_orientation,
                unoriented_edge_exists,
                IndividualTriangleStatistics,
                get_angles,
                get_aspect_ratio,
                get_circumcenter,
                get_circumradius,
                get_edge_midpoints,
                get_individual_statistics,
                get_inradius,
                get_largest_angle,
                get_largest_area,
                get_largest_radius_edge_ratio,
                get_lengths,
                get_maximum_angle,
                get_median_angle,
                get_minimum_angle,
                get_offcenter,
                get_perimeter,
                get_radius_edge_ratio,
                get_sink,
                get_smallest_angle,
                get_smallest_area,
                get_smallest_radius_edge_ratio,
                num_boundary_segments,
                num_convex_hull_vertices,
                num_interior_segments,
                num_segments,
                triangle_angles,
                triangle_area,
                triangle_aspect_ratio,
                triangle_centroid,
                triangle_circumcenter,
                triangle_circumradius,
                triangle_edge_midpoints,
                triangle_inradius,
                triangle_lengths,
                triangle_offcenter,
                triangle_perimeter,
                triangle_radius_edge_ratio,
                triangle_sink,
                clip_polygon,
                construct_polygon_hierarchy,
                distance_to_polygon,
                number_type,
                pole_of_inaccessibility,
                is_point2,
                AbstractPredicateKernel,
                orient_predicate,
                incircle_predicate,
                parallelorder_predicate,
                angle_is_acute_predicate,
                sameside_predicate,
                meet_predicate,
                sort_triangle
    """,
        ),
    )
end
