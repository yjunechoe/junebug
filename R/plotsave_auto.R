#' Accumulate multiple versions of a plot in interactive mode
#'
#' Wrapper around `ggplot2::ggsave()`
#'
#' @param folder Passed to `path` variable in `ggsave()`
#' @param n_pad Number of `"0"` paddings
#' @param padding Unique identifier for current plot
#' @param img_prefix Prefix of the image file name
#' @param img_ext Extension of the iamge file name
#' @param width Passed to `ggsave()`
#' @param height Passed to `ggsave()`
#' @param unit Passed to `ggsave()`
#' @param plot_load Options for loading the saved plot for viewing. One of `c("app", "rstudio", "none")`.
#' @param ... Passed to `ggsave()`
#'
#' @return Returns the value of the current/new graphic device. You can suppress this with `invisible()`
#' @export
ggsave_auto <- function(folder = "ggsaveauto_img", n_pad = 3, padding = stringr::str_pad(1, n_pad, pad = "0"), img_prefix = "img_", img_ext = ".png", width = 20, height = 12, unit = 'cm', plot_load = 'app', ...) {
  if (!folder %in% dir()) { dir.create(folder) }
  if (length(dir(folder)) > 0) {
    imgs <- list.files(folder, paste0("^", img_prefix, "\\d{", n_pad, "}", img_ext))
    counts <- as.numeric(stringr::str_extract(imgs, paste0("\\d{", n_pad, "}")))
    padding <- stringr::str_pad(max(counts) + 1, n_pad, pad = "0")
  }

  ggplot2::ggsave(
    filename = paste0(img_prefix, padding, img_ext),
    path = folder,
    width = width,
    height = height,
    unit = unit,
    ...
  )

  message(paste0('Image saved as ', paste0(folder, '/', img_prefix, padding, img_ext)))
  if (plot_load == 'app') {
    magick::image_browse(magick::image_read(paste0(folder, '/', img_prefix, padding, img_ext)))
  } else if (plot_load == 'rstudio') {
    if (names(grDevices::dev.cur()) %in% c("null device", "RStudioGD")) {
      if (length(grDevices::dev.list()) == 1 && names(grDevices::dev.list()) == "RStudioGD") {
        grDevices::dev.new(noRStudioGD = TRUE)
      } else {
        if (all(names(grDevices::dev.list()) %in% c("agg_png", "RStudioGD"))) {
          grDevices::dev.new(noRStudioGD = TRUE)
        } else {
          grDevices::dev.set(grDevices::dev.list()[!names(grDevices::dev.list()) %in% c("agg_png", "RStudioGD")][[1]])
        }
      }
    }
    plot(magick::image_read(paste0(folder, '/', img_prefix, padding, img_ext)))
    grDevices::dev.set(2)
  } else if (plot_load != 'none') {
    warning('The plot_load argument must be one of c("app", "rstudio", "none")')
  }
}


#' Accumulate multiple versions of a plot in interactive mode
#'
#' Wrapper around `ragg::ragg_png()`
#'
#' @param folder Directory for the plots to be accumulated in
#' @param p Plot to be saved. Defaults to last plot printed
#' @param n_pad Number of `"0"` paddings
#' @param padding Unique identifier for current plot
#' @param img_prefix Prefix of the image file name
#' @param img_ext Extension of the iamge file name
#' @param width Passed to `ragg_png()`
#' @param height Passed to `ragg_png()`
#' @param unit Passed to `ragg_png()`
#' @param res Passed to `ragg_png()`
#' @param plot_load Options for loading the saved plot for viewing. One of `c("app", "rstudio", "none")`.
#' @param ... Passed to `ragg_png()`
#'
#' @return Returns the value of the current/new graphic device. You can suppress this with `invisible()`
#' @export
raggsave_auto <- function(folder = "raggsaveauto_img", p = ggplot2::last_plot(), n_pad = 3, padding = stringr::str_pad(1, n_pad, pad = "0"), img_prefix = "img_", img_ext = ".png", width = 20, height = 12, unit = 'cm', res = 300, plot_load = 'app', ...) {
  if (!folder %in% dir()) { dir.create(folder) }
  if (length(dir(folder)) > 0) {
    imgs <- list.files(folder, paste0("^", img_prefix, "\\d{", n_pad, "}", img_ext))
    counts <- as.numeric(stringr::str_extract(imgs, paste0("\\d{", n_pad, "}")))
    padding <- stringr::str_pad(max(counts) + 1, n_pad, pad = "0")
  }

  ragg::agg_png(
    filename = paste0(folder, "/", img_prefix, padding, img_ext),
    width = width,
    height = height,
    units = unit,
    res = res,
    ...
  )
  plot(p)
  invisible(grDevices::dev.off())

  message(paste0('Image saved as ', paste0(folder, '/', img_prefix, padding, img_ext)))
  if (plot_load == 'app') {
    magick::image_browse(magick::image_read(paste0(folder, '/', img_prefix, padding, img_ext)))
  } else if (plot_load == 'rstudio') {
    if (names(grDevices::dev.cur()) %in% c("null device", "RStudioGD")) {
      if (length(grDevices::dev.list()) == 1 && names(grDevices::dev.list()) == "RStudioGD") {
        grDevices::dev.new(noRStudioGD = TRUE)
      } else {
        if (all(names(grDevices::dev.list()) %in% c("agg_png", "RStudioGD"))) {
          grDevices::dev.new(noRStudioGD = TRUE)
        } else {
          grDevices::dev.set(grDevices::dev.list()[!names(grDevices::dev.list()) %in% c("agg_png", "RStudioGD")][[1]])
        }
      }
    }
    plot(magick::image_read(paste0(folder, '/', img_prefix, padding, img_ext)))
    grDevices::dev.set(2)
  } else if (plot_load != 'none') {
    warning('The plot_load argument must be one of c("app", "rstudio", "none")')
  }
}

#' Save and open plot
#'
#' Wrapper around `ggplot2::ggsave()` that opens rendered output using the system's default app for the graphic type.
#'
#' @param ... Passed into `ggplot2::ggsave()`
#'
#' @export
ggsave2 <- function(...) {
  system2("open", base::withVisible(ggplot2::ggsave(...))$value)
}
