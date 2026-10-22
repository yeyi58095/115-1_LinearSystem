function hw4_ex7_ex8(exercise)
% Use hw4_ex7_ex8(7) to regenerate Exercise 7 only.
if nargin < 1, exercise = 0; end
assert(ismember(exercise, [0 7]), 'Use 0 (all) or 7 (Exercise 7 only).');
clc;
% Homework 4, Exercises 7(b) and 8: nonlinear/linear comparisons.
% Run this script, with cart_pendulum_model.m in the same folder.
rootDir = fileparts(mfilename('fullpath'));
addpath(rootDir);
outputDir = fullfile(rootDir, 'figures');
if ~exist(outputDir, 'dir'), mkdir(outputDir); end

% Confirmed interpretation: use the Homework 1 parameter sets.
% Columns: m0, m1, m2, l1, l2, g.
P = [2 1 1   1 1    1;
     2 1 1   1 0.99 1;
     2 1 0.5 1 1    1;
     2 1 1   1 0.5  1];
models = cell(8, 1);
eigenvalues = zeros(6, 8);
for k = 1:8
    models{k} = cart_pendulum_model(P(ceil(k/2), :), 2-mod(k, 2));
    eigenvalues(:, k) = eig(models{k}.A);
    % Independent finite-difference check of the implemented Jacobian.
    J = zeros(6); h = 1e-6;
    for j = 1:6
        ej = zeros(6, 1); ej(j) = h;
        J(:, j) = (models{k}.rhs(0, models{k}.xe+ej) ...
                  -models{k}.rhs(0, models{k}.xe-ej))/(2*h);
    end
    assert(norm(J-models{k}.A, 'inf') < 1e-7);
end

options = odeset('RelTol', 1e-10, 'AbsTol', 1e-12, 'MaxStep', 0.02);
results = struct('id', {}, 'p', {}, 'A', {}, 'xe', {}, 'z0', {}, ...
    'x0', {}, 't', {}, 'zLinear', {}, 'xNonlinear', {}, ...
    'zNonlinear', {}, 'mode', {});

%% Exercise 7(b): opposite angular deviations from the equilibrium.
angles = [0 1 10 90 180];
for alpha = angles
    z0 = [0; deg2rad(-alpha); deg2rad(alpha); 0; 0; 0];
    id = sprintf('ex7_L7_%03ddeg', alpha);
    results(end+1) = simulate_case(models{7}, z0, 30, id, options);
end
z0 = [0; deg2rad(-1); deg2rad(1); 0; 0; 0];
results(end+1) = simulate_case(models{8}, z0, 5, ...
    'ex7_L8_001deg', options);

%% Exercise 8: select modes numerically, leaving written derivations blank.
if exercise ~= 7
% 8(a): real part of an oscillatory mode, scaled to 1 degree peak angle.
[V7, D7] = eig(models{7}.A);
lambda7 = diag(D7);
candidates = find(imag(lambda7) > 1e-8);
[~, j] = min(imag(lambda7(candidates)));
j = candidates(j);
v = V7(:, j);
[~, pivot] = max(abs(v(1:3)));
v = v*exp(-1i*angle(v(pivot)));
z0 = scale_angles(real(v), 1);
period = 2*pi/imag(lambda7(j));
r = simulate_case(models{7}, z0, 4*period, 'ex8a_L7_periodic', options);
assert(norm(expm(models{7}.A*period)*z0-z0) < 1e-9);
r.mode = lambda7(j); results(end+1) = r;

% 8(b,c): negative/positive real modes of L8.
[V8, D8] = eig(models{8}.A);
lambda8 = diag(D8);
for signChoice = [-1 1]
    candidates = find(signChoice*real(lambda8) > 1e-8 ...
                      & abs(imag(lambda8)) < 1e-8);
    [~, j] = min(abs(real(lambda8(candidates))));
    j = candidates(j);
    v = real(V8(:, j));
    [~, pivot] = max(abs(v(2:3))); pivot = pivot+1;
    if v(pivot) < 0, v = -v; end
    z0 = scale_angles(v, 1);
    if signChoice < 0
        id = 'ex8b_L8_decay'; tf = 10;
    else
        id = 'ex8c_L8_growth'; tf = 5;
    end
    % Evaluate a pure real mode analytically to avoid numerical contamination
    % by the unstable modes when illustrating asymptotic linear decay.
    r = simulate_case(models{8}, z0, tf, id, options, real(lambda8(j)));
    r.mode = lambda8(j); results(end+1) = r;
