stabilityMeasures = local({
  l = list(
    data.frame(Name = "stabilityDavis", Corrected = FALSE, Adjusted = FALSE,
      Minimum = 0, Maximum = 1, stringsAsFactors = FALSE),
    list("stabilityDice", FALSE, FALSE, 0, 1),
    list("stabilityHamming", FALSE, FALSE, 0, 1),
    list("stabilityIntersectionCount", TRUE, TRUE, NA, 1),
    list("stabilityIntersectionGreedy", TRUE, TRUE, NA, 1),
    list("stabilityIntersectionMBM", TRUE, TRUE, NA, 1),
    list("stabilityIntersectionMean", TRUE, TRUE, NA, 1),
    list("stabilityJaccard", FALSE, FALSE, 0, 1),
    list("stabilityKappa", TRUE, FALSE, -1, 1),
    list("stabilityLustgarten", TRUE, FALSE, -1, 1),
    list("stabilityNogueira", TRUE, FALSE, -1, 1),
    list("stabilityNovovicova", FALSE, FALSE, 0, 1),
    list("stabilityOchiai", FALSE, FALSE, 0, 1),
    list("stabilityPhi", TRUE, FALSE, -1, 1),
    list("stabilitySechidis", FALSE, TRUE, NA, NA),
    list("stabilitySomol", TRUE, FALSE, 0, 1),
    list("stabilityUnadjusted", TRUE, FALSE, -1, 1),
    list("stabilityWald", TRUE, FALSE, "1-p", 1),
    list("stabilityYu", TRUE, TRUE, NA, 1),
    list("stabilityZucknick", FALSE, TRUE, 0, 1)
  )

  do.call(rbind, l)
})
