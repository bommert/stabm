#' @export
#' @title Stability Measure Lustgarten
#' @inherit stabilityDocumentation
#' @inherit correctedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m (m - 1)} \sum_{i=1}^{m-1} \sum_{j = i+1}^m
#' \frac{|V_i \cap V_j| - \frac{|V_i| \cdot |V_j|}{p}}
#' {\min \{|V_i|, |V_j|\} - \max \{ 0, |V_i| + |V_j| - p \}}.}
#' @references
#' * J. L. Lustgarten, V. Gopalakrishnan, and S. Visweswaran,
#' "Measuring stability of feature selection in biomedical datasets",
#' AMIA Annual Symposium proceedings/AMIA Symposium.
#' AMIA Symposium, vol. 2009, pp. 406-410, 2009.
#' * A. Bommert, J. Rahnenführer, and M. Lang,
#' "A multi-criteria approach to find predictive and sparse models with
#' stable feature selection for high-dimensional data",
#' Computational and mathematical methods in medicine, 2017.
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityLustgarten(features = feats, p = 10)
stabilityLustgarten = function(features, p, impute.na = NULL) {
  stability(features = features, p = p, measure = "lustgarten",
    correction.for.chance = "none",
    N = NULL, impute.na = impute.na)
}

#' @export
#' @title Stability Measure Somol
#' @inherit stabilityDocumentation
#' @inherit correctedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{\left(\sum\limits_{j=1}^p \frac{h_j}{q} \frac{h_j - 1}{m-1}\right) -
#' c_{\min}}{c_{\max} - c_{\min}}} with
#' \deqn{c_{\min} = \frac{q^2 - p(q - q \ mod \ p) - \left(q \ mod \ p\right)^2}{p q (m-1)},}
#' \deqn{c_{\max} = \frac{\left(q \ mod \ m\right)^2 + q(m-1) - \left(q \ mod \ m\right)m}{q(m-1)}.}
#' @references
#' * P. Somol and J. Novovičová, "Evaluating stability and comparing
#' output of feature selectors that optimize feature subset
#' cardinality", IEEE Transactions on Pattern Analysis and Machine
#' Intelligence, vol. 32, no. 11, pp. 1921-1939, 2010.
#' * A. Bommert, J. Rahnenführer, and M. Lang,
#' "A multi-criteria approach to find predictive and sparse models with
#' stable feature selection for high-dimensional data",
#' Computational and mathematical methods in medicine, 2017.
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilitySomol(features = feats, p = 10)
stabilitySomol = function(features, p, impute.na = NULL) {
  stability(features = features, p = p, measure = "somol",
    correction.for.chance = "none", N = NULL, impute.na = impute.na)
}

#' @export
#' @title Stability Measure Phi
#' @inherit stabilityDocumentation
#' @inherit correctedDocumentation
#' @details The stability measure is defined as the average
#' phi coefficient between all pairs of feature sets.
#' It can be rewritten as (see Notation)
#' \deqn{\frac{2}{m (m - 1)} \sum_{i=1}^{m-1} \sum_{j = i+1}^m
#' \frac{|V_i \cap V_j| - \frac{|V_i| \cdot |V_j|}{p}}
#' {\sqrt{|V_i| (1 - \frac{|V_i|}{p}) \cdot |V_j| (1 - \frac{|V_j|}{p})}}.}
#' @references
#' * S. Nogueira and G. Brown, "Measuring the stability of feature
#' selection", in Machine Learning and Knowledge Discovery in
#' Databases, vol. 9852 of Lecture Notes in Computer Science, pp. 442-457,
#' Springer International Publishing, Cham, 2016.
#' * A. Bommert, J. Rahnenführer, and M. Lang,
#' "A multi-criteria approach to find predictive and sparse models with
#' stable feature selection for high-dimensional data",
#' Computational and mathematical methods in medicine, 2017.
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityPhi(features = feats, p = 10)
stabilityPhi = function(features, p, impute.na = NULL) {
  stability(features = features, p = p, measure = "phi.coefficient",
    correction.for.chance = "none", N = NULL, impute.na = impute.na)
}

