%% Dynamics of Compound Double Pendulum

% Defining Compound Pendulum Initial State Variables
theta0 = [pi/2; pi/6];                 % Pendulums' Initial Orientations
thetad0 = [0; 0];                      % Pendulums' Initial Angular Velocity 
s0 = [theta0; thetad0];                % Initial States Vector

% Defining the time window
tspan = 0:0.01:15;                     % in secs


% Implementation of ODE45 Numerical Solver
[t, s] = ode45(@PendulumEoM, tspan, s0);

% Extraction of Pendulum Orientations
theta1 = s(:, 1);                     % 1st Pendulum Orientations in radians
theta2 = s(:, 2);                     % 2nd Pendulum Orientations in radians

%% Pendulum Orientation Plots

fig1 = figure();
plot(t, theta1, "Color","#d9ed92", "LineWidth", 1.75);
hold on
plot(t, theta2, "Color", "#ff4d6d", "LineWidth", 1.75);
hold off
grid on
ylabel("Pendulum Orientations (Radian)");
xlabel("Time (sec)");
legend("Pendulum 1", "Pendulum 2", "Location","northwest");
title("Time Evolution of Pendulum Orienetations");

%% Animating the Chaotic Motion of the Pendulum

% Setting upp the Video Writer (MP4 format)
v = VideoWriter("Double_Compound_Pendulum.mp4", 'MPEG-4'); 
v.FrameRate = 8;  % frames per second
open(v);

figure('Color','k');        % Black background
x2_traj = []; 
y2_traj = [];               % Trajectory Array to Keep Track of its History

for k = 1:10:length(t)      % Every 15th step for smoother video
    theta1 = s(k,1); theta2 = s(k,2);

    % Coordinates of the Pendulum Tips
    L = 1;                     % Length of the Rods
    x1 = L*sin(theta1); 
    y1 = -L*cos(theta1);       % Coordinates of Pendulum 1 after every iteration

    x2 = x1 + L*sin(theta2); 
    y2 = y1 - L*cos(theta2);   % Coordinates of Pendulum 2 after every iteration


    % Updated Trajectory After Every Iterations
    x2_traj = [x2_traj, x2];
    y2_traj = [y2_traj, y2];

   % Plotting Pendulum Rods
   plot([0 x1],[0 y1],"color", '#DA498D','LineWidth',15);
   hold on
   plot([x1 x2],[y1 y2],"color", '#7A73D1','LineWidth',15);

   % Mass points
   plot(0,0,'wo','MarkerSize',18,'MarkerFaceColor','w', "MarkerEdgeColor","k");      % Top Hinge
   plot(x1,y1,'wo','MarkerSize',18,'MarkerFaceColor','w', "MarkerEdgeColor","k");
   plot(x2,y2,'wo','MarkerSize',18,'MarkerFaceColor','w', "MarkerEdgeColor","k");

   % Trajectory trace
   plot(x2_traj,y2_traj,'Color', "#ffea00","LineStyle","--" ,'LineWidth',1.25);

   % Axes & labels
     axis equal; 
     axis([-2*L 2*L -2*L 2*L]);  % Keeps the Window Fixed 
     set(gca,'Color','k','XColor','w','YColor','w', "GridColor", "w",...
         'LineWidth', 1.5); % black axes, white ticks
     title(sprintf('Double Compound Pendulum (t = %.2f s)',t(k)), 'Color','w');
     hold off;
     grid on
     camlight;
     drawnow;

    % Capture frame and write to video
    frame = getframe(gcf);
    writeVideo(v, frame);
end
close(v);
winopen('Double_Compound_Pendulum.mp4')