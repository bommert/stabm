context("stability adjusted")
library(Matrix)

measures = list(
  "stabilityYu",
  "stabilityZucknick",
  "stabilitySechidis",
  "stabilityIntersectionMBM",
  "stabilityIntersectionGreedy",
  "stabilityIntersectionCount",
  "stabilityIntersectionMean"
)

mat = function() {
  sim.mat = matrix(0.4, nrow = 5, ncol = 5)
  diag(sim.mat) = 1
  sim.mat[3, 4] = sim.mat[4, 3] = 0.99
  sim.mat[2, 4] = sim.mat[4, 2] = 0.92
  sim.mat[1, 5] = sim.mat[5, 1] = 0.93

  sim.mat = sim.mat %*% t(sim.mat)
  sim.mat = cov2cor(sim.mat)

  return(sim.mat)
}

sim.mat1 = mat()
sim.mat2 = sim.mat1
colnames(sim.mat2) = paste0("V", 1:5)
sim.mat3 = diag(5)
sim.mat4 = matrix(0, ncol = 5, nrow = 5)
sim.mat4[1:3, ] = sim.mat4[, 3:1] = 1
diag(sim.mat4) = 1
sim.mat5 = Matrix(sim.mat1)
sim.mat6 = Matrix(sim.mat1, sparse = TRUE)
sim.mat7 = as(as(as(sim.mat6, "dMatrix"), "generalMatrix"), "CsparseMatrix")
sim.mat8 = matrix(1, nrow = 1, ncol = 1)

feats1 = list(1:3, 2:5)
feats2 = list(1:5, 1:5, numeric(0L), numeric(0L), 1:2, 2:4)
feats3 = list(numeric(0L), numeric(0L))
feats4 = lapply(feats1, function(f) paste0("V", f))
feats5 = list(1:2, 1:2)
feats6 = list(1, 1)

# repeatedly use checkmate functions the same way
my_expect_number_adj = function(m, features, sim.mat, cfc, ...) {
  if (m == "stabilitySechidis") {
    checkmate::expect_number(stabilitySechidis(features = features,
      sim.mat = sim.mat, threshold = 0.85, ...),
      na.ok = FALSE, null.ok = FALSE, finite = TRUE, info = paste(m, cfc))
  } else {
    checkmate::expect_number(get(m)(features = features, sim.mat = sim.mat,
      threshold = 0.85, correction.for.chance = cfc, N = 100, ...),
      na.ok = FALSE, null.ok = FALSE, finite = TRUE, info = paste(m, cfc))
  }
}

my_expect_na_adj = function(m, features, sim.mat, cfc, ...) {
  if (m == "stabilitySechidis") {
    checkmate::expect_scalar_na(stabilitySechidis(features = features,
      sim.mat = sim.mat, threshold = 0.85, ...),
      null.ok = FALSE, info = paste(m, cfc))
  } else {
    checkmate::expect_scalar_na(get(m)(features = features, sim.mat = sim.mat,
      threshold = 0.85, correction.for.chance = cfc, N = 100, ...),
      null.ok = FALSE, info = paste(m, cfc))
  }
}

test_that("set 1: basic", {
  lapply(measures, function(m) {
    my_expect_number_adj(m, feats1, sim.mat1, "estimate")
  })

  lapply(measures, function(m) {
    my_expect_number_adj(m, feats1, sim.mat1, "exact")
  })

  lapply(measures, function(m) {
    my_expect_number_adj(m, feats1, sim.mat1, "none")
  })
})

test_that("set 1: Matrix", {
  lapply(measures, function(m) {
    my_expect_number_adj(m, feats1, sim.mat5, "estimate")
  })
})

test_that("set 1: Matrix sparse", {
  lapply(measures, function(m) {
    my_expect_number_adj(m, feats1, sim.mat6, "estimate")
  })
})

test_that("set 1: Matrix non-symmetric format", {
  lapply(measures, function(m) {
    my_expect_number_adj(m, feats1, sim.mat7, "estimate")
  })
})


test_that("set 1: no similarities", {
  lapply(measures, function(m) {
    my_expect_number_adj(m, feats1, sim.mat3, "estimate")
  })
})

test_that("set 2: some empty sets: NAs", {
  lapply(setdiff(measures, "stabilitySechidis"), function(m) {
    my_expect_na_adj(m, feats2, sim.mat1, "estimate")
  })
})

test_that("set 2: some empty sets: impute NAs", {
  lapply(measures, function(m) {
    my_expect_number_adj(m, feats2, sim.mat1, "estimate", impute.na = 0)
  })
})


test_that("set 3: only empty sets", {
  lapply(measures, function(m) {
    my_expect_na_adj(m, feats3, sim.mat1, "estimate")
  })
})

test_that("set 4: unnamed", {
  lapply(measures, function(m) {
    expect_error(get(m)(features = feats4, sim.mat = sim.mat1,
      threshold = 0.85, correction.for.chance = "estimate", N = 100),
      info = m)
  })
})

test_that("set 4: named", {
  lapply(measures, function(m) {
    my_expect_number_adj(m, feats4, sim.mat2, "estimate")
  })
})

test_that("set 4: character input exact correction", {
  lapply(measures, function(m) {
    my_expect_number_adj(m, feats4, sim.mat2, "exact")
  })

  lapply(setdiff(measures, "stabilitySechidis"), function(m) {
    expect_equal(
      get(m)(features = feats4, sim.mat = sim.mat2,
        threshold = 0.85, correction.for.chance = "exact"),
      get(m)(features = feats1, sim.mat = sim.mat2,
        threshold = 0.85, correction.for.chance = "exact"),
      info = m)
  })
})


test_that("set 5: constant selection gives value 1", {
  lapply(setdiff(measures, "stabilitySechidis"), function(m) {
    expect_equal(
      get(m)(features = feats5, sim.mat = sim.mat1,
        threshold = 0.85, correction.for.chance = "exact"),
      1, info = m)
  })
})

test_that("set 6: only one feature in dataset", {
  lapply(measures, function(m) {
    my_expect_na_adj(m, feats6, sim.mat8, "exact")
  })

  lapply(measures, function(m) {
    my_expect_na_adj(m, feats6, sim.mat8, "estimate")
  })

  lapply(setdiff(measures, "stabilitySechidis"), function(m) {
    my_expect_number_adj(m, feats6, sim.mat8, "none")
  })
})

test_that("No similarities: equalities", {
  smas = paste0("stabilityIntersection", c("MBM", "Greedy", "Count", "Mean"))
  smu = stabilityUnadjusted(features = feats1, p = ncol(sim.mat3))
  lapply(smas, function(m) {
    expect_equal(
      get(m)(features = feats1, sim.mat = sim.mat3,
        threshold = 0.85, correction.for.chance = "exact"),
      smu, info = m)
  })

  smn = stabilityNogueira(features = feats1, p = ncol(sim.mat3))
  expect_equal(
    stabilitySechidis(features = feats1, sim.mat = sim.mat3,
      threshold = 0.85),
    smn, info = "stabilitySechidis")
})
