# plots Particles in EM Field

# --------------------------------------------------------------------------- #
#                                   Boris                                     #
# --------------------------------------------------------------------------- #

# ---------------------------- Boris 3d t = 0.0 ----------------------------- #
reset

# Setting the 3d map
set pm3d map

set palette defined ( 0 '#000090',\
                      1 '#000fff',\
                      2 '#0090ff',\
                      3 '#0fffee',\
                      4 '#90ff70',\
                      5 '#ffee00',\
                      6 '#ff7000',\
                      7 '#ee0000',\
                      8 '#7f0000')

unset colorbox
set colorbox vertical
set cblabel "Energia cinetica" font ",16"
set cbrange [0:10] # Regola in base ai tuoi dati (l'immagine mostra 0-10)

# Palette standard "Rainbow" simile all'immagine
set palette rgbformulae 33,13,10

# Canva dimensions
set term qt 1 size 600,400
set title "Boris ; t = 0" font ",16"
set xlabel "x"  font ",16"
set ylabel "y"  font ",16"

set key font ",14"
set tics font ",14"

# Settiamo axis' range
set xrange[-1000:1000]
set yrange[-1000:1000]

# Adding some draw (the X for the multiparticle problem)
set parametric
set trange [-3:3] # range for the functions

# Parameter
a = 400
b = 400
c = 600
d = 600
e = 800
f = 800

# Hyperbolas (with a,b)
xha(t) = a*cosh(t)
yha(t) = b*sinh(t)
xha2(t) = -a*cosh(t)
yha2(t) =  b*sinh(t)
xva(t) = b*sinh(t)
yva(t) = a*cosh(t)
xva2(t) = b*sinh(t)
yva2(t) = -a*cosh(t)

# Hyperbolas (with c,d)
xhc(t) = c*cosh(t)
yhc(t) = d*sinh(t)
xhc2(t) = -c*cosh(t)
yhc2(t) =  d*sinh(t)
xvc(t) = d*sinh(t)
yvc(t) = c*cosh(t)
xvc2(t) = d*sinh(t)
yvc2(t) = -c*cosh(t)

# Hyperbolas (with e,f)
xhe(t) = e*cosh(t)
yhe(t) = f*sinh(t)
xhe2(t) = -e*cosh(t)
yhe2(t) =  f*sinh(t)
xve(t) = f*sinh(t)
yve(t) = e*cosh(t)
xve2(t) = f*sinh(t)
yve2(t) = -e*cosh(t)

# Lines y = ±x (parametric form!)
xl(t)  = 1000*t/3
yl(t)  = 1000*t/3
xl2(t) = 1000*t/3
yl2(t) = -1000*t/3

