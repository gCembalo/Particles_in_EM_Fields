# plots Particle in EM Field (Rotation)

# --------------------------------------------------------------------------- #
#                              Energia cinetica                               #
# --------------------------------------------------------------------------- #
reset

# Canva dimensions
set term qt 1 size 600,400
#set title "Energia cinetica" font ",16"
set xlabel "t"  font ",16"
set ylabel "Energia cinetica"  font ",16"

set key font ",14"
set key top right
set key spacing 1.2
set tics font ",14"

# Setting axis' range
set xrange[-10:160]
set yrange[-0.05:0.6]

# Setting log scale
# set logscale y
# set logscale x

# Setting grid
set grid

# Plotting the data
plot "../data/BORIS.dat" using 1:5 index 0 w l lw 2.0 lc rgb "blue" title "Boris dt = 1.0"
replot "../data/RK4.dat" using 1:5 index 0 w l lw 2.0 lc rgb "red" title "RK4 dt = T/60"
replot "../data/RK4.dat" using 1:5 index 1 w l lw 2.0 lc rgb "black" title "RK4 dt = T/80"
replot "../data/RK4.dat" using 1:5 index 2 w l lw 2.0 lc rgb "green" title "RK4 dt = T/100"
replot "../data/RK4.dat" using 1:5 index 3 w l lw 2.0 lc rgb "orange" title "RK4 dt = T/200"
replot "../data/RK4.dat" using 1:5 index 4 w l lw 2.0 lc rgb "purple" title "RK4 dt = T/1000"