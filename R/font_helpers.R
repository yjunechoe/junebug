#' Register style variants of a font as their own families
#'
#' @param family The font family
#' @param silent Whether to print newly registered font families in a message
#'
#' @export
#'
#' @examples
#' \dontrun{
#' font_hoist(family = "Font Awesome 5 Free")
#' }
#'
#' @importFrom rlang .data .env
font_hoist <- function(family, silent = FALSE) {
  font_specs <- systemfonts::system_fonts() %>%
    dplyr::filter(family == .env[["family"]]) %>%
    dplyr::mutate(family = paste(.data[["family"]], .data[["style"]])) %>%
    dplyr::select(plain = .data[["path"]], name = .data[["family"]])

  purrr::pwalk(as.list(font_specs), systemfonts::register_font)

  if (!silent)  message(paste0("Hoisted ", nrow(font_specs), " variants:\n", paste(font_specs$name, collapse = "\n")))
}
