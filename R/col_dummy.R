#' Apply explicit dummy coding to a data frame
#'
#' @import data.table
#'
#' @param data A data frame
#' @param factor A name of a factor column. Can be quoted or unquoted
#' @param reference A string of the level that should be coded as the reference level. Defaults to the first level of the factor if one is not provided.
#'
#' @return A `data.frame`. A tibble passed into `data` is returned as a tibble.
#' @export
#'
#' @examples
#' col_dummy(iris, "Species", reference = "virginica")
#' col_dummy(iris, Species, reference = "virginica")
col_dummy <- function(data, factor, reference = NULL) {
  factor_vec <- dplyr::pull(data, {{factor}})

  if (!is.factor(factor_vec)) {factor_vec <- as.factor(factor_vec)}
  if (is.null(reference)) {reference <- levels(factor_vec)[1]}

  vals <- levels(factor_vec)[!levels(factor_vec) %in% reference]

  factor_enquo <- rlang::enquo(factor)
  factor_text <- gsub('\"', '', rlang::quo_text(factor_enquo))
  new_cols <- paste0(factor_text, vals)

  df <- as.data.table(data)
  df[, (new_cols) := lapply(vals, function(x) ifelse(factor_vec == x, 1, 0))]
  df <- dplyr::select(df, -{{factor}})

  if (tibble::is_tibble(data)) {df <- tibble::as_tibble(df)}
  else {df <- as.data.frame(df)}

  message(paste0("The reference level of '", factor_text, "' is '", reference, "'"))

  df
}
