# Sun Tracking System

Tutorial from [Getting Started With Simulink for Control](https://es.mathworks.com/matlabcentral/fileexchange/73257-getting-started-with-simulink-for-controls-example-files?s_eid=PSM_15028), [Youtube video](https://www.youtube.com/watch?v=bE179wgm164)

## About

### Problem

We have some solar panel to generate electricity. This panels face south and are fixed in place. That means they produce more electricity when the sun is shining directly on them in the middle of the day (Figure 1) and less power when the sun is in the east (Figure 2) or west late in the day. 

![Simulation with the sun facing directly](image.png)

![alt text](image-1.png)

Objective: Sun tracking system for solar panels to maximize electricy production.

![Model Diagram Block](image-2.png)

### Simulink

#### Step 1 - Model the physical system
The physical system has two main components: 
- The panel ![alt text](image-3.png)
- The motor ![alt text](image-4.png)
#### Step 2 - Design the controller
![alt text](image-5.png)
![](PID_Response.png)
#### Step 3 - Test the design
We load some sun position data, plot the data and see the results.
![alt text](image-6.png)
![](result.png)