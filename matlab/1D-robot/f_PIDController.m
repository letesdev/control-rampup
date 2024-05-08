classdef f_PIDController < handle
    properties
        Kp
        Kd
        Ki
        dt
        error
        integral_error
        proportional_controls
        derivative_controls
        integrative_controls
        control_outputs
    end
    
    methods
        function obj = f_PIDController(Kp, Kd, Ki, dt)
            obj.Kp = Kp;
            obj.Kd = Kd;
            obj.Ki = Ki;
            obj.dt = dt;
            obj.error = 0;
            obj.integral_error = 0;
            obj.proportional_controls = [];
            obj.derivative_controls = [];
            obj.integrative_controls = [];
            obj.control_outputs = [];
        end
        
        function output = control(obj, setpoint, measurement)
            error = setpoint - measurement;
            P = obj.Kp * error;
            obj.proportional_controls = [obj.proportional_controls, P];
            D = obj.Kd * (error - obj.error) / obj.dt;
            obj.derivative_controls = [obj.derivative_controls, D];
            obj.integral_error = obj.integral_error + error * obj.dt;
            I = obj.Ki * obj.integral_error;
            obj.integrative_controls = [obj.integrative_controls, I];
            obj.error = error;
            output = P + D + I;
            obj.control_outputs = [obj.control_outputs, output];
        end
        
        function [error, control_output] = get_state(obj)
            error = obj.error;
            control_output = obj.control_outputs(end);
        end
        
        function print_state(obj, simulation_time)
            fprintf('t=%.2f >>> PID: \t e=%.2f (m), \t u=%.2f (m/s)\n', simulation_time, obj.error, obj.control_outputs(end));
        end
        
        function proportional_controls = get_proportional_controls(obj)
            proportional_controls = obj.proportional_controls;
        end
        
        function derivative_controls = get_derivative_controls(obj)
            derivative_controls = obj.derivative_controls;
        end
        
        function integrative_controls = get_integrative_controls(obj)
            integrative_controls = obj.integrative_controls;
        end
        
        function control_outputs = get_control_outputs(obj)
            control_outputs = obj.control_outputs;
        end
    end
end
