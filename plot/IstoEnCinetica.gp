# plots Particles in EM Field

# --------------------------------------------------------------------------- #
#                                 Istogramma                                  #
# --------------------------------------------------------------------------- #

# ----------------------------------- RK4 ----------------------------------- #
reset

# Canva dimensions
set term qt 1 size 600,400
set title "Particle in EM Field ; Evoluzione della distribuzione di Energia Cinetica ; RK4" font ",14"
set xlabel "Energia cinetica"  font ",14"
set ylabel "# Particelle"  font ",14"

# Stile di default per la parte blu (trasparente)
# Quella rossa essendo ad una sola energia non verrebbe visualizzata
set style fill transparent solid 0.5 noborder

# Setting axis' range
set xrange[-1:10]
set yrange[0:350]

# Setting grid
set grid

# Defining bin width
bin_width = 0.1
bin(x, width) = width * floor(x / width) + width / 2.0

# Plotting the data
plot "../data/RK4.dat" u (bin($5, bin_width)):(0.1) index 0 smooth frequency with boxes lt 1 lc rgb "#ff8888" lw 1.5 fs solid 1.0 border lc rgb "red" title "t = 0 (riscalata x 0.1)", \
     "../data/RK4.dat" u (bin($5, bin_width)):(1.0) index 1 smooth frequency with boxes lc rgb "orange" title "t = 1000"


# ---------------------------------- Boris --------------------------------- #
reset

# Canva dimensions
set term qt 2 size 600,400
set title "Particle in EM Field ; Evoluzione della distribuzione di Energia Cinetica ; Boris" font ",14"
set xlabel "Energia cinetica"  font ",14"
set ylabel "# Particelle"  font ",14"

# Stile di default per la parte blu (trasparente)
# Quella rossa essendo ad una sola energia non verrebbe visualizzata
set style fill transparent solid 0.5 noborder

# Setting axis' range
set xrange[-1:10]
set yrange[0:350]

# Setting grid
set grid

# Defining bin width
bin_width = 0.1
bin(x, width) = width * floor(x / width) + width / 2.0

# Plotting the data
plot "../data/BORIS.dat" u (bin($5, bin_width)):(0.1) index 0 smooth frequency with boxes lt 1 lc rgb "#000b61ff" lw 1.5 fs solid 1.0 border lc rgb "blue" title "t = 0 (riscalata x 0.1)", \
     "../data/BORIS.dat" u (bin($5, bin_width)):(1.0) index 1 smooth frequency with boxes lc rgb "purple" title "t = 1000"