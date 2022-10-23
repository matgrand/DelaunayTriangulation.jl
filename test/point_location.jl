@testset "Point location with DAG or jump-and-march" begin
    for n = 3:111
        r = 5sqrt.(rand(n))
        θ = 2π * rand(n)
        pts = [@SVector[r * cos(θ), r * sin(θ)] for (r, θ) in zip(r, θ)]
        T, adj, adj2v, DG, HG = DT.triangulate_berg(pts)
        _pts = deepcopy(pts)
        for k in rand(1:n, ceil(Int64, 0.45n^(1 / 3)))
            for _ in 1:length(T)
                sample_T = rand(T)
                a, b, c = DT.get_point(pts, sample_T...)
                q = (a .+ b .+ c) ./ 3
                push!(_pts, q)
                τ, flag = locate_triangle(HG, _pts, n + 1, DT.BoundingTriangle)
                @test DT.isintriangle(τ, _pts, n + 1) == flag == 1
                @test DT.isoriented(τ, pts) == 1
                for _ in 1:4
                    τ = jump_and_march(q, adj, adj2v, DG, pts; k=k)
                    @test DT.isintriangle(τ, _pts, n + 1) == 1
                    @test DT.isoriented(τ, pts) == 1
                    τ = jump_and_march(q, adj, adj2v, DG, pts)
                    @test DT.isintriangle(τ, _pts, n + 1) == 1
                    @test DT.isoriented(τ, pts) == 1
                    τ = jump_and_march(n + 1, adj, adj2v, DG, _pts; k=k, pt_idx=1:n)
                    @test DT.isintriangle(τ, _pts, n + 1) == 1
                    @test DT.isoriented(τ, pts) == 1
                    τ = jump_and_march(n + 1, adj, adj2v, DG, _pts; pt_idx=1:n)
                    @test DT.isintriangle(τ, _pts, n + 1) == 1
                    @test DT.isoriented(τ, pts) == 1

                    τ = jump_and_march(q, adj, adj2v, DG, pts; k=k, pt_idx=[1])
                    @test DT.isintriangle(τ, _pts, n + 1) == 1
                    @test DT.isoriented(τ, pts) == 1
                    τ = jump_and_march(q, adj, adj2v, DG, pts; pt_idx=[1])
                    @test DT.isintriangle(τ, _pts, n + 1) == 1
                    @test DT.isoriented(τ, pts) == 1
                    τ = jump_and_march(n + 1, adj, adj2v, DG, _pts; k=k, pt_idx=[1])
                    @test DT.isintriangle(τ, _pts, n + 1) == 1
                    @test DT.isoriented(τ, pts) == 1
                    τ = jump_and_march(n + 1, adj, adj2v, DG, _pts; pt_idx=[1])
                    @test DT.isintriangle(τ, _pts, n + 1) == 1
                    @test DT.isoriented(τ, pts) == 1
                end
                pop!(_pts)
                for q in (a, b, c)
                    push!(_pts, q)
                    τ, flag = locate_triangle(HG, _pts, n + 1, DT.BoundingTriangle)
                    @test DT.isintriangle(τ, _pts, n + 1) == flag == 0
                    @test DT.isoriented(τ, pts) == 1
                    for _ in 1:4
                        τ = jump_and_march(q, adj, adj2v, DG, pts; k=k)
                        @test DT.isintriangle(τ, _pts, n + 1) == 0
                        @test DT.isoriented(τ, pts) == 1
                        τ = jump_and_march(q, adj, adj2v, DG, pts)
                        @test DT.isintriangle(τ, _pts, n + 1) == 0
                        @test DT.isoriented(τ, pts) == 1
                    end
                    pop!(_pts)
                end
            end
        end
    end
end

