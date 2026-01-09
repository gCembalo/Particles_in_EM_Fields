reset

# plots Particle in EM Field (Perpendicular)

# --------------------------------------------------------------------------- #
#                                   Orbite                                    #
# --------------------------------------------------------------------------- #

# --------------------------------- dt = 1.0 -------------------------------- #
reset

# Canva dimensions
set term qt 1 size 600,400
set title "Particle in EM Field (perpendicular) ; Orbits 1 ; \Delta t = 1.0" font ",14"
set xlabel "x"  font ",14"
set ylabel "y"  font ",14"

# Setting axis' range
set xrange[-5:40]
set yrange[0:1.2]

# Setting grid
set grid

# Plotting the data
plot \
    "../data/BORIS.dat" using 2:3 index 0 w l lw 0.5 lc rgb "blue" title "Boris", \
    "../data/RK4.dat" using 2:3 index 0 w l lw 0.5 lc rgb "red" title "RK4"

# -------------------------------- dt = 0.01 -------------------------------- #
reset

# Canva dimensions
set term qt 2 size 600,400
set title "Particle in EM Field perpendicular ; Orbits 2 ; \Delta t = 0.01" font ",14"
set xlabel "x"  font ",14"
set ylabel "y"  font ",14"

# Setting axis' range
set xrange[-5:40]
set yrange[0:1.2]

# Setting grid
set grid

# Plotting the data
plot \
    "../data/BORIS.dat" using 2:3 index 2 w l lw 1 lc rgb "blue" title "Boris", \
    "../data/RK4.dat" using 2:3 index 2 w l lw 1 lc rgb "red" title "RK4"

# ---------------------------- Boris 3d dt = 0.01 ---------------------------- #
reset

# Canva dimensions
set term qt 3 size 600,400
set title "Particle in EM Field (perpendicular) ; Orbits 3 ; \Delta t = 0.01" font ",14"
set xlabel "x"  font ",14"
set ylabel "y"  font ",14"
set zlabel "z"  font ",14"

# Setting axis' range
set xrange[-5:40]
set yrange[0:1.2]
set zrange[-1:1]

# Setting grid
set grid xtics ytics ztics

# 3D View
set view 60, 30     # angles (elevazione, azimut)
set ticslevel 0     # xy

# Plotting the data
splot "../data/BORIS.dat" using 2:3:4 index 2 w l ls 1 lc rgb "blue" title "Boris"