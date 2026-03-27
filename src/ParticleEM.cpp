////////////////////////////////////////////////////////////////////////////////
//              Name    : Gabriele Cembalo                                    //
//              A.Y.    : 2025-2026                                           //
//              Project : Particle(s) in Electromagnetic Fields               //
//                                                                            //
//              Starting date : 24-12-2025                                    //
//              Ending date   : 15-01-2026                                    //
////////////////////////////////////////////////////////////////////////////////

#include <iostream>
#include <iomanip>
#include <cmath>
#include <ctime>
#include <fstream>
#include <cstdlib>

using namespace std;

////////////////////////////////////////////////////////////////////////////////
//                            Macro declaration                               //
////////////////////////////////////////////////////////////////////////////////
#define STAGE 4      // Choose the problem type (1 to 4)
                     // 1,2,3 : single particle
                     // 4     : multiple particles (N_Part)
#define NMAX_EQ 64   // Maximum number of elements (safety limit)
                     // to avoid variable-size arrays
#define N_Part 2000  // Number of particles in the multi-particle problem
#define X_L 1000.0   // Boundary half-width along X axis for STAGE 4
#define Y_L 1000.0   // Boundary half-width along Y axis for STAGE 4
#define TL 100.0     // Simulation's final time

////////////////////////////////////////////////////////////////////////////////
//                          Functions declaration                             //
////////////////////////////////////////////////////////////////////////////////
void EB_Fields(double *, double *);
void InitialCondition(double *);
void RHSFunc(double, double *, double *, double *);
void RK4Step(double, double *, double *,
             void (*)(double, double *, double *, double *), 
             double, int);
void BorisStep(double, double *, double *, double);

