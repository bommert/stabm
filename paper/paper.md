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
date: 05 February 2021
bibliography: paper.bib
---

# Summary
The R [@R] package *stabm* provides functionality for quantifying the similarity of two or more sets.
For example, consider the two sets $\{A, B, C, D\}$ and $\{A, B, C, E\}$.
Intuitively, these sets are quite similar because their overlap is large compared to the cardinality of the two sets.
The R package *stabm* implements functions to express the similarity of sets by a real valued score.
Quantifying the similarity of sets is useful for comparing sets of selected features.
But also for many other tasks like similarity analyses of gene sets or text corpora, the R package *stabm* can be employed.

In the context of feature selection, the similarity of sets of selected features is assessed in order to determine the stability of a feature selection algorithm.
The stability of a feature selection algorithm is defined as the robustness of the set of selected features towards different data sets from the same data generating distribution [@kalousis2007stability].
For stability assessment, either *m* data sets from the same data generating process are available or *m* data sets are created from one data set.
The latter is often achieved with subsampling or random perturbations [@awada2012review].
Then, the feature selection algorithm of interest is applied to each of the *m* data sets, resulting in *m* feature sets.
To quantify the stability of the feature selection algorithm, the similarity of the *m* sets is calculated.
In the context of feature selection stability, set similarity measures are called stability measures.

The R package *stabm* provides an open-source implementation of the 20 stability measures displayed in the table below.
It is publicly available on CRAN and on Github and it has only a few dependencies.

|Name | Reference|
|-----|----------|
|stabilityDavis | @davis2006reliable|
|stabilityDice | @dice1945measures|
|stabilityHamming | @dunne2002solutions|
|stabilityIntersectionCount | @bommert2020adjusted|
|stabilityIntersectionGreedy | @bommert2020adjusted|
|stabilityIntersectionMBM | @bommert2020adjusted|
|stabilityIntersectionMean | @bommert2020adjusted|
|stabilityJaccard | @jaccard1901etude|
|stabilityKappa | @carletta1996assessing|
|stabilityLustgarten | @lustgarten2009measuring|
|stabilityNogueira | @nogueira2018stability|
|stabilityNovovicova | @novovicova2009new|
|stabilityOchiai | @ochiai1957zoogeographic|
|stabilityPhi | @nogueira2016measuring|
|stabilitySechidis | @sechidis2020stability|
|stabilitySomol | @somol2008evaluating|
|stabilityUnadjusted | @bommert2020adjusted|
|stabilityWald | @wald2013stability|
|stabilityYu | @yu2012stable|
|stabilityZucknick | @zucknick2008comparing|

# Statement of Need
The R package *stabm* provides an implementation of many stability measures.
For theoretical and empirical comparative studies of the stability measures implemented in *stabm*, we refer to @bommert2017multicriteria, @bommert2020adjusted, @bommert2020integration, and @nogueira2018stability.
It has been demonstrated that considering the feature selection stability when fitting a predictive model often is beneficial for obtaining models with high predictive accuracy [@bommert2017multicriteria; @bommert2020integration; @schirra2016selection].
The stability measures implemented in the R package *stabm* have been employed in @bommert2017multicriteria, @bommert2020benchmark, @bommert2020adjusted, and @bommert2020integration.

# Related Software
A subset of the implemented stability measures is also available in other R or Python packages.
The R package *sets* [@meyer2009sets] and the Python package *scikit-learn* [@pedregosa2011scikit] provide an implementation of the Jaccard index [@jaccard1901etude] to assess the similarity of two sets.
The Python package *GSimPy* [@zhang2020gsimpy] implements the Jaccard index, the Dice index [@dice1945measures], and the Ochiai index [@ochiai1957zoogeographic].
The source code for the publication @nogueira2018stability provides an implementation of their stability measure in R, Python, and Matlab.

# Acknowledgements

This work was supported by the German Research Foundation (DFG), Project RA 870/7-1, and Collaborative Research Center SFB 876, A3.

# References
