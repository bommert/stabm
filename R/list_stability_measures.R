#' @export
#' @title List All Available Stability Measures
#' @description Lists all stability measures of package \emph{stabm} and
#' provides information about them.
#' @return \code{data.frame} \cr
#' For each stability measure, its name,
#' the information, whether it is corrected for chance by definition,
#' the information, whether it is adjusted for similar features,
#' its minimal value and its maximal value are displayed.
#' @section Note: The given minimal values might only be reachable
#' in some scenarios, e.g. if the feature sets have a certain size.
#' The measures which are not corrected for chance by definition can
#' be corrected for chance with \code{correction.for.chance}.
#' This however changes the minimal value.
#' For the adjusted stability measures, the minimal value depends
#' on the similarity structure.
#' @examples
#' listStabilityMeasures()
listStabilityMeasures = function() {
  stabilityMeasures
}
