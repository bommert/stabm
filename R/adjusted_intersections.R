maxIntersectionFun = function(F1, F2) {
  sqrt(length(F1) * length(F2))
}

intersection.greedy = list(
  scoreFun = function(features, F.all, sim.mat, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        indices.1not2 = which(F.all %in% setdiff(F1, F2))
        indices.2not1 = which(F.all %in% setdiff(F2, F1))
        add = 0

        if (length(indices.1not2) > 0 && length(indices.2not1) > 0) {
          sim.part = sim.mat[indices.1not2, indices.2not1, drop = FALSE]

          if (length(sim.part@x) > 0) {
            o = order(sim.part@x, decreasing = TRUE)
            i = sim.part@i[o]
            j = sim.part@j[o]

            exclude.i = integer(0)
            exclude.j = integer(0)
            for (index in seq_along(i)) {
              if (!(i[index] %in% exclude.i) && !(j[index] %in% exclude.j)) {
                add = add + 1
                exclude.i = c(exclude.i, i[index])
                exclude.j = c(exclude.j, j[index])
              }
            }
          }
        }

        score = length(intersect(F1, F2)) + add
        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) maxIntersectionFun(F1, F2)
    )
  }
)


intersection.mbm = list(
  scoreFun = function(features, F.all, sim.mat, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        indices.1not2 = which(F.all %in% setdiff(F1, F2))
        indices.2not1 = which(F.all %in% setdiff(F2, F1))

        mbm = 0

        if (length(indices.1not2) > 0 && length(indices.2not1) > 0) {
          sim.part = sim.mat[indices.1not2, indices.2not1, drop = FALSE]
          n.eds = length(sim.part@i)

          if (n.eds > 0) {
            eds = numeric(2 * n.eds)
            even = seq_len(n.eds) * 2
            odd = even - 1

            ##### because of igraph bug #######
            sim.part.i = sort(unique(sim.part@i)) + 1
            sim.part.j = sort(unique(sim.part@j)) + 1
            sim.part = sim.part[sim.part.i, sim.part.j, drop = FALSE]
            ni = length(sim.part.i)
            nj = length(sim.part.j)
            ids.i = seq_len(ni)
            ids.j = ni + seq_len(nj)
            ####################################


            eds[odd] = ids.i[sim.part@i + 1]
            eds[even] = ids.j[sim.part@j + 1]
            # eds[odd] = as.character(indices.1not2[sim.part@i + 1])
            # eds[even] = as.character(indices.2not1[sim.part@j + 1])

            types = c(rep(0, ni), rep(1, nj))
            g = igraph::make_bipartite_graph(edges = eds, types = types, directed = FALSE)
            mbm = igraph::maximum.bipartite.matching(g)$matching_size
          }
        }

        # add mbm because for every edge in the matching a pair in f1, f2
        # goes from 0-1 1-0 to 1-1 0-0
        score = length(intersect(F1, F2)) + mbm
        return(score)
      })
  },
  maxValueFun = function(features, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) maxIntersectionFun(F1, F2)
    )
  }
)



intersection.count = list(
  scoreFun = function(features, F.all, sim.mat, threshold, sim.feats, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        indices.1not2 = which(F.all %in% setdiff(F1, F2))
        indices.2not1 = which(F.all %in% setdiff(F2, F1))
        add.sim = 0

        if (length(indices.1not2) > 0 && length(indices.2not1) > 0) {
          sim.part = sim.mat[indices.1not2, indices.2not1, drop = FALSE]
          o12 = length(unique(sim.part@i))
          o21 = length(unique(sim.part@j))
          add.sim = min(o12, o21)
        }

        res = length(intersect(F1, F2)) + add.sim
        return(res)
      })
  },
  maxValueFun = function(features, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) maxIntersectionFun(F1, F2)
    )
  }
)

intersection.mean = list(
  scoreFun = function(features, F.all, sim.mat, threshold, sim.feats, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        indices.1not2 = which(F.all %in% setdiff(F1, F2))
        indices.2not1 = which(F.all %in% setdiff(F2, F1))
        add.sim = 0

        if (length(indices.1not2) > 0 && length(indices.2not1) > 0) {
          sim.part = sim.mat[indices.1not2, indices.2not1, drop = FALSE]
          mean.sim1 = rowMeansWithoutZeros(sim.part)
          mean.sim2 = colMeansWithoutZeros(sim.part)
          add.sim = min(sum(mean.sim1), sum(mean.sim2))
        }

        res = length(intersect(F1, F2)) + add.sim
        return(res)
      })
  },
  maxValueFun = function(features, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) maxIntersectionFun(F1, F2)
    )
  }
)


intersection.common = list(
  scoreFun = function(features, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) {
        length(intersect(F1, F2))
      })
  },
  maxValueFun = function(features, ...) {
    measureScoreHelper(features = features,
      measureFun = function(F1, F2) maxIntersectionFun(F1, F2)
    )
  }
)
