////////////////////////////////////////////////////////////////////////////////
//              Name    : Gabriele Cembalo                                    //
//              A.Y.    : 2025-2026                                           //
//              Project : Particle(s) in Electromagnetic Fields               //
//                                                                            //
//              Starting date : 24-12-2025                                    //
//              Ending date   : ..-..-2026                                    //
////////////////////////////////////////////////////////////////////////////////

#include <iostream>
#include <iomanip>
#include <cmath>
#include <fstream>

using namespace std;

////////////////////////////////////////////////////////////////////////////////
//                            Macro declaration                               //
////////////////////////////////////////////////////////////////////////////////
# define STAGE 4 // Choose the problem type (1 to 4)
                 // 1,2,3 : single particle
                 // 4 : multiple particles (N_Part)
#define NMAX_EQ 64 // Maximum number of elements (safety limit)
                   // to avoid variable-size arrays
#define N_Part 1.e3 // Number of particles in the multi-particle problem
#define X_L 1000 // Length of the X axis for STAGE 4
#define Y_L 1000 // Length of the Y axis for STAGE 4

////////////////////////////////////////////////////////////////////////////////
//                          Functions declaration                             //
////////////////////////////////////////////////////////////////////////////////
void EB_Fields(double *, double *);
void InitialCondition(double *);
void RHSFunc(double, double *, double *, double *);
void RK4Step(double, double *, double *,
             void (*)(double, double *, double *, double *), 
             double, int);

////////////////////////////////////////////////////////////////////////////////
//                       Main function implementation                         //
////////////////////////////////////////////////////////////////////////////////
int main(){

    ofstream fdata;
    fdata.open("file.dat"); // Solutions file

    fdata << setiosflags ( ios::scientific );
    fdata << setprecision ( 10 );

    cout << setiosflags ( ios::scientific );
    cout << setprecision ( 7 );

    int neq = 6; // Number of equations

    double Y[neq]; // (x, y, z)    = (Y[0], Y[1], Y[2])
                   // (vx, vy, vz) = (Y[3], Y[4], Y[5])

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

    double l = 0.001; // Value of 1/L, where L = X_L = Y_L

    #if STAGE == 1 // Single particle problem
                   // Simple gyration
        EB[0] = 0.0 ; EB[1] = 0.0 ; EB[2] = 0.0;
        EB[3] = 0.0 ; EB[4] = 0.0 ; EB[5] = 1.0;

    #elif STAGE == 2 // Single particle problem
                     // ExB drift in parallel configuration ( |E| < |B| )
        EB[0] = 0.0 ; EB[1] = 0.0 ; EB[2] = 0.8;
        EB[3] = 0.0 ; EB[4] = 0.0 ; EB[5] = 1.0;

    #elif STAGE == 3 // Single particle problem
                     // ExB drift in perpendicular configuration ( |E| < |B| )
        EB[0] = 0.0 ; EB[1] = 0.8 ; EB[2] = 0.0;
        EB[3] = 0.0 ; EB[4] = 0.0 ; EB[5] = 1.0;

    #elif STAGE == 4 // Multiple particles problem
                     // X point
        EB[0] = 0.0 ; EB[1] = 0.0 ; EB[2] = 0.5;
        EB[3] = Y[1]*l ; EB[4] = Y[0]*l ; EB[5] = 0.0;

    #endif

}


////////////////////////////////////////////////////////////////////////////////
// Initial condition.                                                         //
// Input: pointer to the solution vector.                                     //
////////////////////////////////////////////////////////////////////////////////
void InitialCondition(double *Y){

    #if STAGE == 1 || STAGE == 2 || STAGE == 3 // Single particle problem
        Y[0] = 1.0 ; Y[1] = 0.0 ; Y[2] = 0.0; // Initial position
        Y[3] = 0.0 ; Y[4] = 1.0 ; Y[5] = 0.0; // Initial velocity

    #elif STAGE == 4 // Multiple particle problem
        // Setting random initial conditions 
        // with a constraint on the velocity magnitude.
        double x, y, v, vx, vy, theta;
        v = 0.1;

        // Generating random (x, y) coordinates in the range [-1000, 1000]^2
        x = (drand48()*2.0*X_L) - X_L;
        y = (drand48()*2.0*Y_L) - Y_L;

        theta = drand48()*2*M_PI; // Random angle in [0,2*pi]

        // Random velocity with magnitude v and angle theta
        vx = v*cos(theta);
        vy = v*sin(theta);

        // Filling the state vector
        Y[0] = x ; Y[1] = y ; Y[2] = 0.0;   // Initial position
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
    double x = Y[0] , y = Y[1], z = Y[2];
    double vx = Y[3] , vy = Y[4] , vz = Y[5];
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
    for(i = 0 ; i < neq ; i++ ){
        
        Y1[i] = Y[i] + 0.5*h*k1[i];

    }

    RHSFunc(t+0.5*h, Y1, EB, k2); // Computation of k2 using RHS at t_n + h/2 
                                  // and Y_n + k1*h/2
    
    // Loop to compute Y_{n+1} = Y_n + k2*h/2
    for (i = 0 ; i < neq ; i++){
        
        Y1[i] = Y[i] + h*k2[i]*0.5;

    }

    RHSFunc(t+0.5*h, Y1, EB, k3); // Computation of k3 using RHS at t_n + h/2 
                                  // and Y_n + k2*h/2
    
    // Loop to compute Y_{n+1} = Y_n + k3*h
    for (i = 0 ; i < neq ; i++){
        
        Y1[i] = Y[i] + h*k3[i];

    }

    RHSFunc(t+h, Y1, EB, k4); // Computation of k4 using RHS at t_n + h 
                              // and Y_n + k3*h
    
    // Loop to compute Y_{n+1} = Y_n + h/6 * ( k1 + 2*k2 + 2*k3 + k4 )
    for (i = 0 ; i < neq ; i++){
        
        Y[i] += h * ( k1[i] + 2.0*k2[i] + 2.0*k3[i] + k4[i] ) / 6.0;

    }

}


////////////////////////////////////////////////////////////////////////////////
// Boris particle pusher (second-order, symplectic).                          //
// Input: integration variable,                                               //
//        pointer to the solution vector,                                     //
//        pointer to the electric and magnetic field vector,                  //
//        step size,                                                          //
//        order of the ODE system (must be 6).                                //
////////////////////////////////////////////////////////////////////////////////