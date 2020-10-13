---
title: 'stabm: Stability Measures for Feature Selection'
tags:
  - R
  - feature selection stability
  - stability measures
  - similarity measures
authors:
  - name: Andrea Bommert
    orcid: 0000-0002-1005-9351
    affiliation: 1
  - name: Michel Lang
    orcid: 0000-0001-9754-0393
    affiliation: 1
affiliations:
 - name: Faculty of Statistics, TU Dortmund University, 44221 Dortmund, Germany
   index: 1
date: 13 October 2020
bibliography: paper.bib
---

# Summary
The R [@R] package *stabm* provides functionality for quantifying the similarity of two or more sets.
Quantifying the similarity of sets is useful for comparing sets of selected features.
But also for many other tasks like similarity analyses of gene sets or text corpora, the R package *stabm* can be employed.

In the context of feature selection, the similarity of sets of selected features is assessed in order to determine the stability of a feature selection algorithm.
The stability of a feature selection algorithm is defined as the robustness of the set of selected features towards different data sets from the same data generating distribution [@kalousis2007stability].
For stability assessment, either *m* data sets from the same data generating process are available or *m* data sets are created from one data set.
The latter is often achieved with subsampling or random perturbations [@awada2012review].
Then, the feature seleciton algorithm of interest is applied to each of the *m* data sets, resulting in *m* feature sets.
To quantify the stability of the feature selection algorithm, the similarity of the *m* sets is calculated.
In the context of feature selection stability, set similarity measures are called stability measures.
The R package *stabm* provides an implementation of many stability measures.
For theoretical and empirical comparative studies of the stability measures implemented in *stabm*, we refer to @bommert2017multicriteria, @bommert2020adjusted, and @nogueira2018stability.
It has be demonstrated that considering the feature selection stability when fitting a predictive model often is beneficial for obtaining models with high predictive accuracy [@bommert2017multicriteria; @schirra2016selection].

Some stability measures are available in other R or Python packages.
The R package *sets* [@meyer2009sets] and the Python package *Scikit-learn* [@pedregosa2011scikit] provide an implementation of the Jaccard index [@jaccard1901etude] to assess the similarity of two sets.
The Python package *GSimPy* [@zhang2020gsimpy] implements several similarity measures including the Jaccard index and the Dice index [@dice1945measures].
The source code for the publication @nogueira2018stability includes an implementation of stability measures in Python.

The R package *stabm* provides an open source implementation of many stability measures.
It is publicly available on CRAN and Github and it has only few dependencies.


# Acknowledgements

This work was supported by German Research Foundation (DFG), Project RA 870/7-1 and Collaborative Research Center SFB 876, A3.

# References
