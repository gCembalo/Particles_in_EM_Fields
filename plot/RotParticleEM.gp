# plots Particle in EM Field (Rotation)

# --------------------------------------------------------------------------- #
#                                   Errori                                    #
# --------------------------------------------------------------------------- #
reset

# Canva dimensions
set term qt 1 size 600,400
set title "t = 100.0" font ",16"
set xlabel "dt" font ",16"
set ylabel "Err"  font ",16"

set key font ",14"
set key top left
set key spacing 1.2
set tics font ",14"

# Setting log scale
set logscale y
set logscale x

# Setting axis' range
set xrange[0.005:1.5]
set yrange[1.e-9:100]

# Setting grid
set grid

# Adding some draw (the X for the multiparticle problem)
set parametric
set trange [0.005:1.5] # range for the functions

# Lines y = x^2 and y = x^4 (parametric form!)
x2(t)  = t
y2(t)  = t*t
x4(t)  = t
y4(t)  = t*t*t*t

# Plotting the data
plot \
    "../data/ERR.dat" using 1:3 w p lw 2 lc rgb "blue" title "Boris", \
    x2(t), y2(t) w l lw 1.5 lc rgb "blue" title "2nd order", \
    "../data/ERR.dat" using 1:2 w p lw 2 lc rgb "red" title "RK4", \
    x4(t), y4(t) w l lw 1.5 lc rgb "red" title "4th order"



# --------------------------------------------------------------------------- #
#                                   Orbite                                    #
# --------------------------------------------------------------------------- #

# --------------------------------- dt = 1.0 -------------------------------- #
reset

# Canva dimensions
set term qt 3 size 600,600
set title "t = 100.0 ; \Delta t = 1.0" font ",16"
set xlabel "x"  font ",16"
set ylabel "y"  font ",16"

set key font ",14"
set key top right
#set key spacing 1.2
set tics font ",14"

# Setting axis' range
set xrange[-1:1]
set yrange[-1:1]

# Setting grid
set grid

# Adding some draw (the X for the multiparticle problem)
set parametric
set trange [0:2*pi] # range for the functions

# Lines x,y = solution (parametric form!)
x(t)  = sin(t)
y(t)  = cos(t)

# Plotting the data
plot \
    x(t), y(t) w l lw 1.5 lc rgb "black" title "Soluzione esatta", \
    "../data/BORIS.dat" using 2:3 index 0 w l lw 1.0 lc rgb "blue" title "Boris", \
    "../data/RK4.dat" using 2:3 index 0 w l lw 1.0 lc rgb "red" title "RK4"

unset parametric

# -------------------------------- dt = 0.1 -------------------------------- #
reset

# Canva dimensions
set term qt 4 size 600,600
set title "t = 100.0 ; \Delta t = 0.1" font ",16"
set xlabel "x"  font ",16"
set ylabel "y"  font ",16"

set key font ",14"
set key top right
#set key spacing 1.2
set tics font ",14"

# Setting axis' range
set xrange[-1:1]
set yrange[-1:1]

# Setting grid
set grid

# Adding some draw (the X for the multiparticle problem)
set parametric
set trange [0:2*pi] # range for the functions

# Lines x,y = solution (parametric form!)
x(t)  = sin(t)
y(t)  = cos(t)

# Plotting the data
plot \
    x(t), y(t) w l lw 1 lc rgb "black" title "Soluzione esatta", \
    "../data/BORIS.dat" using 2:3 index 1 w l lw 1.0 lc rgb "blue" title "Boris", \
    "../data/RK4.dat" using 2:3 index 1 w l lw 1.0 lc rgb "red" title "RK4"

unset parametric


# -------------------------------- dt = 0.01 -------------------------------- #
reset

# Canva dimensions
set term qt 5 size 600,600
set title "t = 100.0 ; \Delta t = 0.01" font ",16"
set xlabel "x"  font ",16"
set ylabel "y"  font ",16"

set key font ",14"
set key top right
#set key spacing 1.2
set tics font ",14"

# Setting axis' range
set xrange[-1:1]
set yrange[-1:1]

# Setting grid
set grid

# Adding some draw (the X for the multiparticle problem)
set parametric
set trange [0:2*pi] # range for the functions

# Lines x,y = solution (parametric form!)
x(t)  = sin(t)
y(t)  = cos(t)

# Plotting the data
plot \
    x(t), y(t) w l lw 1 lc rgb "black" title "Soluzione esatta", \
    "../data/BORIS.dat" using 2:3 index 2 w l lw 1.0 lc rgb "blue" title "Boris", \
    "../data/RK4.dat" using 2:3 index 2 w l lw 1.0 lc rgb "red" title "RK4"

unset parametric

# ---------------------------- Boris 3d dt = 1.0 ---------------------------- #
reset

# Canva dimensions
set term qt 6 size 600,400
set title "t = 100.0 ; \Delta t = 0.01" font ",16"
set xlabel "x"  font ",16"
set ylabel "y"  font ",16"
set zlabel "z"  font ",16"

set key font ",14"
set key top left
set key spacing 1.2
set tics font ",14"

# Setting axis' range
set xrange[-1:1]
set yrange[-1:1]
set zrange[-1:1]

# Setting grid
set grid xtics ytics ztics

# 3D View
set view 60, 30     # angles (elevazione, azimut)
set ticslevel 0     # xy

# Stile linea
set style line 1 lw 2 lc rgb "purple"

# Plotting the data
splot "../data/BORIS.dat" using 2:3:4 index 2 w l ls 1 lc rgb "blue" title "Boris"