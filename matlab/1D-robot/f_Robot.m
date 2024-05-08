classdef f_Robot < handle
    properties
        mass
        dt
        position
        velocity
        positions
        velocities
    end
    
    methods
        function obj = f_Robot(mass, dt)
            obj.mass = mass;
            obj.dt = dt;
            obj.position = 0.0;
            obj.velocity = 0.0;
            obj.positions = [];
            obj.velocities = [];
        end
        
        function simulate(obj, force)
            acceleration = force / obj.mass;
            obj.velocity = obj.velocity + acceleration * obj.dt;
            obj.position = obj.position + obj.velocity * obj.dt + 0.5 * acceleration * obj.dt^2;
            obj.positions = [obj.positions, obj.position];
            obj.velocities = [obj.velocities, obj.velocity];
        end
        
        function [position, velocity] = get_state(obj)
            position = obj.position;
            velocity = obj.velocity;
        end
        
        function print_state(obj, simulation_time)
            fprintf('t=%.2f >>> robot: \t x=%.2f m, \t v=%.2f m/s\n', simulation_time, obj.position, obj.velocity);
        end
        
        function positions = get_positions(obj)
            positions = obj.positions;
        end
        
        function velocities = get_velocities(obj)
            velocities = obj.velocities;
        end
    end
end
