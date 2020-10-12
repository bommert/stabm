
#' @export
#' @title Stability Measure Zucknick
#' @inherit stabilityDocumentation
#' @inherit uncorrectedDocumentation
#' @details The stability measure is defined as
#' \deqn{\frac{2}{m(m-1)}\sum_{i=1}^{m-1} \sum_{j=i+1}^{m}
#' \frac{|V_i \cap V_j| + C(V_i, V_j) + C(V_j, V_i)}{|V_i \cup V_j|}} with
#' \deqn{C(V_k, V_l) = \frac{1}{|V_l|} \sum_{(x, y) \in V_k \times (V_l \backslash V_k) \ with \
#' Similarity(x,y) \geq threshold} Similarity(x,y).}
#' Note that this definition slightly differs from its original in order to make it suitable
#' for arbitrary similarity measures.
#' @references
#' * M. Zucknick, S. Richardson, and E. Stronach, "Comparing the
#' characteristics of gene expression profiles derived by univariate
#' andmultivariate classification methods", Statistical Applications
#' in Genetics and Molecular Biology, vol. 7, no. 1, pp. 1-34, 2008.
#' * A. Bommert, J. Rahnenführer, and M. Lang,
#' "A multi-criteria approach to find predictive and sparse models with
#' stable feature selection for high-dimensional data",
#' Computational and mathematical methods in medicine, 2017.
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' mat = 0.92 ^ abs(outer(1:10, 1:10, "-"))
#' stabilityZucknick(features = feats, sim.mat = mat)
stabilityZucknick = function(features, sim.mat, threshold = 0.9,
  correction.for.chance = "none", N = 1e4, impute.na = NULL) {
  stability(features = features, measure = "zucknick",
    sim.mat = sim.mat, threshold = threshold,
    correction.for.chance = correction.for.chance,
    N = N, impute.na = impute.na)
}


#' @export
#' @title Stability Measure Yu
#' @inherit stabilityDocumentation
#' @inherit adjustedDocumentation
#' @details Let \eqn{O_{ij}} denote the number of features in \eqn{V_i} that are not
#' shared with \eqn{V_j} but that have a highly simlar feature in \eqn{V_j}:
#' \deqn{O_{ij} = |\{ x \in (V_i \backslash V_j) : \exists y \in (V_j \backslash V_i) \ with \
#' Similarity(x,y) \geq threshold \}|.}
#' Then the stability measure is defined as (see Notation)
#'  \deqn{\frac{2}{m(m-1)}\sum_{i=1}^{m-1} \sum_{j=i+1}^{m}
#' \frac{I(V_i, V_j) - E(I(V_i, V_j))}{\frac{|V_i| + |V_j|}{2} - E(I(V_i, V_j))}} with
#' \deqn{I(V_i, V_j) = |V_i \cap V_j| + \frac{O_{ij} + O_{ji}}{2}.}
#' Note that this definition slightly differs from its original in order to make it suitable
#' for arbitrary datasets and similarity measures and applicable in situations with \eqn{|V_i| \neq |V_j|}.
#' @references
#' * L. Yu, Y. Han, and M. E. Berens,
#' "Stable gene selection from microarray data via sample weighting",
#' IEEE/ACM Transactions on Computational Biology and Bioinformatics,
#' vol. 9, no. 1, pp. 262-272, 2012.
#' * M. Zhang, L. Zhang, J. Zou, C. Yao, H. Xiao, Q. Liu, J. Wang, D. Wang,
#' C. Wang, and Z. Guo,
#' "Evaluating reproducibility of differential expression discoveries in microarray
#' studies by considering correlated molecular changes", Bioinformatics,
#' vol. 25, no. 13, pp. 1662-1668, 2009.
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' mat = 0.92 ^ abs(outer(1:10, 1:10, "-"))
#' stabilityYu(features = feats, sim.mat = mat, N = 1000)
stabilityYu = function(features, sim.mat, threshold = 0.9,
  correction.for.chance = "estimate", N = 1e4, impute.na = NULL) {
  stability(features = features, measure = "yu",
    sim.mat = sim.mat, threshold = threshold,
    correction.for.chance = correction.for.chance,
    N = N, impute.na = impute.na)
}


