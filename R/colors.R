#' Complete list of palettes
#'
#' @export
junebug_palettes <- list(
  CranberryWhiteGrub = c("#56212A", "#844F4B", "#D785B5FF", "#5E3866"),
  CubanMay = c("#D9C091", "#8C7251", "#8C3211", "#591202", "#291F16"),
  Mican = c("#DABBAD", "#A18075", "#714F45", "#52322C", "#401201")
)

#' Selects colors from a palette
#'
#' @param palette Name of palette in junebug_palettes
#' @param n Number of colors to return
#'
#' @return A character vector of colors
#' @export
junebug_palette <- function(palette, n = 3) {
  pal <- junebug_palettes[[palette]]
  pal[round(seq(1, length(pal), length.out =  min(n, length(pal))))]
}
