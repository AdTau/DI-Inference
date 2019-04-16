# DI-Inference

## Description

MATLAB implementation of the Directional Information (DI) inference method to estimate single-trial directional interactions between discrete time series in sequential time windows. In the past, this code has been used  to analyze simultanous spike train data in two main publications (Tauste Campo et al., PNAS 2015: Tauste Campo et al., PNAS 2019). The code is built upon the implementation of the universal directed information estimator based on the Context-Tree Weighting (CTW) algorithm in Jiantao Jiao, Haim H. Permuter, Lei Zhao, Young-Han Kim, and Tsachy Weissman. "Universal estimation of directed information." IEEE Transactions on Information Theory 59, no. 10 (2013): 6220-6242 (https://github.com/EEthinker/Universal_directed_information) adding the following features:

- Slight modification of the CTW algorithm functions 'ctw_algorithm' (now 'ctw_algorithm_M'), 'ctw_update' (now 'ctw_update_M') to increase the algorithm computation speed, and of the function 'compute_DI' (now 'compute_DI_M') for its convenient use in this context.
- Definition of a Test Statistic as a maximization of the Directed Information measure over a subset of selected delays.
- Implementation of a significance method over the defined Test Statistic using null distributions approximated with surrogate computations.


The code consists of the following scripts/folders:

- 'DI_computation_per_pair.m': Function that estimates the directed information measure (Massey, 90) via the CTW algorithm (Jiao et al., 2013) at different delays betweeen simultaneously discrete signals. The code is structured to repeat this computation over all possible slicing time windows ('intervals) of a given length within a fixed trial, and over all available trials. The function also performs the same computations for surrogate samples obtained for each parameter (delay, interval) by shifting circulary the target sequence ('Y').

- 'DI_significance_test.m': Function that tests the significance of a predefined statistic (maximization of the Directed Information estimated at different delays) using the original and surrogate outputs of 'DI_computation_per_pair'.

- 'Test_file_3_simulated models.m': Script in which the accuracy of the DI inference method is assessed in 3 groundtruth stochastic pairwise models (unidirectional coupled pair, bidirectional coupled pair and uncouplued pair). 

- 'CTW_code': Folder with 3 modified files ('ctw_algorithm_M', 'compute_DI_M', 'ctw_update_M') from the implementation of the universal directed information estimator (https://github.com/EEthinker/Universal_directed_information). 




## Citation
If you use the source code, please make sure to reference the paper:

Tauste Campo A, Vázquez Y, Álvarez M, Zainos A, Rossi-Pool R, Deco G, Romo R.  Feed-forward information and zero-lag synchronization in the sensory thalamocortical circuit are modulated during stimulus perception. Proceedings National Academy Sciences USA, 116(15):7513-7522, 2019.


## License
DI-Inference is a free open-source software released under the General Public License version 2.
