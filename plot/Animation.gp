# plots Particle in EM Field (Rotation)

# --------------------------------------------------------------------------- #
#                               RK4 Animation                                 #
# --------------------------------------------------------------------------- #
reset

# ================= TERMINALE =================
# Live
set term qt 1 size 1300,600

# GIF (per consegna)
# set term gif animate delay 5 size 1300,600
# set output "RK4_vs_BORIS_Xpoint.gif"

# ================= DOMINIO =================
set xrange [-1000:1000]
set yrange [-1000:1000]
set size ratio -1

# ================= COLORI =================
set cbrange [0:0.5]
set palette rgb 33,13,10
set pointsize 0.35

set xlabel "x"
set ylabel "y"

vmag(vx,vy) = sqrt(vx*vx + vy*vy)

# ================= CAMPO MAGNETICO =================
# linee: y^2 - x^2 = C
C1 = 2.5e5
C2 = 1.0e5
C3 = -1.0e5
C4 = -2.5e5

f1(x) =  sqrt(x*x + C1)
f2(x) = -sqrt(x*x + C1)
f3(x) =  sqrt(x*x + C2)
f4(x) = -sqrt(x*x + C2)
f5(x) =  sqrt(x*x + C3)
f6(x) = -sqrt(x*x + C3)
f7(x) =  sqrt(x*x + C4)
f8(x) = -sqrt(x*x + C4)

# ================= MULTIPLOT =================
set multiplot layout 1,2 rowsfirst

do for [n=0:300] {

    # ---------- TITOLO GLOBALE ----------
    set label 99 sprintf("Particle motion in X-point magnetic field  (step %d)", n) \
        at screen 0.5,0.97 center font ",14"

    # ---------- RK4 ----------
    set title "RK4"
    plot \
        sprintf("RK4_%04d.dat", n) using 1:2:(vmag($3,$4)) \
            with points palette notitle, \
        f1(x) w l lc rgb "black" lw 1 notitle, \
        f2(x) w l lc rgb "black" lw 1 notitle, \
        f3(x) w l lc rgb "black" lw 1 notitle, \
        f4(x) w l lc rgb "black" lw 1 notitle, \
        f5(x) w l lc rgb "black" lw 1 notitle, \
        f6(x) w l lc rgb "black" lw 1 notitle, \
        f7(x) w l lc rgb "black" lw 1 notitle, \
        f8(x) w l lc rgb "black" lw 1 notitle

    # ---------- BORIS ----------
    set title "Boris"
    plot \
        sprintf("BORIS_%04d.dat", n) using 1:2:(vmag($3,$4)) \
            with points palette notitle, \
        f1(x) w l lc rgb "black" lw 1 notitle, \
        f2(x) w l lc rgb "black" lw 1 notitle, \
        f3(x) w l lc rgb "black" lw 1 notitle, \
        f4(x) w l lc rgb "black" lw 1 notitle, \
        f5(x) w l lc rgb "black" lw 1 notitle, \
        f6(x) w l lc rgb "black" lw 1 notitle, \
        f7(x) w l lc rgb "black" lw 1 notitle, \
        f8(x) w l lc rgb "black" lw 1 notitle

    unset label 99
}

unset multiplot
unset output



# --------------------------------------------------------------------------- #
#                                   CODE                                      #
# --------------------------------------------------------------------------- #


// ------------------------ Creating the animation ---------------------- //
    // Vector to save the data at each time step to create an animation
    double YRK4_all[N_Part][6];
    double YBor_all[N_Part][6];

    int n = 0; // Time index
    int step = 0;
    t = 0.0;   // Inizialise the time

    int output_stride = 10;   // Save a frame every 10 step

    // Fill the vector with the initial condition
    for( i = 0 ; i < N_Part ; i++ ){

        InitialCondition(YRK4_all[i]);
        InitialCondition(YBor_all[i]);

    }

    char fname[256];

    while(t <= TL){
    if (step % output_stride == 0) {

        // Creating the data file for this step
        snprintf(fname, sizeof(fname), "../data/animation/RK4_%04d.dat", n);
        ofstream foutRK4(fname);

        snprintf(fname, sizeof(fname), "../data/animation/BORIS_%04d.dat", n);
        ofstream foutBOR(fname);

        // Writing data files for this time step
        for( i = 0 ; i < N_Part ; i++ ){

            foutRK4 << YRK4_all[i][0] << " "
                    << YRK4_all[i][1] << " "
                    << YRK4_all[i][3] << " "
                    << YRK4_all[i][4] << " "
                    << YRK4_all[i][5] << "\n";

            foutBOR << YBor_all[i][0] << " "
                    << YBor_all[i][1] << " "
                    << YBor_all[i][3] << " "
                    << YBor_all[i][4] << " "
                    << YBor_all[i][5] << "\n";
        }

        foutRK4.close();
        foutBOR.close();
    }

        // Solving the equation for each method
        for( i = 0 ; i < N_Part ; i++ ){

            if( fabs(YRK4_all[i][0]) < X_L && fabs(YRK4_all[i][1]) < Y_L ){

                RK4Step(t, YRK4_all[i], EB, RHSFunc, dt, neq);

            }

            if( fabs(YBor_all[i][0]) < X_L && fabs(YBor_all[i][1]) < Y_L ){

                BorisStep(t, YBor_all[i], EB, dt);

            }

        }

        t += dt;
        n++;

    }