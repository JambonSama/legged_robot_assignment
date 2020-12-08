clc;
clear;
close all;

%%
q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8];
x0 = [q0;dq0];
threshold = 1e-3;

simOut = sim('test_model','SimulationMode','normal','AbsTol','1e-5',...
            'SaveState','on','StateSaveName','xout',...
            'SaveOutput','on','OutputSaveName','yout',...
            'SaveFormat', 'Dataset');
sln = simOut.get('simout');
Y = sln.get('Data');
T = sln.get('Time');

Data.T = T;
Data.Y = Y;
animate_wo_steps(Data)

