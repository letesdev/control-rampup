class PIDController:
    def __init__(self, Kp, Kd, Ki, dt):
        self.Kp = Kp
        self.Kd = Kd
        self.Ki = Ki
        self.dt = dt
        # initial state
        self.error = 0
        self.integral_error = 0
        # for plotting
        self.proportional_controls = []
        self.derivative_controls = []
        self.integrative_controls = []
        self.control_outputs = []

    def control(self, setpoint, measurement):
        # Compute errors
        error = setpoint - measurement

        # Proportional term
        P = self.Kp*error
        self.proportional_controls.append(P)    # for plotting

        # Derivative term
        D = self.Kd*(error-self.error)/self.dt
        self.derivative_controls.append(D)      # for plotting
        
        # Integrative term
        self.integral_error += error*self.dt
        I = self.Ki*self.integral_error
        self.integrative_controls.append(I)     # for plotting

        # Update previous error
        self.error = error

        # Control signal output
        output = P+D+I
        self.control_outputs.append(output)     # for plotting
        return output

    def get_state(self):
        return self.error, self.control_outputs[-1]
    
    def print_state(self, simulation_time):
        print("t={:.2f} >>> PID: \t e={:.2f} (m), \t u={:.2f} (m/s)".format(simulation_time, self.error, self.control_outputs[-1]))

    def get_proportional_controls(self):
        return self.proportional_controls

    def get_derivative_controls(self):
        return self.derivative_controls
    
    def get_integrative_controls(self):
        return self.integrative_controls
    
    def get_control_outputs(self):
        return self.control_outputs