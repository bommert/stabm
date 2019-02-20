#' @name stabilityDocumentation
#' @keywords internal
#' @title Stability of Feature Selection
#' @description The stability of feature selection is defined as the robustness of
#' the sets of selected features with respect to small variations in the data on which the
#' feature selection is conducted. To quantify stability, several datasets from the
#' same data generating process can be used. Alternatively, a single dataset can be
#' split into parts by resampling. Either way, all datasets used for feature selection must
#' contain exactly the same features. The feature selection method of interest is
#' applied on all of the datasets and the sets of chosen features are recorded.
#' The stability of the feature selection is assessed based on the sets of chosen features
#' using stability measures.
#' @param features \code{list (length >= 2)}\cr
#' Chosen features per dataset. Each element of the list contains the features for one dataset.
#' The features must be given by their names (\code{character}) or indices (\code{integerish}).
#' @param penalty \code{numeric(1)}\cr
#' Penalty parameter, see Details.
#' @param impute.na \code{numeric(1)}\cr
#' In some scenarios, the stability cannot be assessed based on all feature sets.
#' E.g. if some of the feature sets are empty, the respective pairwise comparisons yield NA as result.
#' With which value should these missing values be imputed? \code{NULL} means no imputation.
#' @param N \code{numeric(1)}\cr
#' Number of random feature sets to consider. Only relevant if \code{correction.for.chance}
#' is set to "estimate".
#' @param sim.mat \code{numeric matrix}\cr
#' Similarity matrix which contains the similarity structure of all features based on
#' all datasets. The similarity values must be in the range of [0, 1] where 0 indicates
#' very low similarity and 1 indicates very high similarity. If the list elements of
#' \code{features} are integerish vectors, then the feature numbering must correspond to the
#' ordering of \code{sim.mat}. If the list elements of \code{features} are character
#' vectors, then \code{sim.mat} must be named and the names of \code{sim.mat} must correspond
#' to the entries in \code{features}.
#' @param threshold \code{numeric(1)}\cr
#' Threshold for indicating which features are similar and which are not. Two features
#' are considered as similar, if and only if the corresponding entry of \code{sim.mat} is greater
#' than or equal to \code{threshold}.
#' @section Notation: For the definition of all stability measures in this package,
#' the following notation is used:
#' Let \eqn{V_1, \ldots, V_m} denote the sets of chosen features
#' for the \eqn{m} datasets, i.e. \code{features} has length \eqn{m} and
#' \eqn{V_i} is a set which contains the \eqn{i}-th entry of \code{features}.
#' Furthermore, let \eqn{h_j} denote the number of sets that contain feature
#' \eqn{X_j} so that \eqn{h_j} is the absolute frequency with which feature \eqn{X_j}
#' is chosen.
#' Also, let \eqn{q = \sum_{j=1}^p h_j}, \eqn{V = \bigcup_{i=1}^m V_i} and
#' \eqn{k = \frac{1}{m} \sum_{i=1}^m |V_i|}.
#' @return \code{numeric(1)} Stability value.
#' @seealso \link{listStabilityMeasures}
NULL


#' @name uncorrectedDocumentation
#' @keywords internal
#' @title Uncorrected Stability Measures
#' @param p \code{numeric(1)}\cr
#' Total number of features in the datasets.
#' Required, if \code{correction.for.chance} is set to "estimate" or "exact".
#' @param correction.for.chance \code{character(1)}\cr
#' Should a correction for chance be applied? Correction for chance means that if
#' features are chosen at random, the expected value must be independent of the number
#' of chosen features. To correct for chance, the original score is transformed by
#' \eqn{(score - expected) / (maximum - expected)}. For stability measures whose
#' score is the average value of pairwise scores, this transformation
#' is done for all components individually.
#' Options are "none", "estimate" and "exact".
#' For "none", no correction is performed, i.e. the original score is used.
#' For "estimate", \code{N} random feature sets of the same sizes as the input
#' feature sets (\code{features}) are generated.
#' For "exact", all possible combinations of feature sets of the same
#' sizes as the input feature sets are used. Computation is only feasible for very
#' small numbers of features (\code{p}) and numbers of considered datasets
#' (\code{length(features)}).
NULL


#' @name correctedDocumentation
#' @keywords internal
#' @title Corrected Stability Measures
#' @param p \code{numeric(1)}\cr
#' Total number of features in the datasets.
NULL


#' @name adjustedDocumentation
#' @keywords internal
#' @title Adjusted Stability Measures
#' @param correction.for.chance \code{character(1)}\cr
#' How should the expected value of the stability score (see Details)
#' be assessed? Options are "estimate" and "exact".
#' For "estimate", \code{N} random feature sets of the same sizes as the input feature
#' sets (\code{features}) are generated.
#' For "exact", all possible combinations of feature sets of the same
#' sizes as the input feature sets are used. Computation is only feasible for very
#' small numbers of features and numbers of considered datasets (\code{length(features)}).
NULL