////////////////////////////////////////////////////////////////////////////////
//                       Main function implementation                         //
////////////////////////////////////////////////////////////////////////////////
int main(){

    ofstream fdata1 , fdata2 , fdata3;
    fdata1.open("../data/RK4.dat");   // Solutions file
    fdata2.open("../data/BORIS.dat"); // Solutions file
    fdata3.open("../data/ERR.dat");   // Error file

    fdata1 << setiosflags ( ios::scientific );
    fdata1 << setprecision ( 10 );
    fdata2 << setiosflags ( ios::scientific );
    fdata2 << setprecision ( 10 );
    fdata3 << setiosflags ( ios::scientific );
    fdata3 << setprecision ( 10 );

    cout << setiosflags ( ios::scientific );
    cout << setprecision ( 7 );

    int neq = 6; // Number of equations
    int i , j;   // Loop index
    int k = 0;   // Control variable to check if in multiparticle problem they
                 // go outside the EB field region.

    int n_time = 3;  // Number of different time step

    double t = 0.0;                      // Time variable
    double dt = 0.01;                    // Time step
    double dt_vec[] = {1.0, 0.1, 0.01};  // Vector to change the time step
    double errRK4 = 0.0 , errBor = 0.0;  // Error variables

    // Uncomment the following vector to use it in the Kinetic energy plot:
    //double dt_vec[] = {1.66, 1.25, 1.0, 0.5, 0.1};
    //int n_time = 5; // Number of different time step in the Kinetic energy plot

    double YRK4[neq] , YBor[neq]; // Solutions vector (for each method)
                                  // (x, y, z)    = (Y[0], Y[1], Y[2])
                                  // (vx, vy, vz) = (Y[3], Y[4], Y[5])

    double EB[neq]; // Electromagnetic field
                    // (Ex, Ey, Ez) = (EB[0], EB[1], EB[2])
                    // (Bx, By, Bz) = (EB[3], EB[4], EB[5])

    #if STAGE == 1 || STAGE == 2 || STAGE == 3  // Single particle problem

    // Solve the equation with each method with different time step
    // The ElectroMagnetic field will be set inside each method
    for( i = 0 ; i < n_time ; i++ ){

        dt = dt_vec[i]; // Set the time step

        // Set the initial condition
        InitialCondition(YRK4);
        InitialCondition(YBor);

        t = 0.0;

        // Print the initial condition (t, x, y, z, 0.5 v^2)
        fdata1 << t << "  " << YRK4[0] << "  " << YRK4[1] << "  " << YRK4[2] 
               << "  "
               << 0.5*(YRK4[3]*YRK4[3] + YRK4[4]*YRK4[4] + YRK4[5]*YRK4[5])
               << endl;
        fdata2 << t << "  " << YBor[0] << "  " << YBor[1] << "  " << YBor[2] 
               << "  "
               << 0.5*(YBor[3]*YBor[3] + YBor[4]*YBor[4] + YBor[5]*YBor[5])
               << endl;

        // Solve the equation
        for( j = 0 ; t < TL ; j++ ){

            RK4Step(t, YRK4, EB, RHSFunc, dt, neq);
            BorisStep(t, YBor, EB, dt);

            t += dt; // increasing time

            // Print in the data file (t, x, y, z, 0.5 v^2)
            fdata1 << t << "  " << YRK4[0] << "  " << YRK4[1] << "  " << YRK4[2] 
                   << "  "
                   << 0.5*(YRK4[3]*YRK4[3] + YRK4[4]*YRK4[4] + YRK4[5]*YRK4[5])
                   << endl;
            fdata2 << t << "  " << YBor[0] << "  " << YBor[1] << "  " << YBor[2] 
                   << "  "
                   << 0.5*(YBor[3]*YBor[3] + YBor[4]*YBor[4] + YBor[5]*YBor[5])
                   << endl;

        }

        fdata1 << endl << endl; // Skip 2 line in the data file
        fdata2 << endl << endl;

        // Compute the error as the difference between numerical 
        // and analytical solutions at t.
        errRK4 = sqrt( (YRK4[0] - sin(t))*(YRK4[0] - sin(t)) +
                       (YRK4[1] - cos(t))*(YRK4[1] - cos(t)) );
        errBor = sqrt( (YBor[0] - sin(t))*(YBor[0] - sin(t)) +
                       (YBor[1] - cos(t))*(YBor[1] - cos(t)) );

        // Print the error in data file
        fdata3 << dt << "  " << errRK4 << "  " << errBor << endl;

    }

    #elif STAGE == 4  // Multiparticle problem

    // We need to generate some random quantities (used in InitialCondition)
    srand48(time(NULL));

    // Print the initial condition
    for( i = 0 ; i < N_Part ; i++ ){

        // Set the initial condition
        InitialCondition(YRK4);
        InitialCondition(YBor);

        // Print in the data file (t, x, y, z, 0.5 v^2)
        fdata1 << t << "  " << YRK4[0] << "  " << YRK4[1] << "  " << YRK4[2] 
               << "  "
               << 0.5*(YRK4[3]*YRK4[3] + YRK4[4]*YRK4[4] + YRK4[5]*YRK4[5])
               << endl;
        fdata2 << t << "  " << YBor[0] << "  " << YBor[1] << "  " << YBor[2] 
               << "  "
               << 0.5*(YBor[3]*YBor[3] + YBor[4]*YBor[4] + YBor[5]*YBor[5])
               << endl;
        
    }

    fdata1 << endl << endl; // Skip 2 line in the data file
    fdata2 << endl << endl;

    // Solve the equation with each method with different time step
    // The ElettroMagnetic field will be set inside each method
    for( i = 0 ; i < N_Part ; i++ ){

        // Set the initial condition
        InitialCondition(YRK4);

        t = 0.0; // Setting the starting time

        // Solve the equation
        for( j = 0 ; t < TL ; j++ ){

            k = 0;

            // Use 'k' as a flag to check if the particle leaves the 
            // computational domain. If so, we break the loop.
            if( YRK4[0] < -X_L || YRK4[0] > X_L 
                || YRK4[1] < -Y_L || YRK4[1] > Y_L ){
                
                    k = 1;
                    break;

            }

            RK4Step(t, YRK4, EB, RHSFunc, dt, neq);

            t += dt; // increasing time

        }

        if( k == 0 ){

            // Print in the data file (t, x, y, z, 0.5 v^2)
            fdata1 << t << "  " << YRK4[0] << "  " << YRK4[1] << "  " << YRK4[2] 
                   << "  "
                   << 0.5*(YRK4[3]*YRK4[3] + YRK4[4]*YRK4[4] + YRK4[5]*YRK4[5])
                   << endl;

        }

    }

    for( i = 0 ; i < N_Part ; i++ ){

        // Set the initial condition
        InitialCondition(YBor);

        t = 0.0; // Setting the starting time

        // Solve the equation
        for( j = 0 ; t < TL ; j++ ){

            k = 0;

            // We'll use the integer k to check if our solution are going
            // outside the integral region. If so, we break the loop.
            if( YBor[0] < -X_L || YBor[0] > X_L 
                || YBor[1] < -Y_L || YBor[1] > Y_L ){
                
                    k = 1;
                    break;

            }

            BorisStep(t, YBor, EB, dt);

            t += dt; // Increasing time

        }

        if( k == 0 ){

            // Print in the data file (t, x, y, z, 0.5 v^2)
            fdata2 << t << "  " << YBor[0] << "  " << YBor[1] << "  " << YBor[2] 
                   << "  "
                   << 0.5*(YBor[3]*YBor[3] + YBor[4]*YBor[4] + YBor[5]*YBor[5])
                   << endl;

        }

    }

    #endif

    fdata1.close();
    fdata2.close();
    fdata3.close();

    return 0;

}

