# Self-Driving Cars: Control, by Nived Chebrolu

## About
- University of Bonn
- Youtube Link: [Self-Driving Cars: Control (Nived Chebrolu)](https://www.youtube.com/watch?v=XmjjmnDcduU&t)

## Content

1. Bicycle Model Kinematics
2. Longitudinal Control: 
  - PID Controller:
  $$\ddot{x}_{des} = K_p (\dot{x}_{ref}-\dot{x}) + K_d \frac{d(\dot{x}_{ref}-\dot{x})}{dt} + K_i \int_{0}^{t} (\dot{x}_{ref}-\dot{x}) dt$$
  - Feedforward PID Controller
1. Lateral Control: 
  - Lateral PID Controller: cross-track error and heading/orientation error
  $$\dot{\delta}_{des} = -K_p e_{cte} - K_d \frac{de_{cte}}{dt} - K_i \int_{0}^{t} e_{cte} dt$$
  - Geometric Steering Control: Pure Pursuite Controller
1. Other controllers: 
MPC