%% PENDULUMEOM Double Compound Pendulum EoM

function s_dot = PendulumEoM(t, s)
% State Variables
  theta  = s(1:2);   % [theta1; theta2]
  thetad = s(3:4);   % [theta1dot; theta2dot]
% System Parameters
L = 1;      % Length of pendulum rods (change as needed)
m = 1;      % Mass of each pendulum rod (change as needed)
g = 9.81;   % Gravity (m/s^2)
% State Equations
theta_dot = thetad;   % 1st Set of State Equations
% Mass Matrix Formulation for Deriving the 2nd Set of State Equations 
M = m*L^2 * [4/3, 0.5*cos(theta(1)-theta(2));
     0.5*cos(theta(1)-theta(2)), 1/3];                                              % Mass Matrix
F = [ -0.5*m*L^2*(thetad(2))^2 * sin(theta(1)-theta(2))- 1.5*m*g*L*sin(theta(1));
      0.5*m*L^2*(thetad(1))^2 * sin(theta(1)-theta(2))- 0.5*m*g*L*sin(theta(2))];   % Forced Vector
% Accelerations
theta_ddot = M \ F;
% Return first-order system
s_dot = [theta_dot; theta_ddot];
end