@testset "Can we correctly locate triangles when the triangulation contains ghost triangles?" begin
    p1 = @SVector[-3.32, 3.53]
    p2 = @SVector[-5.98, 2.17]
    p3 = @SVector[-6.36, -1.55]
    p4 = @SVector[-2.26, -4.31]
    p5 = @SVector[6.34, -3.23]
    p6 = @SVector[-3.24, 1.01]
    p7 = @SVector[0.14, -1.51]
    p8 = @SVector[0.2, 1.25]
    p9 = @SVector[1.0, 4.0]
    p10 = @SVector[4.74, 2.21]
    p11 = @SVector[2.32, -0.27]
    pts = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11]
    T = Set{NTuple{3,Int64}}()
    adj = DT.Adjacent{Int64,NTuple{2,Int64}}()
    adj2v = DT.Adjacent2Vertex{Int64,Set{NTuple{2,Int64}},NTuple{2,Int64}}()
    DG = DT.DelaunayGraph{Int64}()
    for (i, j, k) in (
        (1, 2, 6),
        (1, 6, 8),
        (9, 1, 8),
        (9, 8, 10),
        (10, 8, 11),
        (8, 7, 11),
        (8, 6, 7),
        (6, 2, 3),
        (6, 3, 4),
        (6, 4, 7),
        (7, 4, 5),
        (11, 7, 5),
        (10, 11, 5)
    )
        DT.add_triangle!(i, j, k, T, adj, adj2v, DG; update_ghost_edges=true)
    end
    DT.compute_centroid!(pts[1:11])
    Ts = [
        (1, 9, DT.BoundaryIndex),
        (9, 10, DT.BoundaryIndex),
        (10, 5, DT.BoundaryIndex),
        (5, 4, DT.BoundaryIndex),
        (4, 3, DT.BoundaryIndex),
        (3, 2, DT.BoundaryIndex),
        (2, 1, DT.BoundaryIndex),
        (2, 6, 1),
        (2, 3, 6),
        (6, 3, 4),
        (6, 4, 7),
        (7, 4, 5),
        (11, 7, 5),
        (10, 11, 5),
        (10, 8, 11),
        (9, 8, 10),
        (9, 1, 8),
        (1, 6, 8),
        (6, 7, 8),
        (8, 7, 11)
    ]
    q1 = [
        @SVector[-3.48098, 5.21],
        @SVector[-1.6344, 4.87],
        @SVector[0.50467, 5.145]
    ]
    q2 = [
        @SVector[1.747, 4.797],
        @SVector[4.6183, 3.15],
        @SVector[6.757, 5.16]
    ]
    q3 = [
        @SVector[15.533, 4.35],
        @SVector[5.185, 1.927],
        @SVector[6.5380, -2.734]
    ]
    q4 = [
        @SVector[-2.054, -4.58],
        @SVector[6.0809, -3.612],
        @SVector[4.088, -4.16]
    ]
    q5 = [
        @SVector[-5.455, -4.48998],
        @SVector[-6.8267, -2.69826],
        @SVector[-5.876, -6.20856]
    ]
    q6 = [
        @SVector[-7.22896, 0.486],
        @SVector[-7.53977, -0.79685],
        @SVector[-8.05, 1.63]
    ]
    q7 = [
        @SVector[-4.55966, 3.9384],
        @SVector[-5.4738, 2.87799],
        @SVector[-7.484, 2.914562]
    ]
    q8 = [
        @SVector[-3.554, 1.9828],
        @SVector[-4.5413866, 2.11],
        @SVector[-4.10259876, 2.6037]
    ]
    q9 = [
        @SVector[-5.422486, 0.223220],
        @SVector[-5.636737, 1.413],
        @SVector[-5.0, 1.0]
    ]
    q10 = [
        @SVector[-4.5070486, -1.47],
        @SVector[-3.435792, 0.4569],
        @SVector[-3.70847555, -1.56869]
    ]
    q11 = [
        @SVector[-0.553137, -1.4907],
        @SVector[-2.0, -3.0],
        @SVector[-2.6761737, -0.12737]
    ]
    q12 = [
        @SVector[-1.05955, -3.5934],
        @SVector[0.401254, -2.3283],
        @SVector[4.8226, -3.06845]
    ]
    q13 = [
        @SVector[1.4725, -1.296016],
        @SVector[0.6544605, -1.49079],
        @SVector[4.3941199, -2.36727]
    ]
    q14 = [
        @SVector[4.3162104144292, 0.86597],
        @SVector[3.030702467, -0.185804],
        @SVector[5.1147835, -1.7439963]
    ]
    q15 = [
        @SVector[1.414078837, 1.158352],
        @SVector[3.0891346, 1.5087],
        @SVector[2.271084, 0.456949]
    ]
    q16 = [
        @SVector[1.4316084, 2.0618862],
        @SVector[3.1027688220566, 2.36],
        @SVector[1.345909611897, 2.961741]
    ]
    q17 = [
        @SVector[-1.803586508901, 3.0902926154433],
        @SVector[-0.1110010453829, 2.70464023],
        @SVector[-1.2251079327619, 3.09029]
    ]
    q18 = [
        @SVector[-2.4891907472888, 2.2118621850099],
        @SVector[-2.7891426015824, 2.68321],
        @SVector[-1.7391111, 1.93333]
    ]
    q19 = [
        @SVector[-0.1110010453829, 0.9906296353829],
        @SVector[-2.1678137605441, 0.6478275161894],
        @SVector[-0.43237, -0.701955828]
    ]
    q20 = [
        @SVector[0.53175298105, 0.455001324143],
        @SVector[1.0459561068953, -0.0377767221977],
        @SVector[0.6817288552522, -0.8305066228328]
    ]
    qs = [q1, q2, q3, q4, q5,
        q6, q7, q8, q9, q10,
        q11, q12, q13, q14, q15,
        q16, q17, q18, q19, q20]
    for (i, _qs) in enumerate(qs)
        for q in _qs
            τ = jump_and_march(q, adj, adj2v, DG, pts; pt_idx=1:11)
            @test τ == Ts[i] || τ == DT.shift_triangle_1(Ts[i]) || τ == DT.shift_triangle_2(Ts[i])
        end
    end
end