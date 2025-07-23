% Run the model
simOut = sim('SPWM_3Phase_Inverter');

% Extract timeseries from workspace variables
speed_ts = simOut.get('speed');  % assuming variable name in To Workspace block is "speed"
voltages_ts = simOut.get('voltages');  % "voltages"
currents_ts = simOut.get('currents');  % "currents"

% Extract time and data
t_speed = speed_ts.Time;
rpm = speed_ts.Data * 9.5493;  % rad/s to RPM

% Phase voltages
t_v = voltages_ts.Time;
Va = voltages_ts.Data(:,1);
Vb = voltages_ts.Data(:,2);
Vc = voltages_ts.Data(:,3);

% Phase currents
t_i = currents_ts.Time;
Ia = currents_ts.Data(:,1);
Ib = currents_ts.Data(:,2);
Ic = currents_ts.Data(:,3);

% Plot
figure;
subplot(3,1,1);
plot(t_speed, rpm, 'LineWidth', 2);
ylabel('Speed (RPM)');
title('Rotor Speed, Phase Voltages, Phase Currents');
grid on;

subplot(3,1,2);
plot(t_v, Va, 'r', t_v, Vb, 'g', t_v, Vc, 'b');
ylabel('Voltage (V)');
legend('Va','Vb','Vc');
grid on;

subplot(3,1,3);
plot(t_i, Ia, 'r', t_i, Ib, 'g', t_i, Ic, 'b');
ylabel('Current (A)');
xlabel('Time (s)');
legend('Ia','Ib','Ic');
grid on;

% Save
saveas(gcf, 'CombinedOutputPlot.png');
