#' @title Plot Selected Features
#' @description Creates a heatmap of the features which are selected in at least one feature set.
#' The sets are ordered according to average linkage hierarchical clustering based on the Manhattan
#' distance. If \code{sim.mat} is given, the features are ordered according to average linkage
#' hierarchical clustering based on \code{1 - sim.mat}. Otherwise, the features are ordered in
#' the same way as the feature sets.
#' @inheritParams stabilityDocumentation
#' @return Object of class \code{ggplot}.
#' @examples
#' feats = list(1:3, 1:4, 1:5)
#' mat = 0.92 ^ abs(outer(1:10, 1:10, "-"))
#' plotFeatures(features = feats)
#' plotFeatures(features = feats, sim.mat = mat)
#' @export
plotFeatures = function(features, sim.mat = NULL) {

  BBmisc::requirePackages(c("cowplot", "data.table", "ggdendro", "ggplot2"),
    why = "plotFeatures", default.method = "load")

  # Checks
  checkmate::assertList(features, any.missing = FALSE, min.len = 2L,
    types = c("integerish", "character"))
  type.numeric = sapply(features, is.numeric)
  type.character = sapply(features, is.character)
  checkmate::assertTRUE(all(type.numeric) || all(type.character))

  if (!is.null(sim.mat)) {
    pck = attr(class(sim.mat), "package")

    if (is.null(pck) || pck != "Matrix") {
      checkmate::assertMatrix(sim.mat, any.missing = FALSE, min.rows = 1L, min.cols = 1L, null.ok = FALSE)
      checkmate::assertTRUE(base::isSymmetric(unname(sim.mat)))
      checkmate::assertNumeric(sim.mat, lower = 0, upper = 1)
    } else {
      checkmate::assertTRUE(Matrix::isSymmetric(sim.mat))
      checkmate::assertNumeric(sim.mat@x, lower = 0, upper = 1)
    }

    if (any(type.character)) {
      checkmate::assertNames(colnames(sim.mat))
      rownames(sim.mat) = colnames(sim.mat)
      F.all = colnames(sim.mat)
    } else {
      F.all = seq_len(ncol(sim.mat))
    }

    lapply(features, function(f) {
      checkmate::assertVector(f, any.missing = FALSE, unique = TRUE, max.len = length(F.all))
      checkmate::assertSubset(f, F.all)
    })

  } else {
    lapply(features, function(f) {
      checkmate::assertVector(f, any.missing = FALSE, unique = TRUE)
    })
  }

  all.feats = Reduce(union, features)

  if (length(all.feats) == 0) {
    stop("No feature selected in any set!")
  }

  mat = Reduce(rbind, lapply(features, function(f) all.feats %in% f))
  colnames(mat) = NULL
  rownames(mat) = NULL

  d.repls = dist(mat, method = "manhattan")
  hc.repls = hclust(d.repls, method = "average")
  o.repls = hc.repls$order
  dd.repls = as.dendrogram(hc.repls)

  if (length(all.feats) > 1) {
    if (is.null(sim.mat)) {
      d.feats = dist(t(mat), method = "manhattan")
    } else {
      d.feats = as.dist(1 - sim.mat[all.feats, all.feats])
    }
    hc.feats = hclust(d.feats, method = "average")
    o.feats = hc.feats$order
    dd.feats = as.dendrogram(hc.feats)
  } else {
    o.feats = 1L
  }

  mat = mat[o.repls, o.feats, drop = FALSE]
  colnames(mat) = paste0("V", all.feats[o.feats])
  rownames(mat) = paste0("S", o.repls)

  mat.data = reshape2::melt(mat, id.vars = rownames(mat))
  colnames(mat.data) = c("repl", "feature", "selected")
  mat.data$selected = factor(ifelse(mat.data$selected, "Yes", "No"), levels = c("No", "Yes"))

  # nchar
  max.char = max(sapply(all.feats, nchar))
  if (max.char > 2) {
    angle.feats = 90
  } else {
    angle.feats = 0
  }

  heat.plot = ggplot2::ggplot(mat.data, ggplot2::aes_string(x = "feature", y = "repl")) +
    ggplot2::geom_tile(ggplot2::aes_string(fill = "selected"), colour = "white") +
    ggplot2::scale_fill_grey(name = "Selected", start = 0.9, end = 0.2, drop = FALSE) +
    ggplot2::theme_void() +
    ggplot2::labs(y = "Sets", x = "Features", title = "") +
    ggplot2::scale_y_discrete(expand = c(0, 0), labels = o.repls) +
    ggplot2::scale_x_discrete(expand = c(0, 0), labels = all.feats[o.feats]) +
    ggplot2::theme(axis.ticks = ggplot2::element_blank(),
      title = ggplot2::element_text(size = 1),
      legend.position = "right",
      legend.title = ggplot2::element_text(size = 10),
      legend.text = ggplot2::element_text(size = 10),
      axis.title = ggplot2::element_text(size = 10),
      axis.title.y = ggplot2::element_text(angle = 90),
      axis.text = ggplot2::element_text(size = 10),
      axis.text.x = ggplot2::element_text(angle = angle.feats, hjust = 1, vjust = 0.5))

  final.plot = heat.plot

  dendro.data.repls = ggdendro::dendro_data(dd.repls, type = "rectangle")
  dendro.repls = cowplot::axis_canvas(heat.plot, axis = "y", coord_flip = TRUE) +
    ggplot2::geom_segment(data = ggdendro::segment(dendro.data.repls),
      ggplot2::aes_string(y = "y", x = "x", xend = "xend", yend = "yend"), size = 0.5) +
    ggplot2::coord_flip() +
    ggplot2::theme(plot.margin = ggplot2::unit(c(0, 1, 0, 0), "lines"))
  final.plot = cowplot::insert_yaxis_grob(final.plot, dendro.repls,
    grid::unit(0.2, "null"), position = "right")

  if (length(all.feats) > 1) {
    dendro.data.feats = ggdendro::dendro_data(dd.feats, type = "rectangle")
    dendro.feats = cowplot::axis_canvas(heat.plot, axis = "x") +
      ggplot2::geom_segment(data = ggdendro::segment(dendro.data.feats),
        ggplot2::aes_string(x = "x", y = "y", xend = "xend", yend = "yend"), size = 0.5) +
      ggplot2::theme(plot.margin = ggplot2::unit(c(1, 0, 0, 0), "lines"))
    final.plot = cowplot::insert_xaxis_grob(final.plot, dendro.feats,
      grid::unit(0.2, "null"), position = "top")
  }
  cowplot::ggdraw(final.plot)
}

