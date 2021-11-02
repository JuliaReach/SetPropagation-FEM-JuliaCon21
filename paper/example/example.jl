using LazySets, Plots
using LazySets: center
using Plots.PlotMeasures
using LaTeXStrings

using ReachabilityAnalysis

# model parameters
m = 0.25; k = 2.0

# FEM assembled matrices
M = [2m 0; 0 m]; K = [2k -k; -k k]; C = (M+K)/20
F = [0.0, 1.0]; ΔF0 = Interval(0.9, 1.1)

# initial-value problem with set initial conditions
sys = SecondOrderAffineContinuousSystem(M, C, K, F)
U0 = BallInf(zeros(4), 0.5)
prob = InitialValueProblem(homogenize(sys), U0 × ΔF0)

# solve using support functions
solA = solve(prob, 50, LGG09(δ=5e-2, dirs=:box, dim=5))
solB = solve(prob, 50, LGG09(δ=5e-2, dirs=:oct, dim=5))

# compute random trajectories
ntraj = 100
B0 = box_approximation(U0 × ΔF0)
prob_orbit_random(m) = [IVP(prob.s, sample(B0)) for _ in 1:m];
sol_orbit = [solve(p, T=50, alg=ORBIT(δ=0.01)) for p in prob_orbit_random(ntraj)]

U0vert = vertices_list(B0)
sol_orbit_vert = [solve(IVP(prob.s, v), T=50, alg=ORBIT(δ=0.01)) for v in U0vert]

# plot displacement vs time
fig = plot(xlab="Time", ylab="Displacement",
           legendfontsize=16, legend=:topright,
           tickfont=font(18, "Times"), guidefontsize=18,
           xtick=([0, 10, 20, 30, 40, 50], [L"0", L"10", L"20", L"30", L"40", L"50"]),
           ytick=([-0.5, 0, 0.5, 1, 1.5], [L"-0.5", L"0", L"0.5", L"1.0", L"1.5"]),
           xguidefont=font(18, "Times"),
           yguidefont=font(18, "Times"),
           ylims=(-0.65, 1.65),
           bottom_margin=8mm, left_margin=8mm, right_margin=4mm, top_margin=3mm, size=(900, 600))

plot!(fig, solA, vars=(0, 1), lw=0.3, c=:blue, alpha=1., lc=:blue)
[plot!(fig, s, vars=(0, 1), alpha=1., seriestype=:path, c=:magenta, marker=:none, lw=0.6) for s in sol_orbit]
[plot!(fig, s, vars=(0, 1), alpha=1., seriestype=:path, c=:magenta, marker=:none, lw=0.6) for s in sol_orbit_vert]

lens!(fig, [0.5, 4.0], [0.4, 1.55], inset = (1, bbox(0.58, 0.0, 0.35, 0.35)),
      subplot=2, tickfont=font(16, "Times"),
      xtick=([1.0, 2.0, 3.0, 4.0], [L"1", L"2", L"3", L"4"]),
      ytick=([0.5, 1.0, 1.5], [L"0.5", L"1.0", L"1.5"]))

lens!(fig, [40, 50], [0.4, 0.6], inset = (1, bbox(0.58, 0.58, 0.35, 0.35)),
      subplot=3, tickfont=font(16, "Times"),
      xtick=([40, 45, 50], [L"40", L"45", L"50"]),
      ytick=([0.4, 0.5, 0.6], [L"0.4", L"0.5", L"0.6"]))

savefig(fig, "displacement_vs_time.pdf")
savefig(fig, "displacement_vs_time.png")

# plot velocity vs displacement
fig = plot(xlab="Displacement mass 2m", ylab="Displacement mass m",
           legendfontsize=16, legend=:topright,
           tickfont=font(18, "Times"), guidefontsize=18,
           xtick=([-0.5,0, 0.5, 1.0, 1.5], [L"-0.5", L"0", L"0.5", L"1.0", L"1.5"]),
           ytick=([-0.5, 0.5, 1.5, 2.5], [L"-0.5", L"0.5", L"1.5", L"2.5"]),
           xguidefont=font(18, "Times"),
           yguidefont=font(18, "Times"),
           xlims=(-0.65, 1.65),
           ylims=(-0.6, 2.5),
           bottom_margin=8mm, left_margin=8mm, right_margin=4mm, top_margin=3mm, size=(900, 600))

plot!(fig, solB, vars=(1, 2), lw=0.0, c=:blue, alpha=0.8)
[plot!(fig, s, vars=(1, 2), alpha=0.7, seriestype=:path, c=:magenta, marker=:none, lw=1.1) for s in sol_orbit]
[plot!(fig, s, vars=(1, 2), alpha=0.7, seriestype=:path, c=:magenta, marker=:none, lw=1.1) for s in sol_orbit_vert]

savefig(fig, "displacement_vs_displacement.pdf")
savefig(fig, "displacement_vs_displacement.png")
