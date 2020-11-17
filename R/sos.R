#' Search Stack Overflow (SOS)
#'
#' Grabs last error message and searches it on stackoverflow.com
#'
#' @return
#' @export
#'
#' @examples
#' sos()
sos <- function() {
  last_error <- geterrmessage()
  if (is.null(last_error)) {
    stop("No error message available")
  }

  query <- utils::URLencode(paste("[r]", last_error))
  utils::browseURL(paste0("http://stackoverflow.com/search?q=", query))
}
