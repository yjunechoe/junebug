####
##
## Script by June Choe
## Last updated 01/2021
##
####

#' Parse IBEX results file in Tidy format
#'
#' @param results_file Path to the downloaded results file.
#' @param clipboard Read results from clipboard? If `TRUE`, do not need to supply argument for `results_file`.
#'
#' @return A single data frame containing all variables present as columns
#' @export
read_ibex <- function(results_file, clipboard = FALSE) {

  raw_lines <- if (clipboard) {
    readClipboard()
  } else {
    readLines(results_file, warn = FALSE)
  }

  data_compact <- raw_lines[!grepl("^#$", raw_lines)]
  data_breaks <- which(grepl("^# Results on", data_compact))
  data_chunks <- lapply(1L:length(data_breaks), function(x) {
    subject_lines <- if (x == length(data_breaks)) {
      data_breaks[x]:length(data_compact)
    } else {
      data_breaks[x]:(data_breaks[x+1L] - 1L)
    }
    data_compact[subject_lines]
  })


  read_ibex_ <- function(raw_lines) {

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

    col_nested <- unlist(lapply(col_groups, function(x) { all(unlist(lapply(x, function(y) { grepl("Col\\.", y) }))) }))
    col_groups <- lapply(col_groups, function(x) { gsub("(^# +Col\\. \\d+: |^# \\d+\\. |\\.$)", "", x) })

    col_nested_rle <- rle(col_nested)
    col_group_bins <- unlist(lapply(1L:length(col_nested_rle$values), function(x) {
      if (!col_nested_rle$values[x]) {
        x:(x+col_nested_rle$lengths[x] - 1L)
      } else {
        rep(paste(x, "grouped"), col_nested_rle$lengths[x])
      }
    }))
    col_groups_list <- split(col_groups, col_group_bins)

    data_rle <- rle(!grepl("^#", raw_lines))
    data_indices <- cumsum(data_rle$lengths[data_rle$values])
    data_groups <- lapply(1L:length(data_indices), function(x) {
      if (x == 1L) {
        idx <- 1L:data_indices[x]
      } else {
        idx <- max(data_indices[x-1L] + 1L):data_indices[x]
      }
      data_lines[idx]
    })

    cols_all <- unique(unlist(col_groups))

    data_chunked <- lapply(1L:length(data_groups), function(x) {
      group_data <- data_groups[[x]]
      group_cols <- col_groups_list[[x]]
      if (length(group_cols) == 1L) {
        group_df <- do.call(rbind, strsplit(group_data, ","))
        colnames(group_df) <- unlist(group_cols)
        group_df <- as.data.frame(group_df)
        group_df[,setdiff(cols_all, colnames(group_df))] <- NA
        group_df
      } else {
        group_data_indices <- rep(1L:length(group_cols), length.out = length(group_data))
        group_data_list <- lapply(1L:length(group_cols), function(x) {
          group_df <- do.call(rbind, strsplit(group_data[group_data_indices == x], ","))
          colnames(group_df) <- unlist(group_cols[[x]])
          group_df <- as.data.frame(group_df)
          group_df[,setdiff(cols_all, colnames(group_df))] <- NA
          group_df
        })
        group_data_df <- do.call(rbind, group_data_list)
        group_data_df[as.vector(t(matrix(1L:nrow(group_data_df), ncol = length(group_cols)))),]
      }
    })

    do.call(rbind, data_chunked)

  }


  results_parsed <- lapply(data_chunks, read_ibex_)

  cols_results <- unique(unlist(lapply(results_parsed, colnames)))

  results <- lapply(results_parsed, function(x) {
    x[,setdiff(cols_results, colnames(x))] <- NA
    x
  })

  results <- do.call(rbind, results)

  rownames(results) <- NULL

  return(results)

}
