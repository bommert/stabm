
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stabm

[![R-CMD-check](https://github.com/bommert/stabm/workflows/R-CMD-check/badge.svg)](https://github.com/bommert/stabm/actions)
[![CRAN
Status](https://www.r-pkg.org/badges/version-ago/stabm)](https://cran.r-project.org/package=stabm)
[![DOI](https://joss.theoj.org/papers/10.21105/joss.03010/status.svg)](https://doi.org/10.21105/joss.03010)

`stabm` provides an implementation of many measures which assess the
stability of feature selection. The following stability measures are
currently included:

``` r
stabm::listStabilityMeasures()
#>                           Name Corrected Adjusted Minimum Maximum
#> 1               stabilityDavis     FALSE    FALSE       0       1
#> 2                stabilityDice     FALSE    FALSE       0       1
#> 3             stabilityHamming     FALSE    FALSE       0       1
#> 4   stabilityIntersectionCount      TRUE     TRUE    <NA>       1
#> 5  stabilityIntersectionGreedy      TRUE     TRUE    <NA>       1
#> 6     stabilityIntersectionMBM      TRUE     TRUE    <NA>       1
#> 7    stabilityIntersectionMean      TRUE     TRUE    <NA>       1
#> 8             stabilityJaccard     FALSE    FALSE       0       1
#> 9               stabilityKappa      TRUE    FALSE      -1       1
#> 10         stabilityLustgarten      TRUE    FALSE      -1       1
#> 11           stabilityNogueira      TRUE    FALSE      -1       1
#> 12         stabilityNovovicova     FALSE    FALSE       0       1
#> 13             stabilityOchiai     FALSE    FALSE       0       1
#> 14                stabilityPhi      TRUE    FALSE      -1       1
#> 15           stabilitySechidis     FALSE     TRUE    <NA>      NA
#> 16              stabilitySomol      TRUE    FALSE       0       1
#> 17         stabilityUnadjusted      TRUE    FALSE      -1       1
#> 18               stabilityWald      TRUE    FALSE     1-p       1
#> 19                 stabilityYu      TRUE     TRUE    <NA>       1
#> 20           stabilityZucknick     FALSE     TRUE       0       1
```

## Installation

You can install the released version of stabm from
[CRAN](https://cran.r-project.org/package=stabm) with:

``` r
install.packages("stabm")
```

For the development version, use
[devtools](https://cran.r-project.org/package=devtools):

``` r
devtools::install_github("bommert/stabm")
```

## Contributions

This R package is licensed under the
[LGPL-3](https://www.gnu.org/licenses/lgpl-3.0.en.html). If you
encounter problems using this software (lack of documentation,
misleading or wrong documentation, unexpected behaviour, bugs, …) or
just want to suggest features, please open an issue in the [issue
tracker](https://github.com/bommert/stabm/issues). Pull requests are
welcome and will be included at the discretion of the author.

## Code of Conduct

Please note that the `stabm` project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
