#' @export
#' @title Stability Measure Davis
#' @inherit stabilityDocumentation
#' @inherit uncorrectedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\max \left\{ 0, \frac{1}{|V|} \sum_{j=1}^p \frac{h_j}{m} - \frac{penalty}{p}
#' \cdot \mathop{\mathrm{median}} \{ |V_1|, \ldots, |V_m| \}  \right\}.}
#' @references
#' `r format_bib("Davis2006", "Bommert2017")`
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
#' `r format_bib("Dice1945", "Bommert2017")`
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
#' @title Stability Measure Hamming
#' @inherit stabilityDocumentation
#' @inherit uncorrectedDocumentation
#' @details The stability measure is defined as (see Notation)
#' \deqn{\frac{2}{m (m - 1)} \sum_{i=1}^{m-1} \sum_{j = i+1}^m
#' \frac{|V_i \cap V_j| + |V_i^c \cap V_j^c|}{p}.}
#' @references
#' `r format_bib("Dunne2002")`
#' @encoding UTF-8
#' @md
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' stabilityHamming(features = feats, p = 10)
stabilityHamming = function(features, p,
  correction.for.chance = "none", N = 1e4, impute.na = NULL) {
  stability(features = features, p = p, measure = "hamming",
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
#' `r format_bib("Jaccard1901", "Bommert2017")`
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
#' `r format_bib("Novovicov2009", "Bommert2017")`
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
#' `r format_bib("Ochiai1957", "Bommert2017")`
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
