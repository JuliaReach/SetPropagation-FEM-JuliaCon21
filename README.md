# Computing Reachable Sets of Semi-Discrete Solid Dynamics Equations with ReachabilityAnalysis.jl

by [Jorge M. Pérez Zerpa](https://github.com/dfcaporale) (Instituto de Estructuras y Transporte, Facultad de Ingeniería, UdelaR, Montevideo, Uruguay), [Marcelo Forets](https://github.com/mforets) (Depto. de Matemática y Aplicaciones, CURE, UdelaR, Maldonado, Uruguay) and
[Daniel Freire Caporale](https://github.com/jorgepz) (Depto. de Matemática y Aplicaciones, CURE, UdelaR, Maldonado, Uruguay).

[![status](https://proceedings.juliacon.org/papers/24a082818ba9447244932e21d16da342/status.svg)](https://proceedings.juliacon.org/papers/24a082818ba9447244932e21d16da342)

## Presentation

[![JuliaCon 2021 video](https://img.youtube.com/vi/MQM9U0hiLks/0.jpg)](https://youtu.be/MQM9U0hiLks)

## Extended Abstract

[paper.pdf](https://github.com/JuliaReach/SetPropagation-FEM-JuliaCon21/blob/main/paper/paper.pdf)

## Pre-print

https://arxiv.org/abs/2105.05841

## Minimal example

We solve the system of two degrees of freedom loaded with a Heaviside step function subject to
Rayleigh damping shown in the diagram below.

<img src="https://github.com/JuliaReach/SetPropagation-FEM-JuliaCon21/blob/main/paper/example/masses.png" width="400" class="center"/>

Given the FEM assembled matrices, the range of variation of the external loads is 10\% around the nominal value 1.
Initial displacements and velocities for both masses belong to the interval `[-0.5, 0.5]`.
The initial-value problem is instantiated and homogeneized as described in [1].

<img src="https://github.com/JuliaReach/SetPropagation-FEM-JuliaCon21/blob/main/paper/example/code.png?raw=true" width="550"/>

To illustrate the flexibility of our approach, two algorithm choices are considered, both relying on support functions [7] (`LGG09` algorithm). `solA` contains the flowpipe efficiently computed along box directions. To improve the accuracy, `solB` is computed using octagonal template directions.

<img src="https://github.com/JuliaReach/SetPropagation-FEM-JuliaCon21/blob/main/paper/example/displacement_vs_displacement.png" width="400"/>

<img src="https://github.com/JuliaReach/SetPropagation-FEM-JuliaCon21/blob/main/paper/example/velocity_vs_displacement.png" width="400"/>

## Examples repository

https://github.com/JuliaReach/SetPropagation-FEM-Examples

## References

[1] Matthias Althoff, Goran Frehse, and Antoine Girard. Set propagation techniques for reachability analysis. Annual Review of Control, Robotics, and Autonomous Systems, 4, 2020.

[2] Klaus-Jürgen Bathe. Finite Element Procedures. Watertown, USA, 2 edition, 2014.

[3] Jorge M. Pérez Zerpa et al. Open Nonlinear Structural Analysis Solver ONSAS. https://github.com/ONSAS/ONSAS.m/, 2021.

[4] Luca Feranti, Marcelo Forets, and David P. Sanders. IntervalLinearAlgebra.jl: linear algebra done rigorously, 9 2021. doi:10.5281/zenodo.5363563.

[5] Marcelo Forets, Daniel Freire Caporale, and Jorge M Pérez Zerpa. Combining set propagation with finite element methods for time integration in transient solid mechanics problems. arXiv preprint arXiv:2105.05841. Accepted in Computers & Structures, 2021.

[6] Marcelo Forets, Christian Schilling, and Luca Feranti. IntervalMatrices.jl: Matrices with interval coefficients in Julia, 9 2021.
doi:10.5281/zenodo.5516249.

[7] Colas Le Guernic and Antoine Girard. Reachability analysis of linear systems using support functions. Nonlinear Analysis: Hybrid Systems, 4(2):250 – 262, 2010. IFAC World Congress 2008.