////////////////////////////////////////////////////////////////////////////////
//                         Functions implementation                           //
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Electric and magnetic fields.                                              //
// Input: pointer to the solution vector,                                     //
//        pointer to the electric and magnetic field vector.                  //
////////////////////////////////////////////////////////////////////////////////
void EB_Fields(double *Y, double *EB){

    double l = 0.001; // Value of 1/L, where L = X_L = Y_L = 1000.0

    #if STAGE == 1 // Single particle problem
                   // Simple gyration
        EB[0] = 0.0 ; EB[1] = 0.0 ; EB[2] = 0.0;
        EB[3] = 0.0 ; EB[4] = 0.0 ; EB[5] = 1.0;

    #elif STAGE == 2 // Single particle problem
                     // ExB drift in parallel configuration ( |E| < |B| )
                     // I choose E_y = 0.6 for estetic reasons.
        EB[0] = 0.0 ; EB[1] = 0.0 ; EB[2] = 0.6;
        EB[3] = 0.0 ; EB[4] = 0.0 ; EB[5] = 1.0;

    #elif STAGE == 3 // Single particle problem
                     // ExB drift in perpendicular configuration ( |E| < |B| )
                     // I choose E_y = 0.6 for estetic reasons.
        EB[0] = 0.0 ; EB[1] = 0.6 ; EB[2] = 0.0;
        EB[3] = 0.0 ; EB[4] = 0.0 ; EB[5] = 1.0;

    #elif STAGE == 4 // Multiple particles problem
                     // X point configuration
        EB[0] = 0.0    ; EB[1] = 0.0    ; EB[2] = 0.5;
        EB[3] = Y[1]*l ; EB[4] = Y[0]*l ; EB[5] = 0.0;

    #endif

}


