%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written By: Mohammad Y. Saadeh, on 02/15/2012  %
% University of Nevada Las Vegas {UNLV}          %
%                                                %%%%%%%%%%%%%%%%%%%%%%%
% Build and define a MATLAB based PID controller using simple routines %
% Might be useful in cases of Hardware-In-Loop (HIL) applications      %
% where access to Real Time Workshop (RTW) is not possible.            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%A%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear;close all

%% Time simulation
tic                 % start timer to calculate CPU time
dt = 0.1;           % sampling time
tf = 30;             % total simulation time in seconds
n = round(tf/dt);    % number of samples
t = 0:dt:tf;


%% Initial state
state1(1:n+1) = 0; STATE1(1:n+1) = 0;
state2(1:n+1) = 0; STATE2(1:n+1) = 0;

%% Desired state
x_des = 1;        % desired output, or reference point

%% PID Control
feed1 = 1;          % can be replaced with damping coefficient B or (B/Mass)
feed2 = 1;          % can be replaced with spring coefficient K or (K/Mass)
B = feed1;K = feed2;
Kp = 1;             % proportional term Kp
Kd = 0.1;             % derivative term Kd
Ki = 0;             % integral term Ki


%% Simulation
% pre-assign all the arrays to optimize simulation time
Prop(1:n+1) = 0; velocidad(1:n+1) = 0;Der(1:n+1) = 0; Int(1:n+1) = 0; I(1:n+1) = 0;
PID(1:n+1) = 0;
x_t(1:n+1) = 0;
Output(1:n+1) = 0;
Error(1:n+1) = 0;


for i = 1:n
    Error(i+1) = x_des - x_t(i);           % error entering the PID controller
    %velocidad(i+1) =(x_t(i+1) - x_t(i))/dt;
    Prop(i+1) = Error(i+1);                     % error of proportional term
    Der(i+1)  = (Error(i+1) - Error(i))/dt;     % derivative of the error
    Int(i+1)  = (Error(i+1) + Error(i))*dt/2;   % integration of the error
    I(i+1)    = sum(Int);                       % the sum of the integration of the error
    
    PID(i+1)  = Kp*Prop(i) + Ki*I(i+1)+ Kd*Der(i); % the three PID terms
    
    %% You can replace the follwoing five lines with your system/hardware/model
    STATE1(i+1) = sum(PID);                         % sum PID term to calculate the first integration
    state2(i+1) = (STATE1(i+1) + STATE1(i))*dt/2;   % output after the first integrator
    STATE2(i+1) = sum(state2);                      % sum output of first integrator to calculate the second integration
    Output(i+1) = (STATE2(i+1) + STATE2(i))*dt/2;   % output of the system after the second integrator
    %x_t(i+1) = x_t(i) + velocidad(i)*dt;
    x_t(i+1) = state2(i+1)*feed1 + Output(i+1)*feed2;
    velocidad(i+1) =(x_t(i+1) - x_t(i))/dt;
end

%% Results
tsim = toc; % simulation time
t=t(2:end);
figure(1);
subplot(3,1,1);
plot(t,x_des*ones(1,i),'black',t,x_t(2:end),'r',t,velocidad(2:end),'b')
title("PID Controller with Kp = " + Kp + ", Kd = " + Kd + ", Ki = " + Ki)
legend('$x_{des}[m]$','$x_t [m]$','$\dot{x}_t [m \cdot s^{-2}]$', 'Interpreter','latex')
ylabel('Position and Speed');
subplot(3,1,2);
plot(t,Prop(2:end),'r',t,Der(2:end),'b',t,Int(2:end),'g')
legend('$x_{des} - x_t$', '$\dot{x}_{des} - \dot{x}_t$', '$\int_0^t x_{des} - x_t dt$','Interpreter','latex')
ylabel('Errors');
subplot(3,1,3);
plot(t, PID(2:end), 'black', t,Kp*Prop(2:end),'r',t,Kd*Der(2:end),'b',t,Ki*Int(2:end),'g')
legend('$u$','$u_p$', '$u_d$', '$u_i$', 'Interpreter','latex')
xlabel('Time (sec)')
ylabel('Controls');
