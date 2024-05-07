import matplotlib.pyplot as pyplot
import numpy as np
import Robot, PIDController

ti = 0.0
tf = 30.0 # seconds
dt = 0.1  # seconds

position_desired = 1.0 # meters

# times = range(ti,tf,dt)
times = np.arange(ti,tf,dt)

robot = Robot.Robot(
    mass=1, 
    dt=dt
)

pid = PIDController.PIDController(
    Kp=1/50,
    Kd=1/2,
    Ki=0,
    dt=dt
)

velocity_control = 0

for i in times:
    # PID calculations
    velocity_control = pid.control(position_desired, robot.position)
    pid.print_state(i)
    
    # Robot kinematics calculations
    robot.simulate(velocity_control)
    robot.print_state(i)
    

fig = pyplot.figure()
pyplot.suptitle(r'PID Control: $K_p$={:.2f}, $K_d$={:.2f}, $K_i$={:.2f}'.format(pid.Kp, pid.Kd, pid.Ki))

# ax = fig.gca()
# ax.set_xticks(list(times))
pyplot.subplot(2,1,1)
pyplot.plot(list(times), [position_desired]*len(list(times)), '--', color="black", label=r"$x_{des}$")
pyplot.plot(list(times), robot.get_positions(), 'r' , label=r"$x$", linewidth=1)
pyplot.plot(list(times), robot.get_velocities(), 'b', label=r"$\dot{x}$")
pyplot.xlabel('Time (s)')
pyplot.ylabel('Position (m) / Velocity (m/s)')
pyplot.legend()
pyplot.grid(visible=True)


pyplot.subplot(2,1,2)
pyplot.plot(list(times), pid.get_proportional_controls(), 'r', label=r"$u_p$")
pyplot.plot(list(times), pid.get_derivative_controls(), 'b', label=r"$u_d$")
pyplot.plot(list(times), pid.get_integrative_controls(), 'g', label=r"$u_i$")
pyplot.plot(list(times), pid.get_control_outputs(), '--', label=r"$u = u_p + u_d + u_i$")
pyplot.xlabel('Time (s)')
pyplot.ylabel('Velocity (m/s)')
pyplot.legend()
pyplot.grid(visible=1)

# pyplot.subplot(3,1,3)
# pyplot.plot(list(times), robot.get_velocities(), label="Velocity")
# pyplot.xlabel('Time (s)')
# pyplot.ylabel(r'Velocity ($\frac{m}{s}$)')
# pyplot.legend()
# pyplot.grid(visible=True)


pyplot.tight_layout()
pyplot.show()

