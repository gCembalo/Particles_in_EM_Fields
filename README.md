# Project: Particle(s) in Electromagnetic Fields

Project for the MSc course "Numerical Algorithms for Physics".

## Overview
This project studies the motion of one or more **non-relativistic charged particles** in a prescribed, fixed electromagnetic field.
The particle dynamics is governed by the Lorentz force equation and is solved via **direct numerical integration**.

The project is developed in the context of computational physics / astrophysics and focuses on both **physical modeling** and **numerical integration techniques**.

---

## Physical Model
The equation of motion for each particle is:

\[
\frac{d\vec{v}}{dt} = \frac{e}{m} \left( \vec{E} + \frac{\vec{v}}{c} \times \vec{B} \right)
\]

where:
- \( \vec{v} \) is the particle velocity  
- \( \vec{E} \) and \( \vec{B} \) are externally prescribed electric and magnetic fields  
- \( e \) is the particle charge  
- \( m \) is the particle mass  
- \( c \) is the speed of light  

The equation is written in the **c.g.s. system**, widely used in astrophysics, although **dimensionless units** are adopted in the implementation.

---

## Assumptions
- Particles are **non-relativistic**
- Electromagnetic fields are **fixed and externally defined**
- **No particle–particle interactions** are included
- Motion can occur in **three dimensions (x, y, z)**

---

## Numerical Methods
The project involves the numerical integration of the equations of motion using:
- **Runge–Kutta (RK) methods**
- **Symplectic integration schemes** adapted to velocity-dependent forces
- The **Boris algorithm**, which is a standard and widely used method for charged particle dynamics in electromagnetic fields

---

## Features
- Simulation of single or multiple charged particles
- Support for 3D particle trajectories
- Visualization of particle motion and velocity magnitude
- Comparison between different numerical integrators
- Analysis of numerical stability and energy conservation

---

## Project Structure
```text
.
├── src/            # Source code
├── notebooks/      # (Optional) Analysis and visualization notebooks
├── data/           # (Optional) Output data
├── figures/        # Generated plots and figures
└── README.md
