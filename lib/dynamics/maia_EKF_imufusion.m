function [xnew,Pnew, linacc, angacc] = maia_EKF_imufusion(y,fc, x, P, Q,R, B_linacc,B_angacc,Ts)
% Discrete Extended Kalman Filter for estimating [vb,omega,gb,b_acc,b_alpha]
% omega:    angular velocity of body around center of mass, in body frame.
% vb:       linear velocity of body center of mass, in body frame.
% fc:       combined specific force measuremengt from N>=4 IMUs, in body frame.
%
% Roger Skjetne - 19.11.2017
%        Updates: 14.01.2018 - Updated equations.
%                 07.03.2018 - Modified to Maia (Martin Heyn)
%

N = 5; % Number of IMUs.
M = 3*3; % Number of states

pb     = x(1:3);
vb     = x(4:6);
bv     = x(7:9);

% ytemp = y([1:3,7:end]);

% Prediction step
Somega = [    0    -omega(3)    omega(2)
         omega(3)     0        -omega(1)
        -omega(2)   omega(1)     0 ];

SomegaVb = Somega*vb; 
KronProd_gb = kron(ones(N,1),gb);
xi = fc + KronProd_gb;

xkf = zeros(15,1);

xkf(1:3)   = vb + Ts*(B_linacc*xi - SomegaVb + bv);
xkf(4:6)   = omega + Ts*(B_angacc*xi + bomega);
xkf(7:9)   = gb + Ts*(-Somega*gb);
xkf(10:12) = bv;
xkf(13:15) = bomega;

Svb  = [    0  -vb(3)  vb(2)
         vb(3)     0  -vb(1)
        -vb(2)  vb(1)     0 ];

Sgb  = [    0  -gb(3)  gb(2)
         gb(3)     0  -gb(1)
        -gb(2)  gb(1)     0 ];

% KronProdSw = kron(ones(N,1),Somega);
% KronProdSv = kron(ones(N,1),Svb);
KronProdI = kron(ones(N,1),eye(3));

J11 =  eye(3) - Ts*Somega;
J13 =  Ts*B_linacc*KronProdI;
J23 =  Ts*B_angacc*KronProdI;
J33 =  eye(3)-Ts*Somega;

J = [J11 Ts*Svb J13   Ts*eye(3) zeros(3,3);
     zeros(3,3) eye(3) J23  zeros(3,3) Ts*eye(3);
     zeros(3,3) Ts*Sgb  J33  zeros(3,6);
     zeros(3,9)  eye(3) zeros(3,3);
     zeros(3,12)  eye(3)     ];

Pkf = J*P*J' + Q;
 

% Correction step:
C  = [zeros(3,3) eye(3) zeros(3,9);
      zeros(3,3) eye(3) zeros(3,9);
      zeros(3,3) eye(3) zeros(3,9);
      zeros(3,3) eye(3) zeros(3,9);
      zeros(3,3) eye(3) zeros(3,9);
      zeros(3,3) eye(3) zeros(3,9);
      eye(3)     zeros(3,12)       ];

Kk   = Pkf*C'/(C*Pkf*C' + R);
xnew = xkf + Kk*(y - C*xkf);
Pnew = (eye(M) - Kk*C)*Pkf;



% Acceleration outputs
vb     = xnew(1:3);
omega  = xnew(4:6);
gb     = xnew(7:9);
bv     = xnew(10:12);
bomega = xnew(13:15);

KronProd_gb = kron(ones(N,1),gb);
xi = fc + KronProd_gb;

linacc = B_linacc*xi + bv; 
angacc = B_angacc*xi + bomega;

