#' ggplot2 theme inspired by `theme_classic()`
#'
#' Features: Clear white background, no grid lines
#'
#' @param base_size Defaults to 12 (like all complete themes in ggplot2)
#' @param ... Passed to `ggplot2::theme()`
#'
#' @export
theme_junebug_clean <- function(base_size = 12, ...) {

  ggplot2::theme(
    axis.line = ggplot2::element_line(
      color = "#202020"
    ),
    axis.text = ggplot2::element_text(
      face = "bold",
      color = "#303030",
      size = base_size
    ),
    axis.text.x = ggplot2::element_text(
      lineheight = 1.2,
      margin = ggplot2::margin(t = 0.2, unit = "cm")
    ),
    axis.text.y = ggplot2::element_text(
      margin = ggplot2::margin(r = 0.1, unit = "cm")
    ),
    axis.ticks = ggplot2::element_line(
      color = "#202020"
    ),
    axis.title = ggplot2::element_text(
      face = "bold",
      size = ggplot2::rel(1.5)
    ),
    axis.title.x = ggplot2::element_text(
      margin = ggplot2::margin(t = 0.5, unit = "cm")
    ),
    axis.title.y = ggplot2::element_text(
      margin = ggplot2::margin(r = 0.5, unit = "cm"),
      angle = 90
    ),
    legend.key = ggplot2::element_rect(
      fill = NA
    ),
    legend.title = ggplot2::element_text(
      face = "bold",
      size = ggplot2::rel(1.33)
    ),
    legend.text = ggplot2::element_text(
      face = "bold",
      size = ggplot2::rel(1)
    ),
    panel.background = ggplot2::element_rect(
      fill = "white"
    ),
    panel.border = ggplot2::element_blank(),
    plot.background = ggplot2::element_rect(
      fill = NA,
      color = NA
    ),
    plot.caption = ggplot2::element_text(
      size = ggplot2::rel(0.8),
      margin = ggplot2::margin(1, 0, 0, 0, unit = "cm"),
      hjust = 1
    ),
    plot.margin = ggplot2::margin(0.8, 0.8, 0.8, 0.8, unit = "cm"),
    plot.subtitle = ggplot2::element_text(
      size = ggplot2::rel(1.2),
      lineheight = 1.2,
      margin = ggplot2::margin(b = .5, unit = "cm"),
      hjust = 0
    ),
    plot.title = ggplot2::element_text(
      size = ggplot2::rel(2),
      family = "Roboto Slab",
      face = "bold",
      margin = ggplot2::margin(b = 0.5, unit = "cm"),
      hjust = 0
    ),
    plot.title.position = "plot",
    strip.background = ggplot2::element_blank(),
    strip.text = ggtext::element_textbox(
      size = ggplot2::rel(1.33),
      face = "bold",
      color = "#202020",
      fill = "white",
      box.color = "#202020",
      halign = 0.5,
      linetype = 1,
      r = ggplot2::unit(0.3, "cm"),
      width = ggplot2::unit(1, "npc"),
      padding = ggplot2::margin(3, 0, 2, 0),
      margin = ggplot2::margin(3, 3, 10, 3)
    ),
    text = ggplot2::element_text(
      family = "Roboto",
      size = base_size
    ),
    ...
  )
}


#' ggplot2 theme inspired by `theme_gray()`
#'
#' Features: Blue background, light grid lines
#'
#' @param base_size Defaults to 12 (like all complete themes in ggplot2)
#' @param ... Passed to `ggplot2::theme()`
#'
#' @export
theme_junebug_calm <- function(base_size = 12, ...) {
  ggplot2::theme(
    axis.line = ggplot2::element_line(
      color = "#101010"
    ),
    axis.text = ggplot2::element_text(
      face = "bold",
      color = "#202020",
      size = base_size
    ),
    axis.text.x = ggplot2::element_text(
      lineheight = 1.2,
      margin = ggplot2::margin(t = 0.2, unit = "cm")
    ),
    axis.text.y = ggplot2::element_text(
      margin = ggplot2::margin(r = 0.1, unit = "cm")
    ),
    axis.ticks = ggplot2::element_line(
      color = "#101010"
    ),
    axis.title = ggplot2::element_text(
      face = "bold",
      size = ggplot2::rel(1.5)
    ),
    axis.title.x = ggplot2::element_text(
      margin = ggplot2::margin(t = 0.5, unit = "cm")
    ),
    axis.title.y = ggplot2::element_text(
      margin = ggplot2::margin(r = 0.5, unit = "cm"),
      angle = 90
    ),
    legend.background = ggplot2::element_rect(
      fill = "#A6B2BE"
    ),
    legend.key = ggplot2::element_rect(
      color = "#A6B2BE",
      fill = "#CDD9E5"
    ),
    legend.title = ggplot2::element_text(
      face = "bold",
      size = ggplot2::rel(1.33)
    ),
    legend.text = ggplot2::element_text(
      face = "bold",
      size = ggplot2::rel(1)
    ),
    panel.background = ggplot2::element_rect(
      fill = "#CDD9E5"
    ),
    panel.border = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    panel.grid.major = ggplot2::element_line(
      color = "#DDE1E6"
    ),
    plot.background = ggplot2::element_rect(
      fill = "#A6B2BE",
      color = NA
    ),
    plot.caption = ggplot2::element_text(
      size = ggplot2::rel(0.8),
      margin = ggplot2::margin(1, 0, 0, 0, unit = "cm"),
      hjust = 1
    ),
    plot.margin = ggplot2::margin(0.8, 0.8, 0.8, 0.8, unit = "cm"),
    plot.subtitle = ggplot2::element_text(
      size = ggplot2::rel(1.2),
      lineheight = 1.2,
      margin = ggplot2::margin(b = .5, unit = "cm"),
      hjust = 0
    ),
    plot.title = ggplot2::element_text(
      size = ggplot2::rel(2),
      family = "Roboto Slab",
      face = "bold",
      margin = ggplot2::margin(b = 0.5, unit = "cm"),
      hjust = 0
    ),
    plot.title.position = "plot",
    strip.background = ggplot2::element_blank(),
    strip.text = ggtext::element_textbox(
      size = ggplot2::rel(1.33),
      color = "black",
      fill = "#6C7A86",
      box.color = "grey",
      halign = 0.5,
      linetype = 1,
      r = ggplot2::unit(0.3, "cm"),
      width = ggplot2::unit(1, "npc"),
      padding = ggplot2::margin(4, 0, 3, 0),
      margin = ggplot2::margin(3, 3, 10, 3)
    ),
    text = ggplot2::element_text(
      family = "Roboto",
      size = base_size
    ),
    ...
  )
}


