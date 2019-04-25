yu = list(
  scoreFun = function(features, F.all, sim.mat, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        n1 = length(F1)
        n2 = length(F2)
        l = (n1 + n2) / 2
        if (l == 0) {
          return(NA_real_)
        }

        indices.1not2 = which(F.all %in% setdiff(F1, F2))
        indices.2not1 = which(F.all %in% setdiff(F2, F1))

        o12 = 0
        o21 = 0

        if (length(indices.1not2) > 0 && length(indices.2not1) > 0) {
          sim.part = sim.mat[indices.1not2, indices.2not1, drop = FALSE]
          if (length(sim.part@i) > 0) {
            o12 = length(unique(sim.part@i))
            o21 = length(unique(sim.part@j))
          }
        }

        o = (o12 + o21) / 2
        k = length(intersect(F1, F2))

        score = (k + o) / l
        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    1
  }
)


zucknick = list(
  scoreFun = function(features, F.all, sim.mat, threshold, sim.feats, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        indices.1 = which(F.all %in% F1)
        indices.2 = which(F.all %in% F2)

        indices.1not2 = which(F.all %in% setdiff(F1, F2))
        indices.2not1 = which(F.all %in% setdiff(F2, F1))

        add.sim1 = 0
        if (length(indices.2not1) > 0) {
          sim.part = sim.mat[indices.2not1, indices.1, drop = FALSE]
          add.sim1 = sum(sim.part) / length(indices.2)
        }

        add.sim2 = 0
        if (length(indices.1not2) > 0) {
          sim.part = sim.mat[indices.1not2, indices.2, drop = FALSE]
          add.sim2 = sum(sim.part) / length(indices.1)
        }

        res = length(intersect(F1, F2)) + add.sim1 + add.sim2
        res = res / length(union(F1, F2))
        return(res)
      })
  },
  maxValueFun = function(features, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        1
      }
    )
  }
)