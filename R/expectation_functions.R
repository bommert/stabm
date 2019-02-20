simulate.expectation = function(features, F.all, N, fun, ...) {
  measureScoreHelper(features = features,
    measureFun = function(F1, F2) {
    ns = c(length(F1), length(F2))
    samples = lapply(seq_len(N), function(j) {
      lapply(ns, function(ni) {
        sample(F.all, ni)
      })
    })
    scores.samples = sapply(samples, fun, F.all = F.all, ...)
    expected = mean(scores.samples)
    return(expected)
  })
}


calculate.expectation = function(features, F.all, fun, ...) {
  p = length(F.all)
  n.combs = measureScoreHelper(features = features,
    measureFun = function(F1, F2) {
      choose(p, length(F1)) * choose(p, length(F2))
  })
  n.combs = sum(n.combs)
  if (n.combs > 1e6) {
    msg = paste(n.combs, "combinations needed for exact correction for chance. Computation may not be feasible!")
    warning(msg)
  }

  measureScoreHelper(features = features,
    measureFun = function(F1, F2) {
      ns = c(length(F1), length(F2))
      n = 2

      combs.single = lapply(seq_along(ns), function(i) {
        ni = ns[i]
        if (ni > 0) {
          df = as.data.frame(gtools::combinations(p, ni, F.all), stringsAsFactors = FALSE)
          colnames(df) = paste0("V", seq_len(ncol(df)), ".", i)
        } else {
          df = data.frame(NA)
          colnames(df) = paste0("V", seq_len(ncol(df)), ".", i)
        }
        return(df)
      })

      combs.all = Reduce(function(x, y) merge(x, y, all = TRUE), combs.single)
      combs.all = as.matrix(combs.all)
      colnames(combs.all) = NULL

      # bring into format list of lists
      ns.modified = ns
      ns.modified[ns.modified == 0L] = 1L
      tmp.cs = cumsum(c(0, ns.modified[-n]))
      s.inds = lapply(seq_along(ns.modified), function(i) tmp.cs[i] + seq_len(ns.modified[i]))
      samples = lapply(seq_len(nrow(combs.all)), function(i) {
        lapply(s.inds, function(inds) {
          ret = combs.all[i, inds]
          if (any(is.na(ret))) {
            if (is.character(F.all)) {
              ret = character(0L)
            } else {
              ret = numeric(0L)
            }
          }
          return(ret)
        })
      })
      rm(combs.all)

      scores.samples = sapply(samples, fun, F.all = F.all, ...)
      expected = mean(scores.samples)

      return(expected)
    })
}



unadjusted.expectation = function(features, F.all, ...) {
  p = length(F.all)
  measureScoreHelper(features = features,
    measureFun = function(F1, F2) {
      n1 = length(F1)
      n2 = length(F2)
      expected = n1 * n2 / p
      return(expected)
  })
}