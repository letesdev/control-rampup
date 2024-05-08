% Importar las clases Robot y PIDController
% import Robot
% import PIDController

close all, clear, clc;

ti = 1.0;
tf = 31.0; % segundos
dt = 0.1;  % segundos

position_desired = 2.0; % metros

% times = ti:dt:tf;
times = [ti:dt:tf];

robot = f_Robot(1, dt);

pid = f_PIDController(0.7, 0.8, 0, dt);

control_signal = 0;

for i = times
    % Cálculos PID
    control_signal = pid.control(position_desired, robot.position);
    pid.print_state(i);
    
    % Cálculos de cinemática del robot
    robot.simulate(control_signal);
    robot.print_state(i);
end

figure;
sgtitle(sprintf('PID Control: $K_p=%.2f$, $K_d=%.2f$, $K_i=%.2f$', pid.Kp, pid.Kd, pid.Ki), 'Interpreter', 'latex');

subplot(2,1,1);
plot(times, position_desired*ones(size(times)), '--', 'Color', 'black', 'DisplayName', 'x_{des}');
hold on;
plot(times, robot.get_positions(), 'r', times, robot.get_velocities(), 'b');
xlabel('Time (s)');
ylabel('Position (m) / Velocity (m/s)');
legend('$x_{des}$','$x$','$\dot{x}$', 'Interpreter', 'latex')
grid on;

subplot(2,1,2);
plot(times, pid.get_proportional_controls(), 'r', 'DisplayName', 'u_p');
hold on;
plot(times, pid.get_derivative_controls(), 'b', 'DisplayName', 'u_d');
plot(times, pid.get_integrative_controls(), 'g', 'DisplayName', 'u_i');
plot(times, pid.get_control_outputs(), '--', 'DisplayName', 'u = u_p + u_d + u_i');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
legend;
grid on;

% subplot(3,1,3);
% plot(times, robot.get_velocities(), 'DisplayName', 'Velocity');
% xlabel('Time (s)');
% ylabel('Velocity (m/s)');
% legend;
% grid on;
