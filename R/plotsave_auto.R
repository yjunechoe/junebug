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
#' @param plot_after If `true`, reads in the saved plot to an external graphic device window.
#' @param ... Passed to `ggsave()`
#'
#' @return Returns the value of the current/new graphic device. You can suppress this with `invisible()`
#' @export
ggsave_auto <- function(folder = "ggsaveauto_img", n_pad = 3, padding = stringr::str_pad(1, n_pad, pad = "0"), img_prefix = "img_", img_ext = ".png", width = 20, height = 12, unit = 'cm', plot_after = TRUE, ...) {
  if (!folder %in% dir()) { dir.create(folder) }
  if (length(dir(folder)) > 0) {
    img_counts <- sum(stringr::str_detect(dir(folder), paste0("^", img_prefix, "\\d{", n_pad, "}", img_ext)))
    padding <- stringr::str_pad(img_counts + 1, n_pad, pad = "0")
  }
  ggplot2::ggsave(
    filename = paste0(img_prefix, padding, img_ext),
    path = folder,
    width = width,
    height = height,
    unit = 'cm',
    ...
  )
  message(paste0('Image saved as ', paste0(folder, '/', img_prefix, padding, img_ext)))
  if (plot_after) {
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
  }
}