end

end

%% Export separate plots, report fragments, and a reloadable workspace.
for k = 1:numel(results)
    export_case(results(k), outputDir, rootDir);
end
fid = fopen(fullfile(rootDir, 'simulation-ex7.tex'), 'w');
assert(fid ~= -1);
fprintf(fid, '\\clearpage\n\\subsection*{MATLAB time histories}\n');
fprintf(fid, ['Parameters P1--P4 follow Homework 1. ' ...
    'The two pendulum lengths are $l_1$ and $l_2$; for P4, ' ...
    '$l_1=1$, $l_2=0.5$.\n\n']);
fprintf(fid, ['State order: $x=[y,\\theta_1,\\theta_2,\\dot y,' ...
    '\\dot\\theta_1,\\dot\\theta_2]^T$. Both models start from the same ' ...
    'physical state $x(0)=x^e+z(0)$, with $u=0$. ' ...
    'Plots show deviations $z=x-x^e$; angles are in degrees and are not wrapped.\n\n']);
fprintf(fid, ['For Exercise 7(b), $z(0)=[0,-\\alpha,+\\alpha,0,0,0]^T$ ' ...
    '(angular entries converted from degrees to radians). ' ...
    'L7 uses $\\alpha=0,1,10,90,180$ deg and L8 uses $\\alpha=1$ deg. ' ...
    'L7 is simulated for 30 s and L8 for 5 s.\n\n']);
fprintf(fid, ['Nonlinear simulation: \\texttt{ode45}, relative tolerance ' ...
    '$10^{-10}$, absolute tolerance $10^{-12}$, maximum step 0.02 s. ' ...
    'Linear responses use the matrix exponential.\n']);
for k = 1:6
    fprintf(fid, '\\input{simulation-%s.tex}\n', results(k).id);
end
fclose(fid);
if exercise == 7
    workspaceFile = fullfile('build', 'hw4_ex7_workspace.mat');
    if ~exist(fullfile(rootDir, 'build'), 'dir'), mkdir(fullfile(rootDir, 'build')); end
else
    workspaceFile = 'hw4_workspace.mat';
end
save(fullfile(rootDir, workspaceFile), ...
    'P', 'models', 'eigenvalues', 'results', 'options');
fprintf('Finished: %d cases, %d separate plots.\n', numel(results), 3*numel(results));
fprintf('Workspace saved to %s\n', fullfile(rootDir, workspaceFile));
end

function z = scale_angles(v, degrees)
z = v*(deg2rad(degrees)/max(abs(v(2:3))));
end

function r = simulate_case(model, z0, tf, id, options, mode)
t = linspace(0, tf, 1501).';
[t, xNonlinear] = ode45(model.rhs, t, model.xe+z0, options);
zLinear = zeros(numel(t), 6);
if nargin == 6
    assert(norm(model.A*z0-mode*z0) < 1e-9);
    zLinear = exp(t*mode)*z0.';
else
    for k = 1:numel(t)
        zLinear(k, :) = (expm(model.A*t(k))*z0).';
    end
end
r = struct('id', id, 'p', model.p, 'A', model.A, 'xe', model.xe, ...
    'z0', z0, 'x0', model.xe+z0, 't', t, 'zLinear', zLinear, ...
    'xNonlinear', xNonlinear, 'zNonlinear', xNonlinear-model.xe.', ...
    'mode', NaN);
