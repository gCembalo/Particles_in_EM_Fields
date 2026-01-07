reset

# plots Particle in EM Field (Rotation)

# --------------------------------------------------------------------------- #
#                                   Errori                                    #
# --------------------------------------------------------------------------- #

# Canva dimensions
set term qt 1 size 600,400
set title "Particle in EM Field Rotation \\ Errori"
set xlabel "dt"  font ",14"
set ylabel "Error"  font ",14"

# Setting log scale
set logscale y
set logscale x

# Setting axis' range
set xrange[0.005:1.5]
# set yrange[-0.05:0.6]

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
    "../data/ERR.dat" using 1:2 w p lw 2 lc rgb "red" title "RK4", \
    "../data/ERR.dat" using 1:3 w p lw 2 lc rgb "blue" title "Boris", \
    x2(t), y2(t) w l lw 1.5 lc rgb "red" notitle, \
    x4(t), y4(t) w l lw 1.5 lc rgb "blue" notitle


# --------------------------------------------------------------------------- #
#                              Energia cinetica                               #
# --------------------------------------------------------------------------- #
reset

# Canva dimensions
set term qt 2 size 600,400
set title "Particle in EM Field Rotation \\ Energia cinetica"
set xlabel "t"  font ",14"
set ylabel "Energia cinetica"  font ",14"

# Setting axis' range
set xrange[-10:160]
set yrange[-0.05:0.6]

# Setting log scale
# set logscale y
# set logscale x

# Setting grid
set grid

# Plotting the data
plot "../data/BORIS.dat" using 1:5 index 0 w l lw 1.0 lc rgb "red" title "Boris dt = T/60"
replot "../data/RK4.dat" using 1:5 index 0 w l lw 1.0 lc rgb "blue" title "RK4 dt = T/60"
replot "../data/RK4.dat" using 1:5 index 1 w l lw 1.0 lc rgb "black" title "RK4 dt = T/80"
replot "../data/RK4.dat" using 1:5 index 2 w l lw 1.0 lc rgb "green" title "RK4 dt = T/100"
replot "../data/RK4.dat" using 1:5 index 3 w l lw 1.0 lc rgb "orange" title "RK4 dt = T/200"



# --------------------------------------------------------------------------- #
#                                   Orbite                                    #
# --------------------------------------------------------------------------- #

# --------------------------------- dt = 1.0 -------------------------------- #
reset

# Canva dimensions
set term qt 3 size 600,400
set title "Particle in EM Field Rotation \\ Orbits 1 \\ \Delta t = 1.0"
set xlabel "x"  font ",14"
set ylabel "y"  font ",14"

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
    "../data/BORIS.dat" using 2:3 index 0 w l lw 0.5 lc rgb "red" title "Boris", \
    "../data/RK4.dat" using 2:3 index 0 w l lw 0.5 lc rgb "blue" title "RK4", \
    x(t), y(t) w l lw 1.5 lc rgb "black" notitle

unset parametric

# -------------------------------- dt = 0.01 -------------------------------- #
reset

# Canva dimensions
set term qt 4 size 600,400
set title "Particle in EM Field Rotation \\ Orbits 2 \\ \Delta t = 0.01"
set xlabel "x"  font ",14"
set ylabel "y"  font ",14"

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
    "../data/BORIS.dat" using 2:3 index 2 w l lw 1 lc rgb "red" title "Boris", \
    "../data/RK4.dat" using 2:3 index 2 w l lw 1 lc rgb "blue" title "RK4", \
    x(t), y(t) w l lw 1 lc rgb "black" notitle

unset parametric

# ---------------------------- Boris 3d dt = 1.0 ---------------------------- #
reset

# Canva dimensions
set term qt 5 size 600,400
set title "Particle in EM Field Rotation \\ Orbits 3 \\ \Delta t = 0.01"
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