
clear variables;
close all;

sig = [ 0.4 0.8 1.2 1.6 2.0 2.4 2.8 ];

Nsamp = 100;
Nens = 5;

for kk=1:Nens

    res = zeros(Nsamp,size(sig,2));
    iter = zeros(Nsamp,size(sig,2));

    for ii=1:size(sig,2)
        for jj=1:Nsamp
            [ err_end, iter_end ] = testGlob_New_fn(sig(ii));
            res(jj,ii) = err_end;
            iter(jj,ii) = iter_end;
        end
        fprintf( 'Ensemble %01.0f out of %01.0f:  perturbation parameter %01.0f out of %01.0f done\n', kk, Nens, ii, size(sig,2) );
    end
    
    fn = sprintf( 'res_New_%01i', kk );
    save( fn, 'res', 'iter' );
    
end
