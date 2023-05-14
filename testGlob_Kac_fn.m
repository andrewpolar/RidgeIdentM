function [ err_end ] = testGlob_Kac_fn(sig)
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

AXs = A * Xs;
phiAXs = phi(AXs);
C = phiAXs * Ys;

%% projection descent

X = Xs + sig*(rand(m,1)-0.5);
Y = Ys + sig*(rand(n,1)-0.5);

bet = 0.1;
Niter = 1e4;

for kk=1:Niter
    
    ii = rem(kk-1,m+n) + 1;

    AXi = A(ii,:) * X;
    phiAXi = phi(AXi);
    yhat = phiAXi * Y;
    diff = C(ii) - yhat;

    phiDerAXi = phiDer(AXi);
    dydX = ( phiDerAXi * Y ) * A(ii,:).';
    vec1 = dydX;
    vec2 = phiAXi.';

    vec1nrm = vec1 / ( norm(vec1)^2 + norm(vec2)^2 );
    vec2nrm = vec2 / ( norm(vec1)^2 + norm(vec2)^2 );
    if ( norm(vec1nrm) > 1/bet )||( any(isnan(vec1nrm)) )
        if ( norm(vec1) > 0 )
            vec1nrm = vec1 * (1/bet) / norm(vec1);
        else
            vec1nrm = zeros(size(vec1));
        end
    end
    if ( norm(vec2nrm) > 1/bet )||( any(isnan(vec2nrm)) )
        if ( norm(vec2) > 0 )
            vec2nrm = vec2 * (1/bet) / norm(vec2);
        else
            vec2nrm = zeros(size(vec2));
        end
    end
    
    Xnew = X + bet * diff * vec1nrm;
    Ynew = Y + bet * diff * vec2nrm;
    X = Xnew;
    Y = Ynew;

end

%. out
AX = A * X;
phiAX = phi(AX);
R = phiAX * Y - C;
err_end = norm(R);

end
