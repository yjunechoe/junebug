#' Generate a CodeCogs URL that renders latex as image
#'
#' Interactive version at https://www.codecogs.com/latex/eqneditor.php
#'
#' @param formula An appropriately escaped string of LaTex formula. Using the new string literal syntax `r"(...)"` from R 4.0.0 on the existing formula is recommended.
#' @param size Font size. One of "tiny", "small", "normal", "large", or "huge"
#' @param dpi Image resolution. Defaults to 300
#' @param transparent Should the background be transparent? Defaults to `FALSE`, which adds a white background.
#' @param inline Render as inline formula? If TRUE, results in a more compact image.
#'
#' @return A character string of the URL
#'
#' @export
#'
#' @examples
#' \dontrun{
#' latex_query(r"(\beta + \alpha)")
#' latex_query("\\beta + \\alpha")
#' magick::image_read(latex_query(r"(\beta + \alpha)"))
#' }
latex_query <- function(formula, size = "normal", dpi = 300, transparent = FALSE, inline = FALSE) {
  paste0(
    "https://latex.codecogs.com/png.latex?",
    if (!transparent) "%5Cbg_white%20",
    if (inline) "%5Cinline%20",
    "%5Cdpi%7B", dpi, "%7D%20",
    if (size %in% c("tiny", "small", "large", "huge")) paste0("%5C", size, "%20"),
    utils::URLencode(formula, reserved = TRUE)
  )
}
