#' Prints structure of an object recursively
#'
#' From stackoverflow answer - https://stackoverflow.com/questions/62970933/how-to-output-tree-like-human-readable-object-structure-in-r
#'
#' For printing the structure of dataframes with list columns, it's useful to pass in just the first row if you know the elements of the list column are of the same type
#'
#' @param obj A list or dataframe
#'
#' @return Prints to terminal
#' @export
#'
#' @examples
str2 <- function(obj)
{
  branch      <- "\u251c\u2500\u2500\u2500\u2500"
  last_branch <- "\u2514\u2500\u2500\u2500\u2500"
  trunk       <- "\u2502     "
  blank       <- "      "

  name_list <- function(obj)
  {
    if(is.list(obj))
    {
      o_n <- names(obj)
      if(is.null(o_n)) o_n <- character(length(obj))
      names(obj) <- sapply(seq_along(obj),
                           function(i) {
                             if(!nzchar(o_n[i]))
                               paste0("unnamed '", class(obj[[i]])[1], "'")
                             else paste0(o_n[i], " '", class(obj[[i]])[1], "'")
                           })
      obj <- lapply(obj, name_list)
    }
    obj
  }

  depth <- function(obj, lev = 0){
    if(!is.list(obj)) lev else list(lev, lapply(obj, depth, lev = lev + 1))
  }

  name_strip <- function(obj) {
    o_n <- names(obj)
    lapply(seq_along(o_n), function(i) c(o_n[i], name_strip(obj[[i]])))
  }

  obj        <- name_list(obj)
  depths     <- unlist(depth(obj))[-1]
  diffdepths <- c(diff(depths), -1)
  name_els   <- unlist(name_strip(obj))

  col1 <- rep(trunk, length(depths))
  col1[depths == 1] <- branch
  col1[max(which(depths == 1))] <- last_branch
  if(max(which(depths == 1)) != length(col1))
    col1[(max(which(depths == 1)) + 1):length(name_els)] <- blank
  for(i in 1:max(depths))
  {
    next_col                          <- character(length(name_els))
    next_col[which(depths == i)]      <- name_els[which(depths == i)]
    next_col[which(depths > (i + 1))] <- trunk
    next_col[which(depths == i + 1)]  <- branch
    next_col[which(depths == i + 1 &
                     diffdepths < 0)]   <- last_branch

    for(j in which(next_col == name_els))
    {
      k <- j - 1
      while(k > 0)
      {
        if(next_col[k] != trunk) {
          if(next_col[k] == branch) next_col[k] <- last_branch
          break}
        next_col[k] <- blank
        k <- k - 1
      }
    }
    col1 <- cbind(col1, next_col)
  }
  col1 <- apply(col1, 1, paste, collapse = " ")
  cat(as.character(as.list(match.call())[-1]), trunk, col1, sep = "\n")
}
