#' Split and track trajectory of individual levels of a group
#'
#' To be used with transition_reveal()
#'
#' @param df data frame
#' @param grouping_var column of the grouping variable used to split the data
#' @param tracked_along column of the tracking dimension to be passed into
#' @param ... specification for the tracking window passed to dplyr::filter()
#' @param tracked_groups levels of the grouping_var to be tracked. Defaults to all
#'
#' @return a data frame
#' @export
#'
#' @examples
#' \dontrun{
#' set.seed(123)
#'
#' plot_df <- tibble(
#'   a = cumsum(runif(100, -1, 1)),
#'   b = cumsum(runif(100, -1.5, 1.5)),
#'   c = cumsum(runif(100, -2, 2)),
#'   d = cumsum(runif(100, -2.5, 2.5))
#' ) %>% pivot_longer(a:d) %>%
#'   group_by(name) %>%
#'   mutate(reveal_time = row_number(), x = row_number()) %>%
#'   ungroup()
#'
#' anim <- plot_df %>%
#'   split_track(grouping_var = name, tracked_along = reveal_time, x > 74) %>%
#'   ggplot(aes(x, value, color = name)) +
#'   geom_line(size = 1) +
#'   transition_reveal(reveal_time) +
#'   theme_classic()
#'
#' animate(anim, width = 5, height = 3, units = "in", res = 150)
#' }
split_track <- function(df, grouping_var, tracked_along, ..., tracked_groups = ".all") {

  region <- df %>%
    dplyr::filter(...) %>%
    dplyr::group_by({{ grouping_var }}) %>%
    dplyr::mutate("row_id" = 1:dplyr::n()) %>%
    dplyr::ungroup() %>%
    dplyr::select("row_id", {{ grouping_var }}, {{ tracked_along }})
  region_wide <- region %>%
    tidyr::pivot_wider(names_from = {{ grouping_var }}, values_from = {{ tracked_along }}) %>%
    dplyr::select(-"row_id")

  if (tracked_groups == ".all") {
    tracked_groups <- names(region_wide)
    untracked <- NULL
  } else {
    untracked <- region_wide %>%
      dplyr::select(-{{ tracked_groups }})
  }

  grouping_var_enquo <- rlang::enquo(grouping_var)
  tracked_along_enquo <- rlang::enquo(tracked_along)

  region_split <- dplyr::bind_rows(
    untracked,
    purrr::map_dfr(tracked_groups, ~dplyr::select(region_wide, .x))
  ) %>%
    tidyr::fill(dplyr::everything(), .direction = "down") %>%
    dplyr::mutate(dplyr::across(
      dplyr::everything(),
      ~ifelse(is.na(.x), min(dplyr::pull(region, {{ tracked_along }}), na.rm = TRUE) - 1, .x))
    ) %>%
    tidyr::pivot_longer(
      dplyr::everything(),
      names_to = rlang::quo_text(grouping_var_enquo),
      values_to = rlang::quo_text(tracked_along_enquo)
    )

  suppressMessages({
    df %>%
      dplyr::anti_join(dplyr::filter(df, ...)) %>%
      dplyr::bind_rows(
        region_split %>%
          dplyr::inner_join(df)
      ) %>%
      dplyr::group_by({{ grouping_var }}) %>%
      dplyr::mutate(!!tracked_along_enquo := dplyr::row_number()) %>%
      dplyr::ungroup()
  })
}
