class Robot:
    def __init__(self, mass, dt):
        self.mass = mass
        self.dt = dt
        self.position = 0.0
        self.velocity = 0.0
        self.positions = []     # for plotting
        self.velocities = []    # for plotting

    def simulate(self, force):
        # F = ma, a = F/m
        acceleration = force / self.mass

        # Update velocity: v = u + at
        self.velocity = self.velocity + acceleration * self.dt

        # Update position: s = ut + 0.5at^2
        self.position = self.position + self.velocity * self.dt + 0.5 * acceleration * self.dt**2
        #self.position = self.position + self.velocity * self.dt

        self.positions.append(self.position)
        self.velocities.append(self.velocity)

    def get_state(self):
        return self.position, self.velocity
    
    def print_state(self, simulation_time):
        # print("t=", simulation_time, " >>> position: ", self.position," m; velocity : ", self.velocity, " m/s")
        print("t={:.2f} >>> robot: \t x={:.2f} m, \t v={:.2f} m/s".format(simulation_time, self.position, self.velocity))


    def get_positions(self):
        return self.positions
    
    def get_velocities(self):
        return self.velocities