#' @export
#' @title Stability Measure Adjusted Intersection MBM
#' @inherit stabilityDocumentation
#' @inherit adjustedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m(m-1)}\sum_{i=1}^{m-1} \sum_{j=i+1}^{m}
#' \frac{I(V_i, V_j) - E(I(V_i, V_j))}{\sqrt{|V_i| \cdot |V_j|} - E(I(V_i, V_j))}}
#' with \deqn{I(V_i, V_j) = |V_i \cap V_j| + MBM(V_i \backslash V_j, V_j \backslash V_i).}
#' \eqn{MBM(V_i \backslash V_j, V_j \backslash V_i)} denotes the size of the
#' maximum bipartite matching based on the graph whose vertices are the features
#' of \eqn{V_i \backslash V_j} on the one side and the features of \eqn{V_j \backslash V_i}
#' on the other side. Vertices x and y are connected if and only if \eqn{Similarity(x, y)
#' \geq threshold.}
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' mat = 0.92 ^ abs(outer(1:10, 1:10, "-"))
#' stabilityIntersectionMBM(features = feats, sim.mat = mat, N = 1000)
stabilityIntersectionMBM = function(features, sim.mat, threshold = 0.9,
  correction.for.chance = "estimate", N = 1e4, impute.na = NULL) {
  requireNamespace("igraph")
  stability(features = features, measure = "intersection.mbm",
    sim.mat = sim.mat, threshold = threshold,
    correction.for.chance = correction.for.chance,
    N = N, impute.na = impute.na)
}

#' @export
#' @title Stability Measure Adjusted Intersection Greedy
#' @inherit stabilityDocumentation
#' @inherit adjustedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m(m-1)}\sum_{i=1}^{m-1} \sum_{j=i+1}^{m}
#' \frac{I(V_i, V_j) - E(I(V_i, V_j))}{\sqrt{|V_i| \cdot |V_j|} - E(I(V_i, V_j))}} with
#' \deqn{I(V_i, V_j) = |V_i \cap V_j| + GMBM(V_i \backslash V_j, V_j \backslash V_i).}
#' \eqn{GMBM(V_i \backslash V_j, V_j \backslash V_i)} denotes a greedy approximation
#' of \eqn{MBM(V_i \backslash V_j, V_j \backslash V_i)}, see \link{stabilityIntersectionMBM}.
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' mat = 0.92 ^ abs(outer(1:10, 1:10, "-"))
#' stabilityIntersectionGreedy(features = feats, sim.mat = mat, N = 1000)
stabilityIntersectionGreedy = function(features, sim.mat, threshold = 0.9,
  correction.for.chance = "estimate", N = 1e4, impute.na = NULL) {
  stability(features = features, measure = "intersection.greedy",
    sim.mat = sim.mat, threshold = threshold,
    correction.for.chance = correction.for.chance,
    N = N, impute.na = impute.na)
}

#' @export
#' @title Stability Measure Adjusted Intersection Count
#' @inherit stabilityDocumentation
#' @inherit adjustedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m(m-1)}\sum_{i=1}^{m-1} \sum_{j=i+1}^{m}
#' \frac{I(V_i, V_j) - E(I(V_i, V_j))}{\sqrt{|V_i| \cdot |V_j|} - E(I(V_i, V_j))}}
#' with \deqn{I(V_i, V_j) = |V_i \cap V_j| + \min (C(V_i, V_j), C(V_j, V_i))} and
#' \deqn{C(V_k, V_l) = |\{x \in  V_k \backslash V_l : \exists y \in
#' V_l \backslash V_k \ with \ Similarity (x,y) \geq threshold \}|.}
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' mat = 0.92 ^ abs(outer(1:10, 1:10, "-"))
#' stabilityIntersectionCount(features = feats, sim.mat = mat, N = 1000)
stabilityIntersectionCount = function(features, sim.mat, threshold = 0.9,
  correction.for.chance = "estimate", N = 1e4, impute.na = NULL) {
  stability(features = features, measure = "intersection.count",
    sim.mat = sim.mat, threshold = threshold,
    correction.for.chance = correction.for.chance,
    N = N, impute.na = impute.na)
}

#' @export
#' @title Stability Measure Adjusted Intersection Mean
#' @inherit stabilityDocumentation
#' @inherit adjustedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m(m-1)}\sum_{i=1}^{m-1} \sum_{j=i+1}^{m}
#' \frac{I(V_i, V_j) - E(I(V_i, V_j))}{\sqrt{|V_i| \cdot |V_j|} - E(I(V_i, V_j))}}
#' with \deqn{I(V_i, V_j) = |V_i \cap V_j| + \min (C(V_i, V_j), C(V_j, V_i)),}
#' \deqn{C(V_k, V_l) = \sum_{x \in V_k \backslash V_l : |G^{kl}_x| > 0}
#' \frac{1}{|G^{kl}_x|} \sum_{y \in G^{kl}_x} \ Similarity (x,y)} and
#' \deqn{G^{kl}_x = \{y \in V_l \backslash V_k: \ Similarity (x, y) \geq threshold \}.}
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' mat = 0.92 ^ abs(outer(1:10, 1:10, "-"))
#' stabilityIntersectionMean(features = feats, sim.mat = mat, N = 1000)
stabilityIntersectionMean = function(features, sim.mat, threshold = 0.9,
  correction.for.chance = "estimate", N = 1e4, impute.na = NULL) {
  stability(features = features, measure = "intersection.mean",
    sim.mat = sim.mat, threshold = threshold,
    correction.for.chance = correction.for.chance,
    N = N, impute.na = impute.na)
}
