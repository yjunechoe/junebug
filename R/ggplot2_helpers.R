#' Annotate a single unit text with a unit label
#'
#' For use in the `labels` argument of `ggplot2::scale_*_continuous`
#'
#' @param x Vector of labels
#' @param unit_label A string attached at the end of the label
#' @param position Which label the annotation should go to. Either 'first' (bottom/left) or 'last' (top/right).
#'
#' @export
#'
#' @examples
#' \dontrun{
#' my_plot <- ggplot(mtcars, aes(mpg, hp)) + geom_point()
#' my_plot + scale_y_continuous(labels = label_unit)
#' my_plot + scale_y_continuous(labels = function(x) label_unit(x, "%"))
#' my_plot + scale_y_continuous(labels = function(x) label_unit(x, "%", "first"))
#' my_plot + scale_y_continuous(labels = function(x) label_unit(x, "sec"))
#' }
label_unit <- function(x, unit_label = "ms", position = "last") {
  labs <- which(!is.na(x))
  if (position == "last") {
    last_idx <- labs[length(labs)]
    replace(x, last_idx, paste0(x[last_idx], unit_label))
  } else if (position == "first") {
    first_lab <- labs[1]
    replace(x, first_lab, paste0(x[first_lab], unit_label))
  } else {
    stop("Value for argument `position` must 'first' or 'last'")
  }
}
