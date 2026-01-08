# plots Particles in EM Field

# --------------------------------------------------------------------------- #
#                                 Power plot                                  #
# --------------------------------------------------------------------------- #

# ----------------------------------- RK4 ----------------------------------- #
reset

# Canva dimensions
set term qt 1 size 600,400
set title "Particle in EM Field ; RK4 ; t = 1000" font ",14"
set xlabel "Energia cinetica"  font ",14"
set ylabel "#"  font ",14"

# Stile di default per la parte blu (trasparente)
# Quella rossa essendo ad una sola energia non verrebbe visualizzata
set style fill transparent solid 0.5 noborder

# Setting axis' range
set xrange[1:1000]
set yrange[1:1000]

# 3. bin definition (per scala logaritmica è meglio usarne molti)
bin_width = 100.0 
bin(x, width) = width * floor(x / width) + width / 2.0

# Setting grid
set grid

# Set the log scale
set logscale xy
set grid xtics ytics mxtics mytics

# 4. Definizione della legge di potenza (linea rossa)
# Fix the constant (50) to adapt f(x) to your data
f(x) = 200 * x**(-1.7)

# Plotting the data
plot "../data/RK4.dat" index 1 using (bin($5, bin_width)):(1.0) smooth frequency \
     with lines lc rgb "red" lw 2 title "RK4", \
     f(x) with lines lc rgb "black" lw 2 title "E_k^{-0.7}"


# ---------------------------------- Boris --------------------------------- #
reset

# Canva dimensions
set term qt 2 size 600,400
set title "Particle in EM Field ; Boris ; t = 1000" font ",14"
set xlabel "Energia cinetica"  font ",14"
set ylabel "#"  font ",14"

# Stile di default per la parte blu (trasparente)
# Quella rossa essendo ad una sola energia non verrebbe visualizzata
set style fill transparent solid 0.5 noborder

# Setting axis' range
set xrange[1:1000]
set yrange[1:1000]

# 3. bin definition (per scala logaritmica è meglio usarne molti)
bin_width = 40.0 
bin(x, width) = width * floor(x / width) + width / 2.0

# Setting grid
set grid

# Set the log scale
set logscale xy
set grid xtics ytics mxtics mytics

# 4. Definizione della legge di potenza (linea rossa)
# Fix the constant (50) to adapt f(x) to your data
f(x) = 100000 * x**(-2)

# Plotting the data
plot "../data/Boris.dat" index 1 using (bin($5, bin_width)):(1.0) smooth frequency \
     with lines lc rgb "blue" lw 2 title "Boris", \
     f(x) with lines lc rgb "black" lw 2 title "E_k^{-0.7}"