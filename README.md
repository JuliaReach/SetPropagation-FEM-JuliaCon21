# Computing Reachable Sets of Semi-Discrete Solid Dynamics Equations with ReachabilityAnalysis.jl

by Marcelo Forets (Depto. de Matemática y Aplicaciones, CURE, UdelaR, Maldonado, Uruguay),
Daniel Freire Caporale (Depto. de Matemática y Aplicaciones, CURE, UdelaR, Maldonado, Uruguay), and
Jorge M. Pérez Zerpa (Instituto de Estructuras y Transporte, Facultad de Ingeniería, UdelaR, Montevideo, Uruguay).

## Presentation

[![JuliaCon 2021 video](https://img.youtube.com/vi/MQM9U0hiLks/0.jpg)](https://youtu.be/MQM9U0hiLks)

## Pre-print

https://arxiv.org/abs/2105.05841

## Minimal example

```julia
using ReachabilityAnalysis

# model parameters
m = 0.25; k = 2.0

# FEM assembled matrices
M = [2m 0; 0 m]; K = [2k -k; -k k]; C = (M+K)/20
F = [0.0, 1.0]; ΔF0 = Interval(0.9, 1.1)

# initial-value problem with set initial conditions
sys = SecondOrderAffineContinuousSystem(M, C, K, F)
U0 = BallInf(zeros(4), 0.5)
prob = InitialValueProblem(homogeneize(sys), U0 × ΔF0)

# solve using support functions
solA = solve(prob, 50, LGG09(δ=5e-2, dirs=:box, dim=5))
solB = solve(prob, 50, LGG09(δ=5e-2, dirs=:oct, dim=5))
```
