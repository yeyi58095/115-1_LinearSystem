clear; clc; close all;

% Parameters: [m0, m1, m2, l1, l2, g]
P1 = [2, 1, 1, 1, 1,   1];
P4 = [2, 1, 1, 1, 0.5, 1];

% Initial states: [y, theta1, theta2, y_dot, theta1_dot, theta2_dot]
% Angles are listed in degrees here.
IC = [
    0, -10,     10,  0, 0, 0;
    0,  10,     10,  0, 0, 0;
    0, -90,     90,  0, 0, 0;
    0, -90.01,  90,  0, 0, 0;
    0, 100,    100,  0, 0, 0;
    0, 100.01, 100,  0, 0, 0;
    0, 179.99,   0,  0, 0, 0
];

% Convert initial angles to radians.
IC(:, 2:3) = deg2rad(IC(:, 2:3));

parameterSets = {P1, P4};
parameterNames = {'P1', 'P4'};
initialConditionSets = {[1, 2, 3, 7], [1, 2, 3, 4]};

% Trial simulation interval; adjust if needed.
tspan = linspace(0, 100, 2001);
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-11);

results = struct([]);
runIndex = 0;

% Export report figures next to this script.
outputDir = fullfile(fileparts(mfilename('fullpath')), 'figures');
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

for pIndex = 1:numel(parameterSets)
    p = parameterSets{pIndex};

    for icIndex = initialConditionSets{pIndex}
        x0 = IC(icIndex, :).';

        [t, x] = ode45(@(t, x) cartPendulumODE(t, x, p), ...
                      tspan, x0, options);

        runName = sprintf('%s - IC%d', ...
                          parameterNames{pIndex}, icIndex);

        % Save this run in the workspace.
        runIndex = runIndex + 1;
        results(runIndex).name = runName;
        results(runIndex).parameters = p;
        results(runIndex).t = t;
        results(runIndex).x = x;

        fig = figure('Name', runName, 'Color', [0.13, 0.13, 0.13]);

        subplot(3, 1, 1);
        plot(t, x(:, 1), 'LineWidth', 1.2);
        ylabel('y');
        title(runName);
        grid on;

        subplot(3, 1, 2);
        plot(t, rad2deg(x(:, 2)), 'LineWidth', 1.2);
        ylabel('\theta_1 (deg)');
        grid on;

        subplot(3, 1, 3);
        plot(t, rad2deg(x(:, 3)), 'LineWidth', 1.2);
        ylabel('\theta_2 (deg)');
        xlabel('Time');
        grid on;

        % Make a separate light-background copy for the written homework.
        reportFig = figure('Visible', 'off', 'Color', 'w', ...
            'Units', 'pixels', 'Position', [100, 100, 1000, 550]);
        copyobj(findall(fig, 'Type', 'axes'), reportFig);
        reportAxes = findall(reportFig, 'Type', 'axes');
        set(reportAxes, 'Color', 'w', 'XColor', [0.15 0.15 0.15], ...
            'YColor', [0.15 0.15 0.15], 'GridColor', [0.5 0.5 0.5], ...
            'GridAlpha', 0.25, 'FontSize', 11);
        set(findall(reportFig, 'Type', 'text'), 'Color', [0.1 0.1 0.1]);
        set(findall(reportFig, 'Type', 'line'), 'Color', [0 0.35 0.65]);
        exportgraphics(reportFig, fullfile(outputDir, ...
            sprintf('%s_IC%d.png', parameterNames{pIndex}, icIndex)), ...
            'Resolution', 180, 'BackgroundColor', 'white');
        close(reportFig);
    end
end

% Local function: returns the six state derivatives.
function dx = cartPendulumODE(~, x, p)
    m0 = p(1);
    m1 = p(2);
    m2 = p(3);
    l1 = p(4);
    l2 = p(5);
    g  = p(6);

    theta1 = x(2);
    theta2 = x(3);
    omega1 = x(5);
    omega2 = x(6);

    u = 0;

    % Cart acceleration, obtained by eliminating angular accelerations.
    denominator = m0 + m1*sin(theta1)^2 + m2*sin(theta2)^2;

    numerator = u ...
        - m1*g*cos(theta1)*sin(theta1) ...
        - m2*g*cos(theta2)*sin(theta2) ...
        - m1*l1*sin(theta1)*omega1^2 ...
        - m2*l2*sin(theta2)*omega2^2;

    ydd = numerator / denominator;

    % Angular accelerations.
    theta1dd = (cos(theta1)*ydd - g*sin(theta1)) / l1;
    theta2dd = (cos(theta2)*ydd - g*sin(theta2)) / l2;

    dx = [
        x(4);
        x(5);
        x(6);
        ydd;
        theta1dd;
        theta2dd
    ];
end
