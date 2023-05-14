
clear variables;
close all;

%. amplitude of the output (Ymax-Ymin)
ampl = 2.54737167553904;

%% GN

si = zeros(5,7);
err = zeros(5,7);
si05gn = zeros(5,7);
si10gn = zeros(5,7);
si20gn = zeros(5,7);
for ii=1:5
    fn = sprintf( 'res_New_%i', ii );
    load( fn );
    ind = (iter<100);
    si(ii,:) = sum(ind);
    for jj=1:7
        err(ii,jj) = mean( res(ind(:,jj),jj) );
    end
    res_nrm = res*100/(20*ampl);
    ind05 = (res_nrm<5);
    ind10 = (res_nrm<10);
    ind20 = (res_nrm<20);
    si05gn(ii,:) = sum(ind05);
    si10gn(ii,:) = sum(ind10);
    si20gn(ii,:) = sum(ind20);
end

si_mean = mean(si);
si_std = std(si);

err_nrm = err*100/(20*ampl);
err_nrm_mean = mean(err_nrm);
err_nrm_std = std(err_nrm);

si05gn_mean = mean(si05gn);
si10gn_mean = mean(si10gn);
si20gn_mean = mean(si20gn);
si05gn_std = std(si05gn);
si10gn_std = std(si10gn);
si20gn_std = std(si20gn);

%% NK

si05nk = zeros(5,7);
si10nk = zeros(5,7);
si20nk = zeros(5,7);
for ii=1:5
    fn = sprintf( 'res_Kac_%i', ii );
    load( fn );
    res_nrm = res*100/(20*ampl);
    ind05 = (res_nrm<5);
    ind10 = (res_nrm<10);
    ind20 = (res_nrm<20);
    si05nk(ii,:) = sum(ind05);
    si10nk(ii,:) = sum(ind10);
    si20nk(ii,:) = sum(ind20);
end

si05nk_mean = mean(si05nk);
si10nk_mean = mean(si10nk);
si20nk_mean = mean(si20nk);
si05nk_std = std(si05nk);
si10nk_std = std(si10nk);
si20nk_std = std(si20nk);