////////////////////////////////////////////////////////////////////////////////
// Initial condition.                                                         //
// Input: pointer to the solution vector.                                     //
////////////////////////////////////////////////////////////////////////////////
void InitialCondition(double *Y){

    #if STAGE == 1 || STAGE == 2 || STAGE == 3 // Single particle problem
        Y[0] = 0.0 ; Y[1] = 1.0 ; Y[2] = 0.0;  // Initial position
        Y[3] = 1.0 ; Y[4] = 0.0 ; Y[5] = 0.0;  // Initial velocity

    #elif STAGE == 4 // Multiple particle problem
        // Initialize random positions and velocities with fixed magnitude.
        double x, y, v, vx, vy, theta;
        v = 0.1; // velocity magnitude

        // Generating random (x, y) coordinates in the range [-1000, 1000]^2
        x = (drand48()*2.0*X_L) - X_L;
        y = (drand48()*2.0*Y_L) - Y_L;

        theta = drand48()*2*M_PI; // Random angle in [0,2*pi]

        // Random velocity with magnitude v and angle theta
        vx = v*cos(theta);
        vy = v*sin(theta);

        // Filling the state vector
        Y[0] = x  ; Y[1] = y  ; Y[2] = 0.0; // Initial position
        Y[3] = vx ; Y[4] = vy ; Y[5] = 0.0; // Initial velocity

    #endif

}


////////////////////////////////////////////////////////////////////////////////
// Right-Hand-Side function of the equation.                                  //
// Input: integration variable,                                               //
//        pointer to the solution vector,                                     //
//        pointer to the electric and magnetic field vector,                  //
//        pointer to the RHS vector.                                          //
////////////////////////////////////////////////////////////////////////////////
void RHSFunc(double t, double *Y, double *EB, double *R){

    // Using natural units: c = 1

    EB_Fields(Y, EB); // Fill the EB vector

    // Assigning variables
    double x  = Y[0]  , y  = Y[1]  , z  = Y[2];
    double vx = Y[3]  , vy = Y[4]  , vz = Y[5];
    double Ex = EB[0] , Ey = EB[1] , Ez = EB[2];
    double Bx = EB[3] , By = EB[4] , Bz = EB[5];

    R[0] = vx;
    R[1] = vy;
    R[2] = vz;
    R[3] = Ex + vy*Bz - vz*By;
    R[4] = Ey + vz*Bx - vx*Bz;
    R[5] = Ez + vx*By - vy*Bx;

}


////////////////////////////////////////////////////////////////////////////////
// Fourth-order Runge-Kutta method.                                           //
// Input: integration variable,                                               //
//        pointer to the solution vector,                                     //
//        pointer to the electric and magnetic field vector,                  //
//        pointer to the Right-Hand-Side-Function,                            //
//        step size,                                                          //
//        order of the ODE system.                                            //
////////////////////////////////////////////////////////////////////////////////
void RK4Step(double t, double *Y, double *EB,
             void (*RHSFunc)(double t, double *Y, double *EB, double *R),
             double h, int neq){
    
    int i; // Loop index
    // Vectors for intermediate steps
    double Y1[NMAX_EQ], k1[NMAX_EQ], k2[NMAX_EQ], k3[NMAX_EQ], k4[NMAX_EQ];
    
    RHSFunc(t, Y, EB, k1); // Computation of k1 using RHS at t_n and Y_n

    // Loop to compute Y_n + k1*h/2
    for( i = 0 ; i < neq ; i++ ){
        
        Y1[i] = Y[i] + 0.5*h*k1[i];

    }

    RHSFunc(t+0.5*h, Y1, EB, k2); // Computation of k2 using RHS at t_n + h/2 
                                  // and Y_n + k1*h/2
    
    // Loop to compute Y_{n+1} = Y_n + k2*h/2
    for( i = 0 ; i < neq ; i++ ){
        
        Y1[i] = Y[i] + 0.5*h*k2[i];

    }

    RHSFunc(t+0.5*h, Y1, EB, k3); // Computation of k3 using RHS at t_n + h/2 
                                  // and Y_n + k2*h/2
    
    // Loop to compute Y_{n+1} = Y_n + k3*h
    for(i = 0 ; i < neq ; i++){
        
        Y1[i] = Y[i] + h*k3[i];

    }

    RHSFunc(t+h, Y1, EB, k4); // Computation of k4 using RHS at t_n + h 
                              // and Y_n + k3*h
    
    // Loop to compute Y_{n+1} = Y_n + h/6 * ( k1 + 2*k2 + 2*k3 + k4 )
    for(i = 0 ; i < neq ; i++){
        
        Y[i] += h * ( k1[i] + 2.0*k2[i] + 2.0*k3[i] + k4[i] ) / 6.0;

    }

}


