davis = list(
  scoreFun = function(features, p, penalty, ...) {
    # number of feature sets
    n = length(features)

    # not all feature sets can be empty
    n.chosen = unlist(lapply(features, length))
    if (all(n.chosen == 0)) return(NA_real_)

    # all selected features
    all.features = unlist(features)

    # frequencies of features
    freq = table(all.features)

    # median number of selected features
    median.f = median(n.chosen)

    # calculate index
    part1 = sum(freq) / (n * length(unique(all.features)))
    part2 = penalty * median.f / p
    score = max(c(0, part1 - part2))

    return(score)
  },
  maxValueFun = function(features, p, penalty, ...) {
    n = length(features)
    max(1 - penalty / p, floor((n - 1) / 2) / n)
  }
)

dice = list(
  scoreFun = function(features, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        n1 = length(F1)
        n2 = length(F2)

        if (n1 == 0 && n2 == 0) {
          return(NA_real_)
        }

        size.intersection = length(intersect(F1, F2))
        score = 2 * size.intersection / (n1 + n2)

        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    1
  }
)

jaccard = list(
  scoreFun = function(features, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        n1 = length(F1)
        n2 = length(F2)

        if (n1 == 0 && n2 == 0) {
          return(NA_real_)
        }

        size.intersection = length(intersect(F1, F2))
        size.union = length(union(F1, F2))
        score = size.intersection / size.union

        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    1
  }
)

lustgarten = list(
  scoreFun = function(features, p, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        n1 = length(F1)
        n2 = length(F2)

        if (n1 == 0 || n2 == 0 || n1 == p || n2 == p) {
          return(NA_real_)
        }

        size.intersection = length(intersect(F1, F2))
        part1 = size.intersection - n1 * n2 / p
        part2 = min(n1, n2) - max(0, n1 + n2 - p)
        score = part1 / part2

        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    1
  }
)

novovicova = list(
  scoreFun = function(features, ...) {
    # number of feature sets
    n = length(features)

    # not all feature set can be empty
    n.chosen = unlist(lapply(features, length))
    if (all(n.chosen == 0)) return(NA_real_)

    # all selected features
    all.features = unlist(features)

    # frequencies of features
    freq = table(all.features)
    q = sum(freq)

    # calculate index
    score = sum(freq * log2(freq)) / (q * log2(n))

    return(score)
  },
  maxValueFun = function(features, ...) {
    1
  }
)

ochiai = list(
  scoreFun = function(features, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        n1 = length(F1)
        n2 = length(F2)

        if (n1 == 0 || n2 == 0) {
          return(NA_real_)
        }

        size.intersection = length(intersect(F1, F2))
        score = size.intersection / sqrt(n1 * n2)

        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    1
  }
)

somol = list(
  scoreFun = function(features, p, ...) {
    # number of feature sets
    n = length(features)

    # not all feature sets can be empty or contain all p features
    n.chosen = unlist(lapply(features, length))
    if (all(n.chosen == 0)) return(NA_real_)
    if (all(n.chosen == p)) return(NA_real_)

    # all selected features
    all.features = unlist(features)

    # frequencies of features
    freq = table(all.features)
    q = sum(freq)

    # calculate index
    c.min = (q^2 - p * (q - q %% p) - (q %% p)^2) / (p * q * (n - 1))
    c.max = ((q %% n)^2 + q * (n - 1) - (q %% n) * n) / (q * (n - 1))
    somol = (sum(freq * (freq - 1)) / (q * (n - 1)) - c.min) / (c.max - c.min)

    return(somol)
  },
  maxValueFun = function(features, p, ...) {
    1
  }
)

phi.coefficient = list(
  scoreFun = function(features, p, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        n1 = length(F1)
        n2 = length(F2)

        if (n1 == 0 || n2 == 0 || n1 == p || n2 == p) {
          return(NA_real_)
        }

        selected.feats = union(F1, F2)
        feats1 = feats2 = rep(0, p)
        feats1[which(selected.feats %in% F1)] = 1
        feats2[which(selected.feats %in% F2)] = 1

        score = cor(feats1, feats2)
        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    1
  }
)

kappa.coefficient = list(
  scoreFun = function(features, p, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        n1 = length(F1)
        n2 = length(F2)

        if ((n1 == 0 && n2 == 0) || (n1 == p && n2 == p)) {
          return(NA_real_)
        }

        size.intersection = length(intersect(F1, F2))
        expected = n1 * n2 / p
        maximum = (n1 + n2) / 2

        score = (size.intersection - expected) / (maximum - expected)

        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    1
  }
)


nogueira = list(
  scoreFun = function(features, p, ...) {
    ns = lengths(features)
    ns.mean = mean(ns)

    if (ns.mean == 0 || ns.mean == p) {
      return(NA_real_)
    }

    n = length(features)

    all.features = unlist(features)
    freq = table(all.features) / n
    vars = freq * (1 - freq) * n / (n - 1)

    num = sum(vars)
    denom = ns.mean * (1 - ns.mean / p)

    score = 1 - num / denom
    return(score)
  },
  maxValueFun = function(features, ...) {
    1
  }
)


wald = list(
  scoreFun = function(features, p, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        n1 = length(F1)
        n2 = length(F2)

        if (n1 == 0 || n2 == 0) {
          return(NA_real_)
        }

        size.intersection = length(intersect(F1, F2))
        part1 = size.intersection - n1 * n2 / p
        part2 = min(n1, n2) - n1 * n2 / p
        score = part1 / part2

        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    1
  }
)


hamming = list(
  scoreFun = function(features, p, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        size.intersection1 = length(intersect(F1, F2))
        size.intersection2 = p - length(union(F1, F2))
        score = (size.intersection1 + size.intersection2) / p
        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    1
  }
)