This code performs the identification of the ridge function model based on the input-output data, see [M. Poluektov, A. Polar, "A new iterative method for construction of the Kolmogorov-Arnold representation"].

Language: MATLAB (tested on MATLAB 2020a).

The files reproduce Example 1 of the paper.

File list:
    postproc.m           script, postprocesses the results - calculates the means and the standard deviations across the ensembles
    testGlob_Kac_fn.m    function, the algorithm for building the ridge function model using the Newton-Kaczmarz (NK) method
    testGlob_New_fn.m    function, the algorithm for building the ridge function model using the Gauss-Newton (GN) method
    run_Kac.m            script, main script that generates the data and runs the NK algorithm
    run_New.m            script, main script that generates the data and runs the GN algorithm

To reproduce the table of Example 1 of the paper, run run_Kac.m and run_New.m. They will generate the data files. Execute postproc.m to postprocess the data. MATLAB will generate the following variables:
si05gn_mean, si05gn_std - the average number of runs out of 100 (the mean and the standard deviation, respectively), where the RMSE was below 5% for the GN method (line 3 of Table 1);
si10gn_mean, si10gn_std - same for RMSE<10% for the GN method (line 4 of Table 1);
si20gn_mean, si20gn_std - same for RMSE<20% for the GN method (line 5 of Table 1);
si05nk_mean, si05nk_std - same for RMSE<5% for the NK method (line 9 of Table 1);
si10nk_mean, si10nk_std - same for RMSE<10% for the NK method (line 10 of Table 1);
si20nk_mean, si20nk_std - same for RMSE<20% for the NK method (line 11 of Table 1);
si_mean, si_std - the average number of runs out of 100 (the mean and the standard deviation, respectively), where the convergence criteria of the GN method was fulfilled (line 6 of Table 1);
err_nrm_mean, err_nrm_std - the average RMSE, calculated only for the converged runs of the GN method (line 7 of Table 1).
