reset

# plots Particle in EM Field (Perpendicular)

# --------------------------------------------------------------------------- #
#                                   Orbite                                    #
# --------------------------------------------------------------------------- #

# --------------------------------- dt = 1.0 -------------------------------- #
reset

# Canva dimensions
set term qt 3 size 600,400
set title "Particle in EM Field (perpendicular) \\ Orbits 1 \\ \Delta t = 1.0"
set xlabel "x"  font ",14"
set ylabel "y"  font ",14"

# Setting axis' range
set xrange[-5:40]
set yrange[0:1.5]

# Setting grid
set grid

set key         font ",14"
set lmargin at screen 0.12
set rmargin at screen 0.95
set bmargin at screen 0.12
set tmargin at screen 0.95

# Adding some draw (the X for the multiparticle problem)
set parametric
set trange [0:2*pi] # range for the functions

# Lines x,y = solution (parametric form!)
x(t)  = sin(t)
y(t)  = cos(t)

# Plotting the data
plot \
    "../data/BORIS.dat" using 2:3 index 0 w l lw 0.5 lc rgb "red" title "Boris", \
    "../data/RK4.dat" using 2:3 index 0 w l lw 0.5 lc rgb "blue" title "RK4", \
    x(t), y(t) w l lw 1.5 lc rgb "black" notitle

unset parametric

# -------------------------------- dt = 0.01 -------------------------------- #
reset

# Canva dimensions
set term qt 4 size 600,400
set title "Particle in EM Field perpendicular \\ Orbits 2 \\ \Delta t = 0.01"
set xlabel "x"  font ",14"
set ylabel "y"  font ",14"

# Setting axis' range
set xrange[-5:40]
set yrange[0:1.5]

# Setting grid
set grid

set key         font ",14"
set lmargin at screen 0.12
set rmargin at screen 0.95
set bmargin at screen 0.12
set tmargin at screen 0.95

# Adding some draw (the X for the multiparticle problem)
set parametric
set trange [0:2*pi] # range for the functions

# Lines x,y = solution (parametric form!)
x(t)  = sin(t)
y(t)  = cos(t)

# Plotting the data
plot \
    "../data/BORIS.dat" using 2:3 index 2 w l lw 1 lc rgb "red" title "Boris", \
    "../data/RK4.dat" using 2:3 index 2 w l lw 1 lc rgb "blue" title "RK4", \
    x(t), y(t) w l lw 1 lc rgb "black" notitle

unset parametric

# ---------------------------- Boris 3d dt = 1.0 ---------------------------- #
reset

# Canva dimensions
set term qt 5 size 600,400
set title "Particle in EM Field (perpendicular) \\ Orbits 3 \\ \Delta t = 0.01"
set xlabel "x"  font ",14"
set ylabel "y"  font ",14"
set zlabel "z"  font ",14"

# Setting axis' range
set xrange[-1:1]
set yrange[-1:1]
set zrange[-1:1]

# Setting grid
set grid

# 3D View
set view 60, 30     # angles (elevazione, azimut)
set ticslevel 0     # xy

# Stile linea
set style line 1 lw 2 lc rgb "purple"

# Plotting the data
splot "../data/BORIS.dat" using 2:3:4 index 2 w l ls 1 lc rgb "red" title "Boris"