assert(all(isfinite(xNonlinear(:))) && all(isfinite(zLinear(:))));
assert(norm(r.zNonlinear(1, :).'-z0) < 1e-12);
end

function export_case(r, outputDir, rootDir)
names = {'y', 'theta1', 'theta2'};
labels = {'\Delta y (m)', '\Delta\theta_1 (deg)', '\Delta\theta_2 (deg)'};
captionNames = {'$\Delta y$', '$\Delta\theta_1$', '$\Delta\theta_2$'};
fid = fopen(fullfile(rootDir, ['simulation-' r.id '.tex']), 'w');
assert(fid ~= -1);
if startsWith(r.id, 'ex7')
    tokens = regexp(r.id, 'ex7_L(\d+)_(\d+)deg', 'tokens', 'once');
    caseNumber = str2double(tokens{1});
    alpha = str2double(tokens{2});
    if alpha == 0
        angleTitle = '0';
    else
        angleTitle = sprintf('\\pm%d', alpha);
    end
    fprintf(fid, '\\clearpage\n\\subsubsection*{L%d: $%s^\\circ$}\n', caseNumber, angleTitle);
else
    fprintf(fid, '\\clearpage\n\\subsection*{\\texttt{%s}}\n', strrep(r.id, '_', '\_'));
end
fprintf(fid, 'Initial deviation $z(0)$ (radians for angles, SI units otherwise):\n');
fprintf(fid, '\\begin{center}\\scriptsize\\texttt{[');
fprintf(fid, '%.7g, ', r.z0(1:5)); fprintf(fid, '%.7g]}\\end{center}\n', r.z0(6));
fprintf(fid, '$x^e=[0,%.7g,%.7g,0,0,0]^T$, $x(0)=x^e+z(0)$.\n', r.xe(2:3));
if startsWith(r.id, 'ex8')
    fprintf(fid, ['The initial state is selected numerically from an eigenmode; ' ...
        'see the source code. Linear states are deviations from equilibrium.\n']);
end
for j = 1:3
    scale = 1; if j > 1, scale = 180/pi; end
    fig = figure('Visible', 'off', 'Color', 'w', ...
        'Position', [100 100 1000 270]);
    ax = axes(fig, 'Position', [0.12 0.24 0.84 0.60]);
    plot(ax, r.t, scale*r.zNonlinear(:, j), '-', ...
        'Color', [0 0.35 0.65], 'LineWidth', 1.4); hold(ax, 'on');
    plot(ax, r.t, scale*r.zLinear(:, j), '--', ...
        'Color', [0.85 0.25 0.12], 'LineWidth', 1.2);
    grid(ax, 'on'); xlabel(ax, 'Time (s)'); ylabel(ax, labels{j});
    title(ax, strrep(r.id, '_', ' '));
    legend(ax, 'Nonlinear', 'Linearized', 'Location', 'best');
    set(ax, 'FontSize', 11, 'Color', 'w', 'XColor', [0.1 0.1 0.1], ...
        'YColor', [0.1 0.1 0.1]);
    exportgraphics(fig, fullfile(outputDir, [r.id '_' names{j} '.png']), ...
        'Resolution', 180, 'BackgroundColor', 'white');
    savefig(fig, fullfile(outputDir, [r.id '_' names{j} '.fig']));
    close(fig);
    fprintf(fid, '\\begin{figure}[!ht]\n\\centering\n');
    fprintf(fid, '\\includegraphics[width=0.94\\linewidth]{figures/%s_%s.png}\n', r.id, names{j});
    fprintf(fid, '\\caption{%s: nonlinear and linearized time histories.}\n\\end{figure}\n', captionNames{j});
end
if startsWith(r.id, 'ex7')
    fprintf(fid, '\\clearpage\n\\textbf{MATLAB code for L%d, $%s^\\circ$:}\n', caseNumber, angleTitle);
    fprintf(fid, ['The following case-specific block uses the common local functions ' ...
        '\\texttt{simulate\\_case} and \\texttt{export\\_case} listed in the source appendix.\n']);
    fprintf(fid, '\\begin{lstlisting}\n');
    fprintf(fid, 'p = [2 1 1 1 0.5 1]; %% [m0 m1 m2 l1 l2 g]\n');
    fprintf(fid, 'model = cart_pendulum_model(p, %d);\n', 1 + (caseNumber == 8));
    fprintf(fid, 'alpha = %d; %% degrees\n', alpha);
    fprintf(fid, 'z0 = [0; -deg2rad(alpha); deg2rad(alpha); 0; 0; 0];\n');
    fprintf(fid, 'options = odeset(''RelTol'',1e-10,''AbsTol'',1e-12,''MaxStep'',0.02);\n');
    fprintf(fid, 'r = simulate_case(model, z0, %g, ''%s'', options);\n', r.t(end), r.id);
    fprintf(fid, 'export_case(r, outputDir, rootDir);\n');
    fprintf(fid, '\\end{lstlisting}\n');
end
fclose(fid);
end
