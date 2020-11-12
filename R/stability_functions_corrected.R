#' @export
#' @title Stability Measure Lustgarten
#' @inherit stabilityDocumentation
#' @inherit correctedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m (m - 1)} \sum_{i=1}^{m-1} \sum_{j = i+1}^m
#' \frac{|V_i \cap V_j| - \frac{|V_i| \cdot |V_j|}{p}}
#' {\min \{|V_i|, |V_j|\} - \max \{ 0, |V_i| + |V_j| - p \}}.}
#' @references
#' `r format_bib("Lustgarten2009", "Bommert2017")`
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
#' `r format_bib("Somol2010", "Bommert2017")`
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
#' `r format_bib("Nogueira2016", "Bommert2017")`
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
#' @references
#' `r format_bib("Cohen1960")`
#' @encoding UTF-8
#' @md
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
#' @references
#' `r format_bib("Nogueira2018")`
#' @encoding UTF-8
#' @md
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
#' @references
#' `r format_bib("Bommert2020")`
#' @encoding UTF-8
#' @md
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
#' `r format_bib("Wald2013")`
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