# Plotting the data and function for X shape
plot \
    "../data/BORIS.dat" index 0 using 2:3:5 w p ps 0.3 lc palette notitle, \
    xl(t),  yl(t)    w l lw 0.5 lc rgb "gray" notitle, \
    xl2(t), yl2(t)   w l lw 0.5 lc rgb "gray" notitle, \
    xha(t),  yha(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xha2(t), yha2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xva(t),  yva(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xva2(t), yva2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xhc(t),  yhc(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xhc2(t), yhc2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xvc(t),  yvc(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xvc2(t), yvc2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xhe(t),  yhe(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xhe2(t), yhe2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xve(t),  yve(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xve2(t), yve2(t) w l lw 0.5 lc rgb "gray" notitle

unset parametric


# ---------------------------- Boris 3d t = ---.0 ---------------------------- #
reset

# Setting the 3d map
set pm3d map

set palette defined ( 0 '#000090',\
                      1 '#000fff',\
                      2 '#0090ff',\
                      3 '#0fffee',\
                      4 '#90ff70',\
                      5 '#ffee00',\
                      6 '#ff7000',\
                      7 '#ee0000',\
                      8 '#7f0000')

unset colorbox
set colorbox vertical
set cblabel "Energia cinetica" font ",16"
set cbrange [0:10] # Regola in base ai tuoi dati (l'immagine mostra 0-10)

# Palette standard "Rainbow" simile all'immagine
set palette rgbformulae 33,13,10

# Canva dimensions
set term qt 2 size 600,400
set title "Boris ; t = ---" font ",16"
set xlabel "x"  font ",16"
set ylabel "y"  font ",16"

set key font ",14"
set tics font ",14"

# Settiamo axis' range
set xrange[-1000:1000]
set yrange[-1000:1000]

# Adding some draw (the X for the multiparticle problem)
set parametric
set trange [-3:3] # range for the functions

# Parameter
a = 400
b = 400
c = 600
d = 600
e = 800
f = 800

# Hyperbolas (with a,b)
xha(t) = a*cosh(t)
yha(t) = b*sinh(t)
xha2(t) = -a*cosh(t)
yha2(t) =  b*sinh(t)
xva(t) = b*sinh(t)
yva(t) = a*cosh(t)
xva2(t) = b*sinh(t)
yva2(t) = -a*cosh(t)

# Hyperbolas (with c,d)
xhc(t) = c*cosh(t)
yhc(t) = d*sinh(t)
xhc2(t) = -c*cosh(t)
yhc2(t) =  d*sinh(t)
xvc(t) = d*sinh(t)
yvc(t) = c*cosh(t)
xvc2(t) = d*sinh(t)
yvc2(t) = -c*cosh(t)

# Hyperbolas (with e,f)
xhe(t) = e*cosh(t)
yhe(t) = f*sinh(t)
xhe2(t) = -e*cosh(t)
yhe2(t) =  f*sinh(t)
xve(t) = f*sinh(t)
yve(t) = e*cosh(t)
xve2(t) = f*sinh(t)
yve2(t) = -e*cosh(t)

# Lines y = ±x (parametric form!)
xl(t)  = 1000*t/3
yl(t)  = 1000*t/3
xl2(t) = 1000*t/3
yl2(t) = -1000*t/3

# Plotting the data and function for X shape
plot \
    "../data/BORIS.dat" using 2:3:5 index 1 w p ps 0.3 lc palette notitle, \
    xl(t),  yl(t)    w l lw 0.5 lc rgb "gray" notitle, \
    xl2(t), yl2(t)   w l lw 0.5 lc rgb "gray" notitle, \
    xha(t),  yha(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xha2(t), yha2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xva(t),  yva(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xva2(t), yva2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xhc(t),  yhc(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xhc2(t), yhc2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xvc(t),  yvc(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xvc2(t), yvc2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xhe(t),  yhe(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xhe2(t), yhe2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xve(t),  yve(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xve2(t), yve2(t) w l lw 0.5 lc rgb "gray" notitle

unset parametric


# --------------------------------------------------------------------------- #
#                                   RK4                                       #
# --------------------------------------------------------------------------- #

# ---------------------------- RK4 3d t = 0.0 ------------------------------- #
reset

# Setting the 3d map
set pm3d map

set palette defined ( 0 '#000090',\
                      1 '#000fff',\
                      2 '#0090ff',\
                      3 '#0fffee',\
                      4 '#90ff70',\
                      5 '#ffee00',\
                      6 '#ff7000',\
                      7 '#ee0000',\
                      8 '#7f0000')

unset colorbox
set colorbox vertical
set cblabel "Energia cinetica" font ",16"
set cbrange [0:10] # Regola in base ai tuoi dati (l'immagine mostra 0-10)

# Palette standard "Rainbow" simile all'immagine
set palette rgbformulae 33,13,10

# Canva dimensions
set term qt 3 size 600,400
set title "RK4 ; t = 0" font ",16"
set xlabel "x"  font ",16"
set ylabel "y"  font ",16"

set key font ",14"
set tics font ",14"

# Settiamo axis' range
set xrange[-1000:1000]
set yrange[-1000:1000]

# Adding some draw (the X for the multiparticle problem)
set parametric
set trange [-3:3] # range for the functions

# Parameter
a = 400
b = 400
c = 600
d = 600
e = 800
f = 800

# Hyperbolas (with a,b)
xha(t) = a*cosh(t)
yha(t) = b*sinh(t)
xha2(t) = -a*cosh(t)
yha2(t) =  b*sinh(t)
xva(t) = b*sinh(t)
yva(t) = a*cosh(t)
xva2(t) = b*sinh(t)
yva2(t) = -a*cosh(t)

# Hyperbolas (with c,d)
xhc(t) = c*cosh(t)
yhc(t) = d*sinh(t)
xhc2(t) = -c*cosh(t)
yhc2(t) =  d*sinh(t)
xvc(t) = d*sinh(t)
yvc(t) = c*cosh(t)
xvc2(t) = d*sinh(t)
yvc2(t) = -c*cosh(t)

# Hyperbolas (with e,f)
xhe(t) = e*cosh(t)
yhe(t) = f*sinh(t)
xhe2(t) = -e*cosh(t)
yhe2(t) =  f*sinh(t)
xve(t) = f*sinh(t)
yve(t) = e*cosh(t)
xve2(t) = f*sinh(t)
yve2(t) = -e*cosh(t)

# Lines y = ±x (parametric form!)
xl(t)  = 1000*t/3
yl(t)  = 1000*t/3
xl2(t) = 1000*t/3
yl2(t) = -1000*t/3

# Plotting the data and function for X shape
plot \
    "../data/RK4.dat" using 2:3:5 index 0 w p ps 0.3 lc palette notitle, \
    xl(t),  yl(t)    w l lw 0.5 lc rgb "gray" notitle, \
    xl2(t), yl2(t)   w l lw 0.5 lc rgb "gray" notitle, \
    xha(t),  yha(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xha2(t), yha2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xva(t),  yva(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xva2(t), yva2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xhc(t),  yhc(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xhc2(t), yhc2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xvc(t),  yvc(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xvc2(t), yvc2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xhe(t),  yhe(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xhe2(t), yhe2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xve(t),  yve(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xve2(t), yve2(t) w l lw 0.5 lc rgb "gray" notitle

unset parametric


# ---------------------------- RK4 3d t = ---.0 ---------------------------- #
reset

# Setting the 3d map
set pm3d map

set palette defined ( 0 '#000090',\
                      1 '#000fff',\
                      2 '#0090ff',\
                      3 '#0fffee',\
                      4 '#90ff70',\
                      5 '#ffee00',\
                      6 '#ff7000',\
                      7 '#ee0000',\
                      8 '#7f0000')

unset colorbox
set colorbox vertical
set cblabel "Energia cinetica" font ",16"
set cbrange [0:10] # Regola in base ai tuoi dati (l'immagine mostra 0-10)

# Palette standard "Rainbow" simile all'immagine
set palette rgbformulae 33,13,10

# Canva dimensions
set term qt 4 size 600,400
set title "RK4 ; t = ---" font ",16"
set xlabel "x"  font ",16"
set ylabel "y"  font ",16"

set key font ",14"
set tics font ",14"

# Settiamo axis' range
set xrange[-1000:1000]
set yrange[-1000:1000]

# Adding some draw (the X for the multiparticle problem)
set parametric
set trange [-3:3] # range for the functions

# Parameter
a = 400
b = 400
c = 600
d = 600
e = 800
f = 800

# Hyperbolas (with a,b)
xha(t) = a*cosh(t)
yha(t) = b*sinh(t)
xha2(t) = -a*cosh(t)
yha2(t) =  b*sinh(t)
xva(t) = b*sinh(t)
yva(t) = a*cosh(t)
xva2(t) = b*sinh(t)
yva2(t) = -a*cosh(t)

# Hyperbolas (with c,d)
xhc(t) = c*cosh(t)
yhc(t) = d*sinh(t)
xhc2(t) = -c*cosh(t)
yhc2(t) =  d*sinh(t)
xvc(t) = d*sinh(t)
yvc(t) = c*cosh(t)
xvc2(t) = d*sinh(t)
yvc2(t) = -c*cosh(t)

# Hyperbolas (with e,f)
xhe(t) = e*cosh(t)
yhe(t) = f*sinh(t)
xhe2(t) = -e*cosh(t)
yhe2(t) =  f*sinh(t)
xve(t) = f*sinh(t)
yve(t) = e*cosh(t)
xve2(t) = f*sinh(t)
yve2(t) = -e*cosh(t)

# Lines y = ±x (parametric form!)
xl(t)  = 1000*t/3
yl(t)  = 1000*t/3
xl2(t) = 1000*t/3
yl2(t) = -1000*t/3

# Plotting the data and function for X shape
plot \
    "../data/RK4.dat" using 2:3:5 index 1 w p ps 0.3 lc palette notitle, \
    xl(t),  yl(t)    w l lw 0.5 lc rgb "gray" notitle, \
    xl2(t), yl2(t)   w l lw 0.5 lc rgb "gray" notitle, \
    xha(t),  yha(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xha2(t), yha2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xva(t),  yva(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xva2(t), yva2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xhc(t),  yhc(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xhc2(t), yhc2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xvc(t),  yvc(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xvc2(t), yvc2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xhe(t),  yhe(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xhe2(t), yhe2(t) w l lw 0.5 lc rgb "gray" notitle, \
    xve(t),  yve(t)  w l lw 0.5 lc rgb "gray" notitle, \
    xve2(t), yve2(t) w l lw 0.5 lc rgb "gray" notitle

unset parametric