#' @export
#' @title Stability Measure Kappa
#' @inherit stabilityDocumentation
#' @inherit correctedDocumentation
#' @details The stability measure is defined as the average
#' kappa coefficient between all pairs of feature sets.
#' It can be rewritten as (see Notation)
#' \deqn{\frac{2}{m (m - 1)} \sum_{i=1}^{m-1} \sum_{j = i+1}^m
#' \frac{|V_i \cap V_j| - \frac{|V_i| \cdot |V_j|}{p}}
#' {\frac{|V_i| + |V_j|}{2} - \frac{|V_i| \cdot |V_j|}{p}}.}
#' @references J. Cohen, "A coefficient of agreement for nominal scales",
#' Educational and psychological measurement, vol. 20, no. 1, pp. 37-46, 1960.
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityKappa(features = feats, p = 10)
stabilityKappa = function(features, p, impute.na = NULL) {
  stability(features = features, p = p, measure = "kappa.coefficient",
    correction.for.chance = "none", N = NULL, impute.na = impute.na)
}


#' @export
#' @title Stability Measure Nogueira
#' @inherit stabilityDocumentation
#' @inherit correctedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{1 - \frac{\frac{1}{p} \sum_{j=1}^p \frac{m}{m-1} \frac{h_j}{m} \left(1 - \frac{h_j}{m}\right)}
#' {\frac{q}{mp} (1 - \frac{q}{mp})}.}
#' @references S. Nogueira, "Quantifying the Stability of Feature Selection",
#' Diss. PhD thesis, University of Manchester, 2018.
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityNogueira(features = feats, p = 10)
stabilityNogueira = function(features, p, impute.na = NULL) {
  stability(features = features, p = p, measure = "nogueira",
    correction.for.chance = "none", N = NULL, impute.na = impute.na)
}



#' @export
#' @title Stability Measure Unadjusted
#' @inherit stabilityDocumentation
#' @inherit correctedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m (m - 1)} \sum_{i=1}^{m-1} \sum_{j = i+1}^m
#' \frac{|V_i \cap V_j| - \frac{|V_i| \cdot |V_j|}{p}}
#' {\sqrt{|V_i| \cdot |V_j|} - \frac{|V_i| \cdot |V_j|}{p}}.}
#' This is what \link{stabilityIntersectionMBM}, \link{stabilityIntersectionGreedy},
#' \link{stabilityIntersectionCount} and \link{stabilityIntersectionMean}
#' become, when there are no similar features.
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityUnadjusted(features = feats, p = 10)
stabilityUnadjusted = function(features, p, impute.na = NULL) {
  stability(features = features, p = p, measure = "intersection.common",
    correction.for.chance = "unadjusted",
    N = NULL, impute.na = impute.na)
}


#' @export
#' @title Stability Measure Wald
#' @inherit stabilityDocumentation
#' @inherit correctedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m (m - 1)} \sum_{i=1}^{m-1} \sum_{j = i+1}^m
#' \frac{|V_i \cap V_j| - \frac{|V_i| \cdot |V_j|}{p}}
#' {\min \{|V_i|, |V_j|\} - \frac{|V_i| \cdot |V_j|}{p}}.}
#' @references
#' * Wald, R., T. M. Khoshgoftaar, and A. Napolitano (2013). “Stability of filter-and wrapper-based feature
#' subset selection.” In: 2013 IEEE 25th International Conference on Tools with Artificial Intelligence, pp. 374–380.
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityWald(features = feats, p = 10)
stabilityWald = function(features, p, impute.na = NULL) {
  stability(features = features, p = p, measure = "wald",
    correction.for.chance = "none",
    N = NULL, impute.na = impute.na)
}
