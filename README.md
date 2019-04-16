# DI-Inference

## Description

MATLAB implementation of the Directional Information (DI) estimator used to compute single-trial directional interactions between discrete time series in sequential time windows. Up to now, it has been used  to analyze simultanous spike train data in two  main publications (Tauste Campo et al., PNAS 2015: Tauste Campo et al., PNAS 2019). The code is built upon the implementation of the universal directed information estimator based on the Context-Tree Weighting (CTW) algorithm in Jiantao Jiao, Haim H. Permuter, Lei Zhao, Young-Han Kim, and Tsachy Weissman. "Universal estimation of directed information." IEEE Transactions on Information Theory 59, no. 10 (2013): 6220-6242 (https://github.com/EEthinker/Universal_directed_information) adding the following features:

- Statistic defined as a maximization of the Directed Information measure over a subset of plausible delays.
- Significance testing method using surrogates (e.g., circular shift of the target sequences).
- Slight modification of the CTW algorithm functions 'ctw_algorithm' (now 'ctw_algorithm_M') and 'ctw_update' (now 'ctw_update_M') to increase the algorithm computation speed, and of the function 'compute_DI' (now 'compute_DI_M') for its convenient use here.

The code consists of the following scripts/folders:

- 'DI_computation_per_pair': For a pair of neuron, function that estimates delayed versions (for a subset of selected time delays) of the directed information measure via the Context-Tree Weighting algorithm  betweeen (1) the original simultaneous discrete time series and (2) between a number of surrogated pairs in which the second time series is shifted circularly. The code is structured to repeat these 2 computation over all possible slicing time windows ('intervals) of selected length within a fixed trial, and over all available trials.

- 'DI_significance_test: Function that computes a and test the significance of a statistic (maximization over estmations of delayed directed information) using the original and surrogate computations of 'DI_computation_per_pair'.

- 'Test_file': Script where pairs of time seres are simulated to test the accuracy of the coupling detection DI method. 

- 'CTW_code': Folder with 3 modified files ('ctw_algorithm_M', 'compute_DI_M', 'ctw_update_M') from the implementation of the universal directed information estimator (https://github.com/EEthinker/Universal_directed_information). 



## Citation
If you use the source code, please make sure to reference the paper:

Tauste Campo A, Vázquez Y, Álvarez M, Zainos A, Rossi-Pool R, Deco G, Romo R.  Feed-forward information and zero-lag synchronization in the sensory thalamocortical circuit are modulated during stimulus perception. Proceedings National Academy Sciences USA, 116(15):7513-7522, 2019.


## License
DI-Inference is a free open-source software released under the General Public License version 2.
