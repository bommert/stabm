#' @export
#' @title Stability Measure Davis
#' @inherit stabilityDocumentation
#' @inherit uncorrectedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\max \left\{ 0, \frac{1}{|V|} \sum_{j=1}^p \frac{h_j}{m} - \frac{penalty}{p}
#' \cdot median \{ |V_1|, \ldots, |V_m| \}  \right\}.}
#' @references
#' * C. A. Davis, F. Gerick, V. Hintermair, C. C. Friedel, K. Fundel,
#' R. Küffner, and R. Zimmer, "Reliable gene signatures
#' for microarray classification: assessment of stability and performance",
#' Bioinformatics, vol. 22, no. 19, pp. 2356-2363, 2006.
#' * A. Bommert, J. Rahnenführer, and M. Lang,
#' "A multi-criteria approach to find predictive and sparse models with
#' stable feature selection for high-dimensional data",
#' Computational and mathematical methods in medicine, 2017.
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityDavis(features = feats, p = 10)
stabilityDavis = function(features, p,
  correction.for.chance = "none", N = 1e4, impute.na = NULL, penalty = 0) {
  stability(features = features, p = p, measure = "davis",
    correction.for.chance = correction.for.chance,
    N = N, penalty = penalty, impute.na = impute.na)
}

#' @export
#' @title Stability Measure Dice
#' @inherit stabilityDocumentation
#' @inherit uncorrectedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m (m - 1)} \sum_{i=1}^{m-1} \sum_{j = i+1}^m
#' \frac{2 |V_i \cap V_j|}{|V_i| + |V_j|}.}
#' @references
#' * L. R. Dice, "Measures of the amount of ecologic association
#' between species", Ecology, vol. 26, no. 3, pp. 297-302, 1945.
#' * A. Bommert, J. Rahnenführer, and M. Lang,
#' "A multi-criteria approach to find predictive and sparse models with
#' stable feature selection for high-dimensional data",
#' Computational and mathematical methods in medicine, 2017.
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityDice(features = feats)
stabilityDice = function(features, p = NULL,
  correction.for.chance = "none", N = 1e4, impute.na = NULL) {
  stability(features = features, p = p, measure = "dice",
    correction.for.chance = correction.for.chance,
    N = N, impute.na = impute.na)
}

#' @export
#' @title Stability Measure Jaccard
#' @inherit stabilityDocumentation
#' @inherit uncorrectedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m (m - 1)} \sum_{i=1}^{m-1} \sum_{j = i+1}^m
#' \frac{|V_i \cap V_j|}{|V_i \cup V_j|}.}
#' @references
#' * P. Jaccard, "Étude comparative de la distribution florale dans
#' une portion des alpes et du jura", Bulletin de la Société Vaudoise des
#' Sciences Naturelles, vol. 37, pp. 547-579, 1901.
#' * A. Bommert, J. Rahnenführer, and M. Lang,
#' "A multi-criteria approach to find predictive and sparse models with
#' stable feature selection for high-dimensional data",
#' Computational and mathematical methods in medicine, 2017.
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityJaccard(features = feats)
stabilityJaccard = function(features, p = NULL,
  correction.for.chance = "none", N = 1e4, impute.na = NULL) {
  stability(features = features, p = p, measure = "jaccard",
    correction.for.chance = correction.for.chance,
    N = N, impute.na = impute.na)
}

#' @export
#' @title Stability Measure Novovičová
#' @inherit stabilityDocumentation
#' @inherit uncorrectedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{1}{q \log_2(m)} \sum_{j: X_j \in V} h_j \log_2(h_j).}
#' @references
#' * J. Novovičová, P. Somol, and P. Pudil, "A new measure of feature
#' selection algorithms’ stability", in Proceedings of the 2009 IEEE
#' International Conference on Data Mining Workshops,
#' ICDMW 2009, pp. 382–387, December 2009.
#' * A. Bommert, J. Rahnenführer, and M. Lang,
#' "A multi-criteria approach to find predictive and sparse models with
#' stable feature selection for high-dimensional data",
#' Computational and mathematical methods in medicine, 2017.
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityNovovicova(features = feats)
stabilityNovovicova = function(features, p = NULL,
  correction.for.chance = "none", N = 1e4, impute.na = NULL) {
  stability(features = features, p = p, measure = "novovicova",
    correction.for.chance = correction.for.chance,
    N = N, impute.na = impute.na)
}

#' @export
#' @title Stability Measure Ochiai
#' @inherit stabilityDocumentation
#' @inherit uncorrectedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m (m - 1)} \sum_{i=1}^{m-1} \sum_{j = i+1}^m
#' \frac{|V_i \cap V_j|}{\sqrt{|V_i| \cdot |V_j|}}.}
#' @references
#' * A. Ochiai, "Zoogeographic studies on the soleoid fishes found
#' in Japan and its neighbouring regions", Bulletin of the Japanese Society
#' for the Science of Fish, vol. 22, no. 9, pp. 526-530, 1957.
#' * A. Bommert, J. Rahnenführer, and M. Lang,
#' "A multi-criteria approach to find predictive and sparse models with
#' stable feature selection for high-dimensional data",
#' Computational and mathematical methods in medicine, 2017.
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityOchiai(features = feats)
stabilityOchiai = function(features, p = NULL,
  correction.for.chance = "none", N = 1e4, impute.na = NULL) {
  stability(features = features, p = p, measure = "ochiai",
    correction.for.chance = correction.for.chance,
    N = N, impute.na = impute.na)
}
