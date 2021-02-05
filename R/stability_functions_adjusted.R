
#' @export
#' @title Stability Measure Zucknick
#' @inherit stabilityDocumentation
#' @inherit uncorrectedDocumentation
#' @details The stability measure is defined as
#' \deqn{\frac{2}{m(m-1)}\sum_{i=1}^{m-1} \sum_{j=i+1}^{m}
#' \frac{|V_i \cap V_j| + C(V_i, V_j) + C(V_j, V_i)}{|V_i \cup V_j|}} with
#' \deqn{C(V_k, V_l) = \frac{1}{|V_l|} \sum_{(x, y) \in V_k \times (V_l \setminus V_k) \ \mathrm{with Similarity}(x,y) \geq \mathrm{threshold}} \mathop{\mathrm{Similarity}}(x,y).}
#' Note that this definition slightly differs from its original in order to make it suitable
#' for arbitrary similarity measures.
#' @references
#' `r format_bib("Zucknick2008", "Bommert2017", "BommertPHD")`
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
#' \deqn{O_{ij} = |\{ x \in (V_i \setminus V_j) : \exists y \in (V_j \backslash V_i) \ with \
#' Similarity(x,y) \geq threshold \}|.}
#' Then the stability measure is defined as (see Notation)
#'  \deqn{\frac{2}{m(m-1)}\sum_{i=1}^{m-1} \sum_{j=i+1}^{m}
#' \frac{I(V_i, V_j) - E(I(V_i, V_j))}{\frac{|V_i| + |V_j|}{2} - E(I(V_i, V_j))}} with
#' \deqn{I(V_i, V_j) = |V_i \cap V_j| + \frac{O_{ij} + O_{ji}}{2}.}
#' Note that this definition slightly differs from its original in order to make it suitable
#' for arbitrary datasets and similarity measures and applicable in situations with \eqn{|V_i| \neq |V_j|}.
#' @references
#' `r format_bib("LeiYu2012", "Zhang2009", "BommertPHD")`
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
#' with \deqn{I(V_i, V_j) = |V_i \cap V_j| + \mathop{\mathrm{MBM}}(V_i \setminus V_j, V_j \backslash V_i).}
#' \eqn{\mathop{\mathrm{MBM}}(V_i \setminus V_j, V_j \backslash V_i)} denotes the size of the
#' maximum bipartite matching based on the graph whose vertices are the features
#' of \eqn{V_i \setminus V_j} on the one side and the features of \eqn{V_j \backslash V_i}
#' on the other side. Vertices x and y are connected if and only if \eqn{\mathrm{Similarity}(x, y)
#' \geq \mathrm{threshold}.}
#' Requires the package \CRANpkg{igraph}.
#' @references
#' `r format_bib("Bommert2020", "BommertPHD")`
#' @encoding UTF-8
#' @md
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
#' \deqn{I(V_i, V_j) = |V_i \cap V_j| + \mathop{\mathrm{GMBM}}(V_i \setminus V_j, V_j \backslash V_i).}
#' \eqn{\mathop{\mathrm{GMBM}}(V_i \setminus V_j, V_j \backslash V_i)} denotes a greedy approximation
#' of \eqn{\mathop{\mathrm{MBM}}(V_i \setminus V_j, V_j \backslash V_i)}, see \link{stabilityIntersectionMBM}.
#' @references
#' `r format_bib("Bommert2020", "BommertPHD")`
#' @encoding UTF-8
#' @md
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
#' \deqn{C(V_k, V_l) = |\{x \in  V_k \setminus V_l : \exists y \in
#' V_l \setminus V_k \ \mathrm{with Similarity} (x,y) \geq \mathrm{threshold} \}|.}
#' @references
#' `r format_bib("Bommert2020", "BommertPHD")`
#' @encoding UTF-8
#' @md
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
#' \deqn{C(V_k, V_l) = \sum_{x \in V_k \setminus V_l : |G^{kl}_x| > 0}
#' \frac{1}{|G^{kl}_x|} \sum_{y \in G^{kl}_x} \ \mathrm{Similarity} (x,y)} and
#' \deqn{G^{kl}_x = \{y \in V_l \setminus V_k: \ \mathrm{Similarity} (x, y) \geq \mathrm{threshold} \}.}
#' @references
#' `r format_bib("Bommert2020", "BommertPHD")`
#' @encoding UTF-8
#' @md
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

#' @export
#' @title Stability Measure Sechidis
#' @inherit stabilityDocumentation
#' @inherit uncorrectedDocumentation
#' @details The stability measure is defined as
#' \deqn{1 - \frac{\mathop{\mathrm{trace}}(CS)}{\mathop{\mathrm{trace}}(C \Sigma)}} with (\eqn{p \times p})-matrices
#' \deqn{(S)_{ij} = \frac{m}{m-1}\left(\frac{h_{ij}}{m} - \frac{h_i}{m} \frac{h_j}{m}\right)} and
#' \deqn{(\Sigma)_{ii} = \frac{q}{mp} \left(1 - \frac{q}{mp}\right),}
#' \deqn{(\Sigma)_{ij} = \frac{\frac{1}{m} \sum_{i=1}^{m} |V_i|^2 - \frac{q}{m}}{p^2 - p} - \frac{q^2}{m^2 p^2}, i \neq j.}
#' The matrix \eqn{C} is created from matrix \code{sim.mat} by setting all values of \code{sim.mat} that are smaller
#' than \code{threshold} to 0. If you want to \eqn{C} to be equal to \code{sim.mat}, use \code{threshold = 0}.
#' @note This stability measure is not corrected for chance.
#' Unlike for the other stability measures in this R package, that are not corrected for chance,
#' for \code{stabilitySechidis}, no \code{correction.for.chance} can be applied.
#' This is because for \code{stabilitySechidis}, no finite upper bound is known at the moment,
#' see \link{listStabilityMeasures}.
#' @references
#' `r format_bib("Sechidis2020", "BommertPHD")`
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' mat = 0.92 ^ abs(outer(1:10, 1:10, "-"))
#' stabilitySechidis(features = feats, sim.mat = mat)
stabilitySechidis = function(features, sim.mat, threshold = 0.9, impute.na = NULL) {
  stability(features = features, measure = "sechidis",
    sim.mat = sim.mat, threshold = threshold,
    correction.for.chance = "none", impute.na = impute.na)
}
