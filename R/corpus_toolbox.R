#' Reconstruct utterances from observations of tokens in tidy format
#'
#' @param data A data frame of tokens
#' @param token_col Name of column of tokens
#' @param ... Grouping variables
#'
#' @return A data frame of grouping variables and utterances
#' @export
tokens_flatten <- function(data, token_col, ...) {
  data %>%
    dplyr::group_by(...) %>%
    dplyr::summarize(utterance = paste({{token_col}}, collapse = " "), .groups = 'drop')
}
