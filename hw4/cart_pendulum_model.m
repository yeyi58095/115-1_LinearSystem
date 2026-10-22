function model = cart_pendulum_model(p, equilibrium)
% Parameters: [m0 m1 m2 l1 l2 g]. State: [y th1 th2 yd w1 w2].
% The linear state is the deviation z = x - xe; input u = 0.
m0 = p(1); m1 = p(2); m2 = p(3);
l1 = p(4); l2 = p(5); g = p(6);
if equilibrium == 1
    xe = zeros(6, 1);
    c = 1;
else
    xe = [0; pi; pi; 0; 0; 0];
    c = -1;
end
M = [m0+m1+m2, -m1*l1*c, -m2*l2*c;
     -m1*l1*c, m1*l1^2, 0;
     -m2*l2*c, 0, m2*l2^2];
K = diag([0, m1*l1*g*c, m2*l2*g*c]);
model.A = [zeros(3), eye(3); -(M\K), zeros(3)];
model.B = [zeros(3, 1); M\[1; 0; 0]];
model.xe = xe;
model.p = p;
model.rhs = @(t, x) nonlinear_rhs(t, x, p);
end

function dx = nonlinear_rhs(~, x, p)
m0 = p(1); m1 = p(2); m2 = p(3);
l1 = p(4); l2 = p(5); g = p(6);
s1 = sin(x(2)); s2 = sin(x(3));
c1 = cos(x(2)); c2 = cos(x(3));
% Preserve exact equilibria at integer multiples of pi in floating point.
if abs(s1) < 8*eps, s1 = 0; end
if abs(s2) < 8*eps, s2 = 0; end
ydd = (-m1*g*c1*s1 - m2*g*c2*s2 ...
       -m1*l1*s1*x(5)^2 - m2*l2*s2*x(6)^2) ...
      / (m0 + m1*s1^2 + m2*s2^2);
dx = [x(4:6); ydd; (c1*ydd-g*s1)/l1; (c2*ydd-g*s2)/l2];
end
