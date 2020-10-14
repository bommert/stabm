measureScoreHelper = function(features, measureFun) {
  n = length(features)
  scores = unlist(lapply(1:(n - 1), function(i) {
    sapply((i + 1):n, function(j) {
      measureFun(features[[i]], features[[j]])
    })
  }))
  return(scores)
}
