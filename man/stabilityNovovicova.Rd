% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stability_functions_uncorrected.R
\encoding{UTF-8}
\name{stabilityNovovicova}
\alias{stabilityNovovicova}
\title{Stability Measure Novovičová}
\usage{
stabilityNovovicova(
  features,
  p = NULL,
  correction.for.chance = "none",
  N = 10000,
  impute.na = NULL
)
}
\arguments{
\item{features}{\code{list (length >= 2)}\cr
Chosen features per dataset. Each element of the list contains the features for one dataset.
The features must be given by their names (\code{character}) or indices (\code{integerish}).}

\item{p}{\code{numeric(1)}\cr
Total number of features in the datasets.
Required, if \code{correction.for.chance} is set to "estimate" or "exact".}

\item{correction.for.chance}{\code{character(1)}\cr
Should a correction for chance be applied? Correction for chance means that if
features are chosen at random, the expected value must be independent of the number
of chosen features. To correct for chance, the original score is transformed by
\eqn{(score - expected) / (maximum - expected)}. For stability measures whose
score is the average value of pairwise scores, this transformation
is done for all components individually.
Options are "none", "estimate" and "exact".
For "none", no correction is performed, i.e. the original score is used.
For "estimate", \code{N} random feature sets of the same sizes as the input
feature sets (\code{features}) are generated.
For "exact", all possible combinations of feature sets of the same
sizes as the input feature sets are used. Computation is only feasible for very
small numbers of features (\code{p}) and numbers of considered datasets
(\code{length(features)}).}

\item{N}{\code{numeric(1)}\cr
Number of random feature sets to consider. Only relevant if \code{correction.for.chance}
is set to "estimate".}

\item{impute.na}{\code{numeric(1)}\cr
In some scenarios, the stability cannot be assessed based on all feature sets.
E.g. if some of the feature sets are empty, the respective pairwise comparisons yield NA as result.
With which value should these missing values be imputed? \code{NULL} means no imputation.}
}
\value{
\code{numeric(1)} Stability value.
}
\description{
The stability of feature selection is defined as the robustness of
the sets of selected features with respect to small variations in the data on which the
feature selection is conducted. To quantify stability, several datasets from the
same data generating process can be used. Alternatively, a single dataset can be
split into parts by resampling. Either way, all datasets used for feature selection must
contain exactly the same features. The feature selection method of interest is
applied on all of the datasets and the sets of chosen features are recorded.
The stability of the feature selection is assessed based on the sets of chosen features
using stability measures.
}
\details{
The stability measure is defined as (see Notation)
\deqn{\frac{1}{q \log_2(m)} \sum_{j: X_j \in V} h_j \log_2(h_j).}
}
\section{Notation}{
 For the definition of all stability measures in this package,
the following notation is used:
Let \eqn{V_1, \ldots, V_m} denote the sets of chosen features
for the \eqn{m} datasets, i.e. \code{features} has length \eqn{m} and
\eqn{V_i} is a set which contains the \eqn{i}-th entry of \code{features}.
Furthermore, let \eqn{h_j} denote the number of sets that contain feature
\eqn{X_j} so that \eqn{h_j} is the absolute frequency with which feature \eqn{X_j}
is chosen.
Analogously, let \eqn{h_{ij}} denote the number of sets that include both \eqn{X_i} and \eqn{X_j}.
Also, let \eqn{q = \sum_{j=1}^p h_j = \sum_{i=1}^m |V_i|} and \eqn{V = \bigcup_{i=1}^m V_i}.
}

\examples{
feats = list(1:3, 1:4, 1:5)
stabilityNovovicova(features = feats)
}
\references{
Novovičová J, Somol P, Pudil P (2009).
\dQuote{A New Measure of Feature Selection Algorithms' Stability.}
In \emph{2009 IEEE International Conference on Data Mining Workshops}.
\doi{10.1109/icdmw.2009.32}.

Bommert A, Rahnenführer J, Lang M (2017).
\dQuote{A Multicriteria Approach to Find Predictive and Sparse Models with Stable Feature Selection for High-Dimensional Data.}
\emph{Computational and Mathematical Methods in Medicine}, \bold{2017}, 1--18.
\doi{10.1155/2017/7907163}.

Bommert A (2020).
\emph{Integration of Feature Selection Stability in Model Fitting}.
Ph.D. thesis, TU Dortmund University, Germany.
\doi{10.17877/DE290R-21906}.
}
\seealso{
\link{listStabilityMeasures}
}
