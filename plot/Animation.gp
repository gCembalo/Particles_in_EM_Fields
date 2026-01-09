# plots Particle in EM Field (Rotation)

# --------------------------------------------------------------------------- #
#                                 Animation                                   #
# --------------------------------------------------------------------------- #
reset

# ================= IMPOSTAZIONI TERMINALE =================
set term qt size 1300,600 noraise
set samples 500

# ================= DOMINIO E STILE =================
set xrange [-1000:1000]
set yrange [-1000:1000]
set size ratio -1
set xlabel "x"
set ylabel "y"
set cbrange [0:0.5]
set palette rgb 33,13,10
set pointsize 0.8  # Leggermente più grande per visibilità

# ================= CAMPO MAGNETICO (SAFE) =================
C1 = 2.5e5; C2 = 1.0e5; C3 = -1.0e5; C4 = -2.5e5
safe_sqrt(v) = (v >= 0) ? sqrt(v) : 1/0

f1(x) =  sqrt(x*x + C1); f2(x) = -sqrt(x*x + C1)
f3(x) =  sqrt(x*x + C2); f4(x) = -sqrt(x*x + C2)
f5(x) =  safe_sqrt(x*x + C3); f6(x) = -safe_sqrt(x*x + C3)
f7(x) =  safe_sqrt(x*x + C4); f8(x) = -safe_sqrt(x*x + C4)

# Macro per abbreviare il plot delle linee di campo
FIELD_LINES = "f1(x) w l lc 'gray' dt 2 notitle, f2(x) w l lc 'gray' dt 2 notitle, \
               f3(x) w l lc 'gray' dt 2 notitle, f4(x) w l lc 'gray' dt 2 notitle, \
               f5(x) w l lc 'gray' dt 2 notitle, f6(x) w l lc 'gray' dt 2 notitle, \
               f7(x) w l lc 'gray' dt 2 notitle, f8(x) w l lc 'gray' dt 2 notitle"

vmag(vx,vy,vz) = sqrt(vx*vx + vy*vy + vz*vz)

# ================= LOOP DI ANIMAZIONE =================
do for [n=0:300] {
    
    set multiplot layout 1,2 rowsfirst \
        title sprintf("{/Bold Particle Motion in X-point Field} - Frame: %d", n)

    # ----- RK4 -----
    set title "RK4 (Explicit 4th Order)"
    file_rk4 = sprintf("../data/animation/RK4_%04d.dat", n)
    plot file_rk4 using 1:2:(vmag($3,$4,$5)) with points palette pt 7 notitle, \
         @FIELD_LINES

    # ----- BORIS -----
    set title "Boris Pusher (Semi-implicit)"
    file_boris = sprintf("../data/animation/BORIS_%04d.dat", n)
    plot file_boris using 1:2:(vmag($3,$4,$5)) with points palette pt 7 notitle, \
         @FIELD_LINES

    unset multiplot
    
    # Piccolo trucco: se n=0 aspetta un attimo per dare tempo all'utente di guardare
    if (n==0) { pause 1 }
    pause 0.02
}



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