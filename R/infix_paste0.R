#' Adds two strings together in infix form
#'
#' @param lhs a string
#' @param rhs a string
#'
#' @return A string of length 1
#' @export
#'
#' @examples
#' "Hello" %+% ", " %+% "world!"
`%+%` <- function(lhs, rhs) {paste0(lhs, rhs)}