////////////////////////////////////////////////////////////////////////////////
// Boris Method Step (second-order, symplectic)                               //
// Input: integration variable,                                               //
//        pointer to the solution vector,                                     //
//        pointer to the electric and magnetic field vector,                  //
//        step size.                                                          //
////////////////////////////////////////////////////////////////////////////////
void BorisStep(double t, double *Y, double *EB, double h){

    // Reminder: (x, y, z)    = (Y[0], Y[1], Y[2])
    //           (vx, vy, vz) = (Y[3], Y[4], Y[5])
    //           (Ex, Ey, Ez) = (EB[0], EB[1], EB[2])
    //           (Bx, By, Bz) = (EB[3], EB[4], EB[5])

    // We'll compute the following step: 1. x_{n+1/2} = x_n + v_n * h/2
    //                                   2. s and t
    //                                   3. v_minus = v_n + E * h/2
    //                                   4. v_prime and v_plus
    //                                   5. v_{n+1} = v_plus + E * h/2
    //                                   6. x_{n+1} = x_{n+1/2} + v_{n+1} * h/2
    
    int i; // Loop index
    // Vectors for intermediate steps
    double v_minus[3], v_plus[3], t_vec[3], s_vec[3], v_prime[3];
    // Where: t_vec = B * h * 0.5
    //        s_vec = 2t / ( 1 + |t|^2 )
    //        v^prime = v_- + v_- cross t
    double t_mag; // This is the magnitude ^2 of t_vec

    EB_Fields(Y, EB); // Fill the EB vector

    // 1. Compute the position half-step: x_{n+1/2} = x_n + v_n * h/2
    for( i = 0 ; i < 3 ; i++ ){

        Y[i] = Y[i] + Y[i+3] * 0.5 * h;

    }

    // 2. Compute the intermediate vectors for the magnetic rotation
    t_mag = 0;
    for( i = 0 ; i < 3 ; i++ ){

        t_vec[i] = EB[i+3] * 0.5 * h;
        t_mag += t_vec[i] * t_vec[i];

    }
    for( i = 0 ; i < 3 ; i++ ){

        s_vec[i] = 2.0 * t_vec[i] / (1.0 + t_mag);

    }

    // 3. Compute the velocity v_- step (electric field):
    //    v_minus = v_n + E * h/2
    for( i = 0 ; i < 3 ; i++ ){

        v_minus[i] = Y[i+3] + EB[i] * 0.5 * h;

    }

    // 4. Magnetic rotation (Boris Trick)
    //    v_prime = v_minus + v_minus cross t
    v_prime[0] = v_minus[0] + (v_minus[1] * t_vec[2] - v_minus[2] * t_vec[1]);
    v_prime[1] = v_minus[1] + (v_minus[2] * t_vec[0] - v_minus[0] * t_vec[2]);
    v_prime[2] = v_minus[2] + (v_minus[0] * t_vec[1] - v_minus[1] * t_vec[0]);

    // Compute: v_plus = v_minus + v_prime x s
    v_plus[0] = v_minus[0] + (v_prime[1] * s_vec[2] - v_prime[2] * s_vec[1]);
    v_plus[1] = v_minus[1] + (v_prime[2] * s_vec[0] - v_prime[0] * s_vec[2]);
    v_plus[2] = v_minus[2] + (v_prime[0] * s_vec[1] - v_prime[1] * s_vec[0]);

    // 5. Compute the second velocity step (electric field): 
    //    v_{n+1} = v_plus + E * h/2
    for( i = 0 ; i < 3 ; i++ ){

        Y[i+3] = v_plus[i] + EB[i] * 0.5 * h;

    }

    // 6. Compute the position step: x_{n+1} = x_{n+1/2} + v_{n+1} * h/2
    for( i = 0 ; i < 3 ; i++ ){

        Y[i] = Y[i] + Y[i+3] * 0.5 * h;

    }

}