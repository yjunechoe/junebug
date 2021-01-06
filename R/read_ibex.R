#' Reads in the `results` file from an IBEX experiment as data frame
#'
#' @param results_file The exact text of the `results` file as downloaded from IBEX
#' @param external Is the results file a path to a downloaded file? Set to `FALSE` if the results are formatted as lines of characters.
#'
#' @return A data frame if the controller writes a single line to the results file (e.g., "DashedSentence") OR a list of data frames if the controller writes more than one line to the results file (e.g., "AcceptabilityJudgment"). Check the \href{https://github.com/addrummond/ibex/blob/master/docs/manual.md}{IBEX documentation} for more details.
#' @export
read_ibex <- function(results_file, external = TRUE) {

  if (external) {
    raw_lines <- readLines(results_file, warn = FALSE)
  } else {
    raw_lines <- results_file
  }

  data_lines <- raw_lines[!grepl("^(#| )", raw_lines)]
  comments <- raw_lines[grepl("^(#| )", raw_lines)]
  col_specs <- comments[grepl("(Col\\. \\d+:|^# \\d+\\. )", comments)]

  col_groups <- list()
  for (i in 1L:length(col_specs)) {
    if (i == 1L) {
      col_groups[[1L]] <- col_specs[i]
    }
    else if (i == length(col_specs) | (i < length(col_specs) && !grepl("(Col\\. 1:|^# 1\\. )", col_specs[i]))) {
      col_groups[[length(col_groups)]] <- c(col_groups[[length(col_groups)]], col_specs[i])
    } else {
      col_groups[[length(col_groups) + 1L]] <- col_specs[i]
    }
  }

  col_groups <- lapply(unique(col_groups), function(x) gsub("(^# +Col\\. \\d+: |^# \\d+\\. |\\.$)", "", x))
  data_groups <- lapply(1L:length(col_groups), function(x) {
    data_lines[rep(1L:length(col_groups), length.out = length(data_lines)) == x]
  })

  results <- lapply(1L:length(data_groups), function(x) {
    data_group <- data.frame(matrix(unlist(strsplit(data_groups[[x]], ",")), nrow = length(data_groups[[x]]), byrow = TRUE))
    colnames(data_group) <- col_groups[[x]]
    data_group
  })

  if (length(results) == 1L) {
    results[[1L]]
  } else{
    results
  }

}
