stability = function(features, measure, correction.for.chance, N,
  impute.na = NULL, p = ncol(sim.mat), sim.mat = NULL, threshold = NULL, penalty = NULL) {

  # Checks

  adjusted.measures = c("yu", "zucknick", "sechidis", "intersection.mbm",
    "intersection.greedy", "intersection.count", "intersection.mean")
  unadjusted.measures = c("davis", "dice", "hamming", "intersection.common",
    "jaccard", "kappa.coefficient", "lustgarten", "nogueira", "novovicova",
    "ochiai", "phi.coefficient", "somol", "wald")
  need.p = c("davis", "hamming", "intersection.common", "lustgarten",
    "phi.coefficient", "somol", "kappa.coefficient", "nogueira", "wald")

  # measure
  checkmate::assertSubset(measure, empty.ok = FALSE, choices = c(adjusted.measures, unadjusted.measures))
  checkmate::assertScalar(measure)
  is.adj.measure = measure %in% adjusted.measures

  # correction.for.chance
  if (measure == "intersection.common") {
    checkmate::assertSubset(correction.for.chance, empty.ok = FALSE,
      choices = "unadjusted")
  } else {
    checkmate::assertSubset(correction.for.chance, empty.ok = FALSE,
      choices = c("estimate", "exact", "none"))
  }
  checkmate::assertScalar(correction.for.chance)

  # N
  if (correction.for.chance == "estimate") {
    checkmate::assertInt(N, lower = 1L, na.ok = FALSE, null.ok = FALSE)
  }

  # impute.na
  checkmate::assertNumber(impute.na, upper = 1, finite = TRUE, null.ok = TRUE, na.ok = FALSE)

  # features
  checkmate::assertList(features, any.missing = FALSE, min.len = 2L,
    types = c("integerish", "character"))
  type.character = sapply(features, is.character)
  if (any(type.character) && !all(type.character)) {
    stop("All features must numeric or all features must be character")
  }

  if (is.adj.measure) {
    # sim.mat
    pck = attr(class(sim.mat), "package")

    if (is.null(pck) || pck != "Matrix") {
      checkmate::assertMatrix(sim.mat, any.missing = FALSE, min.rows = 1L, min.cols = 1L, null.ok = FALSE)
      checkmate::assertTRUE(isSymmetric(unname(sim.mat)))
      checkmate::assertNumeric(sim.mat, lower = 0, upper = 1)
    } else {
      checkmate::assertTRUE(Matrix::isSymmetric(sim.mat))
      checkmate::assertNumeric(sim.mat@x, lower = 0, upper = 1)

      if (substr(class(sim.mat), 2, 2) != "s") {
        sim.mat = as.matrix(sim.mat)
        pck = NULL
      }
    }

    # bring sim.mat to sparse format with entries lower than threshold set to zero
    if (is.null(pck) || pck != "Matrix") {

      trafoIndex = function(index, nr) {
        i1 = ceiling(index / nr)
        i2 = index - (i1 - 1) * nr
        return(c(i1, i2))
      }

      gt = which(sim.mat >= threshold)
      gt.tmp = lapply(gt, trafoIndex, nr = nrow(sim.mat))
      gt.mat = do.call(rbind, gt.tmp)
      w = which(gt.mat[, 1] >= gt.mat[, 2])

      sparse.mat = sparseMatrix(gt.mat[w, 1], gt.mat[w, 2], x = sim.mat[gt[w]],
        symmetric = TRUE, dims = c(nrow(sim.mat), ncol(sim.mat)))
      colnames(sparse.mat) = rownames(sparse.mat) = colnames(sim.mat)
      sim.mat = sparse.mat
      sim.mat = as(as(as(sim.mat, "dMatrix"), "symmetricMatrix"), "TsparseMatrix")
    } else {
      if (!inherits(sim.mat, "dsTMatrix")) {
        sim.mat = as(as(as(sim.mat, "dMatrix"), "symmetricMatrix"), "TsparseMatrix")
      }
      if (min(sim.mat@x) < threshold) {
        keep = sim.mat@x >= threshold
        x = sim.mat@x[keep]
        i = sim.mat@i[keep] + 1
        j = sim.mat@j[keep] + 1
        sparse.mat = sparseMatrix(i = i, j = j, x = x, symmetric = TRUE)
        colnames(sparse.mat) = rownames(sparse.mat) = colnames(sim.mat)
        sim.mat = sparse.mat
        sim.mat = as(as(as(sim.mat, "dMatrix"), "symmetricMatrix"), "TsparseMatrix")
      }
    }

    if (any(type.character)) {
      checkmate::assertNames(colnames(sim.mat))
      F.all = colnames(sim.mat)
    } else {
      F.all = seq_len(ncol(sim.mat))
    }

    # features
    lapply(features, function(f) {
      checkmate::assertVector(f, any.missing = FALSE, unique = TRUE, max.len = length(F.all))
      checkmate::assertSubset(f, F.all)
    })

    # threshold
    checkmate::assertNumber(threshold, lower = 0, upper = 1, na.ok = FALSE, null.ok = FALSE)

  } else {
    # features
    lapply(features, function(f) {
      checkmate::assertVector(f, any.missing = FALSE, unique = TRUE)
    })

    # penalty
    if (measure == "davis") {
      checkmate::assertNumber(penalty, lower = 0L, na.ok = FALSE, null.ok = FALSE)
    }

    # p
    checkmate::assertInt(p, lower = 1L, na.ok = FALSE, null.ok = TRUE)
    if (correction.for.chance != "none" || measure %in% need.p) {
      checkmate::assertInt(p, null.ok = FALSE)
      checkmate::assertVector(unique(unlist(features)), max.len = p)
    }
  }


  # avoid computation of expectation if no similar features in data set
  adjusted.intersections = c("yu", paste("intersection", c("mbm", "greedy", "mean", "count"), sep = "."))
  if (measure %in% adjusted.intersections) {
    if (nrow(sim.mat) > 1) {
      any.sim.feats = FALSE
      i = 1
      while (!any.sim.feats && i <= nrow(sim.mat)) {
        any.sim.feats = any(sim.mat[i, -i] >= threshold)
        i = i + 1
      }

      if (!any.sim.feats) {
        measure = "intersection.common"

        if (correction.for.chance != "none") {
          correction.for.chance = "unadjusted"
        }
      }
    }
  }

  # Stability Assessment
  measure.list = get(measure)

  if (is.adj.measure) {
    measure.args = list(features = features, F.all = F.all,
      sim.mat = sim.mat, threshold = threshold)
  } else {
    measure.args = list(features = features, p = p, penalty = penalty)
  }

  scores = do.call(measure.list$scoreFun, measure.args)

  if (correction.for.chance != "none") {
    if (correction.for.chance == "estimate") {
      expectationFun = simulate.expectation
    } else if (correction.for.chance == "exact") {
      expectationFun = calculate.expectation
    } else {
      expectationFun = unadjusted.expectation
    }

    expectation.args = c(measure.args, list(N = N, fun = measure.list$scoreFun))
    if (!is.adj.measure) {
      expectation.args = c(expectation.args, list(F.all = 1:p))
    }

    expecteds = do.call(expectationFun, expectation.args)

    maxima = do.call(measure.list$maxValueFun, measure.args)

    scores = (scores - expecteds) / (maxima - expecteds)

    # replace NaN by NA
    nan.scores = is.nan(scores)
    if (length(nan.scores) > 0) {
      scores[nan.scores] = NA_real_
    }
  }

  if (!is.null(impute.na)) {
    na.scores = is.na(scores)
    if (any(na.scores)) {
      scores[na.scores] = impute.na
    }
  }

  score = mean(scores)
  return(score)
}
