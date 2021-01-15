#' Annotate a single break on an axis with a label
#'
#' For use in the `labels` argument of `ggplot2::scale_*_continuous`
#'
#' @param x Vector of axis breaks
#' @param suffix A string attached to the end of the text. Defaults to "ms".
#' @param prefix A string attached to the beginning of the text. Defaults to "".
#' @param position Which label the annotation should go to. Either 'first' (bottom/left) or 'last' (top/right).
#'
#' @export
#'
#' @examples
#' \dontrun{
#' my_plot <- ggplot(mtcars, aes(mpg, hp)) + geom_point()
#' my_plot + scale_y_continuous(labels = one_label)
#' my_plot + scale_y_continuous(labels = function(x) one_label(x, "%"))
#' my_plot + scale_y_continuous(labels = function(x) one_label(x, "%", position = "first"))
#' my_plot + scale_y_continuous(labels = function(x) one_label(x, prefix = "$"))
#' }
one_label <- function(x, suffix = "ms", prefix = "",  position = "last") {
  labs <- which(!is.na(x))
  if (position == "last") {
    last_idx <- labs[length(labs)]
    replace(x, last_idx, paste0(prefix, x[last_idx], suffix))
  } else if (position == "first") {
    first_lab <- labs[1]
    replace(x, first_lab, paste0(prefix, x[first_lab], suffix))
  } else {
    stop("Value for argument `position` must 'first' or 'last'")
  }
}
