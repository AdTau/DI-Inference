# Directional-Information-code

## Description

MATLAB implementation of the Directional Information (DI) estimator used to compute single-trial directional interactions across neuron pairs in Tauste Campo et al, PNAS116(15):7513-7522, 2019. The code is built upon the implementation of the universal directed information estimators based on the Context-Tree Weighting (CTW) algorithm in Jiantao Jiao, Haim H. Permuter, Lei Zhao, Young-Han Kim, and Tsachy Weissman. "Universal estimation of directed information." IEEE Transactions on Information Theory 59, no. 10 (2013): 6220-6242 ( https://github.com/EEthinker/Universal_directed_information) adding the following features:
- Statistic defined as a maximization of the Directed Information measure over biologically plausible delays.
- Significance testing method using surrogates (e.g., circular shift of the target sequences).
- Slight modification of the CTW algorithm functions 'ctw_algorithm' (now 'ctw_algorithm_M') and 'ctw_update' (now 'ctw_update_M') o increase computation speed. 



## Citation
If you use the source code, please make sure to reference the paper:

Tauste Campo A, Vázquez Y, Álvarez M, Zainos A, Rossi-Pool R, Deco G, Romo R.  Feed-forward information and zero-lag synchronization in the sensory thalamocortical circuit are modulated during stimulus perception. Proceedings National Academy Sciences USA, 116(15):7513-7522, 2019.


## License
The code in this repository is licensed under The MIT License (https://opensource.org/licenses/MIT).