#' ggplot2 theme based on `theme_junebug_clean()`
#'
#' Features: Condensed fonts
#'
#' @param base_size Defaults to 12 (like all complete themes in ggplot2)
#' @param ... Passed to `ggplot2::theme()`
#'
#' @export
theme_junebug_compact <- function(base_size = 12, ...) {
  ggplot2::theme(
    axis.line = ggplot2::element_line(
      color = "#202020"
    ),
    axis.text = ggplot2::element_text(
      face = "bold",
      family = "Futura Bk BT",
      color = "#303030",
      size = base_size
    ),
    axis.text.x = ggplot2::element_text(
      lineheight = 1.2,
      margin = ggplot2::margin(t = 0.2, unit = "cm")
    ),
    axis.text.y = ggplot2::element_text(
      margin = ggplot2::margin(r = 0.1, unit = "cm")
    ),
    axis.ticks = ggplot2::element_line(
      color = "#202020"
    ),
    axis.title = ggplot2::element_text(
      face = "bold",
      size = ggplot2::rel(1.5)
    ),
    axis.title.x = ggplot2::element_text(
      margin = ggplot2::margin(t = 0.5, unit = "cm")
    ),
    axis.title.y = ggplot2::element_text(
      margin = ggplot2::margin(r = 0.5, unit = "cm"),
      angle = 90
    ),
    legend.key = ggplot2::element_rect(
      fill = NA
    ),
    legend.title = ggplot2::element_text(
      face = "bold",
      size = ggplot2::rel(1.33)
    ),
    legend.text = ggplot2::element_text(
      face = "bold",
      size = ggplot2::rel(1)
    ),
    panel.background = ggplot2::element_rect(
      fill = "white"
    ),
    panel.border = ggplot2::element_blank(),
    plot.background = ggplot2::element_rect(
      fill = NA,
      color = NA
    ),
    plot.caption = ggplot2::element_text(
      size = ggplot2::rel(0.8),
      margin = ggplot2::margin(1, 0, 0, 0, unit = "cm"),
      hjust = 1
    ),
    plot.margin = ggplot2::margin(0.8, 0.8, 0.8, 0.8, unit = "cm"),
    plot.subtitle = ggplot2::element_text(
      size = ggplot2::rel(1.2),
      lineheight = 1.2,
      margin = ggplot2::margin(b = .5, unit = "cm"),
      hjust = 0
    ),
    plot.title = ggplot2::element_text(
      size = ggplot2::rel(2),
      family = "Barlow Condensed",
      face = "bold",
      margin = ggplot2::margin(b = 0.5, unit = "cm"),
      hjust = 0
    ),
    plot.title.position = "plot",
    strip.background = ggplot2::element_blank(),
    strip.text = ggtext::element_textbox(
      size = ggplot2::rel(1.33),
      face = "bold",
      color = "#202020",
      fill = "white",
      box.color = "#202020",
      halign = 0.5,
      linetype = 1,
      r = ggplot2::unit(0.3, "cm"),
      width = ggplot2::unit(1, "npc"),
      padding = ggplot2::margin(3, 0, 2, 0),
      margin = ggplot2::margin(3, 3, 10, 3)
    ),
    text = ggplot2::element_text(
      family = "Roboto Condensed",
      size = base_size
    ),
    ...
  )
}


