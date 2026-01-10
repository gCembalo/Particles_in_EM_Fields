reset

# plots Particle in EM Field (Parallel configuration)

# --------------------------------------------------------------------------- #
#                                   Orbita                                    #
# --------------------------------------------------------------------------- #

# ---------------------------- Boris 3d dt = 0.01 ---------------------------- #
reset

# Canva dimensions
set term qt 1 size 600,400
set title "t = 100.0 ; \Delta t = 0.01" font ",16"
set xlabel "x"  font ",16"
set ylabel "y"  font ",16"
set zlabel "z"  font ",16"

set key font ",14"
set key top right
set key spacing 1.2
set tics font ",14"

# Setting axis' range
set xrange[-1:1]
set yrange[-1:1]
set zrange[-1:3000]

# Setting grid
set grid xtics ytics ztics

# 3D View
set view 60, 30     # angles (elevazione, azimut)
set ticslevel 0     # xy

# Stile linea
set style line 1 lw 2 lc rgb "purple"

# Plotting the data
splot "../data/BORIS.dat" using 2:3:4 index 2 w l ls 1 lc rgb "blue" title "Boris"