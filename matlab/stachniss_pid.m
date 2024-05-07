clear all; clc; 

% Time simulation
delta_t = 0.1; % 0.1 second
t=0:delta_t:1;

% System
function [x, y, theta, v, omega, alpha] = kinematicBicycleModel(t, u)
    % Define the vehicle parameters
    L = 2.5;  % wheelbase
    m = 1500;  % mass
    I = 2000;  % moment of inertia
    C_f = 1000;  % front tire stiffness
    C_r = 1000;  % rear tire stiffness
    
    % Define the input variables
    v0 = u(1);  % initial velocity
    omega0 = u(2);  % initial angular velocity
    alpha = u(3);  % steering angle
    
    % Integrate the kinematic equations
    tspan = [0 t];
    [t, x, y, theta, v, omega] = ode45(@(t, y) kinematicBicycleModelEqns(t, y, L, m, I, C_f, C_r, alpha), tspan, [x0, y0, theta0, v0, omega0]);
    
    function dydt = kinematicBicycleModelEqns(t, y, L, m, I, C_f, C_r, alpha)
        % Extract the state variables
        x = y(1);
        y = y(2);
        theta = y(3);
        v = y(4);
        omega = y(5);
        
        % Compute the derivatives
        dxdt = v*cos(theta);
        dydt = v*sin(theta);
        dthetadt = omega;
        dvdt = (C_f*C_r/L)*sin(theta)*alpha;
        domegadt = (v^2)/L * sin(theta);
        
        % Return the derivatives
        dydt = [dxdt; dydt; dthetadt; dvdt; domegadt];
    end
end

% Initial state
x_0 = 0;
x_d_0 = 0;

% Desired state
x_des = 1;

%% P control 
Kp = 1;
Kd = 0;
Ki = 0;
u_t = Kp (x_des - x_0); 

C=pid(Kp,Ki,Kd);
T=feedback(C*G,H);

step(T)
% System state
x_t = x_t-1 + x_d*delta_t




%% PD Control
Kd = 1;

%% PID Control 
Ki = 1;