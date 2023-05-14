function [ err_end, iter_end ] = testGlob_New_fn(sig)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% data

N = 400;
m = 5;
n = 3;

Xs = [ -0.7 2.5 -1.2 0.8 1.6 ].';
Ys = [ 2.1 -0.9 0.7 ].';

A = rand(N,m);

nodeX = [ 0.5 1.5 2.5 ];

phi = @(x) exp(-2*(repmat(x,1,n)-nodeX).^2);
phiDer = @(x) exp(-2*(repmat(x,1,n)-nodeX).^2) .* (4*nodeX-4*repmat(x,1,n));
phiDerDer = @(x) exp(-2*(repmat(x,1,n)-nodeX).^2) .* ((4*nodeX-4*repmat(x,1,n)).^2 - 4);

AXs = A * Xs;
phiAXs = phi(AXs);
C = phiAXs * Ys;

%% global N.-R.

X = Xs + sig*(rand(m,1)-0.5);
Y = Ys + sig*(rand(n,1)-0.5);

alp = 0.1;

noConv = 1;
iter = 1;
while ( noConv == 1 )

    AX = A * X;
    phiAX = phi(AX);
    R = phiAX * Y - C;

    phiDerAX = phiDer(AX);
    phiDerDerAX = phiDerDer(AX);

    dRdX = repmat( phiDerAX * Y, 1, m ) .* A;
    G = dRdX.' * R;

    dRdY = phiAX;
    H = dRdY.' * R;

    d2RdX2part = repmat( phiDerDerAX * Y, 1, m ) .* A;
    RA = repmat( R, 1, m ) .* A;
    JXX = dRdX.' * dRdX + d2RdX2part.' * RA;
    JXY = dRdX.' * dRdY + RA.' * phiDerAX;
    JYY = dRdY.' * dRdY;

    J = [ JXX    JXY ;
          JXY.'  JYY ];
    E = [ G ;
          H ];

    dlt = -pinv(J)*E;

    X = X + alp * dlt(1:m);
    Y = Y + alp * dlt((m+1):(m+n));

    iter = iter + 1;
    if ( norm(dlt) < 1e-12 )
        noConv = 0;
    end
    if ( norm(dlt) < 1e-1 )
        alp = 1;
    end
    if ( iter > 100 )
        break;
    end

end

err_end = norm(R);
iter_end = iter-1;

end
