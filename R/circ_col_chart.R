#' Circular Column Chart
#'
#' @import ggplot2
#' @import stringr
#' @import stats
#'
#' @description Create a circular column chart.
#'
#' @param player_data a data frame with a player column and a data column.
#' @param ring_scale a numeric value that represent the value the y axis
#' is scaled by.
#' @param ring_inner a numeric value that represents where the inner ring
#' label will be placed on the graph.
#' @param ring_middle a numeric value that represents where the middle ring
#' label will be placed on the graph.
#' @param ring_outer a numeric value that represents where the outer ring
#' label will be placed on the graph.
#' @param ringlab_inner a char value that represents the label of the
#' inner ring.
#' @param ringlab_middle a char value that represents the label of the
#' middle ring.
#' @param ringlab_outer a char value that represents the label of the
#' outer ring.
#' @param col_pal a color palette whose length is the same as the
#'     number of players in the data set.
#' @param chart_title is a char value that represents the title
#'     of the radar chart.
#' @param chart_subtitle is a char value that is a written explanation
#'     of the information shown on the chart.
#' @param chart_source is a char value that represents information about the
#'     data, and visualzation.
#' @param cc_chart_filename is a char value that represents the name
#'     the chart file will be saved under.
#'
#' @return A .png file of the total points scored by an NBA team
#'     in the current season over a certain value.
#' @export
#'
#' @examples
#' player_data <- data.frame(player = c("DA", "CP3", "CJ", "DB", "MB", "CP"),
#'                        data = c(978, 942, 797, 1789, 1135, 613))
#' col_pal <- c("#1D1160", "#813840", "#63727A", "#723010", "#000000", "#F9AD1B")
#' chart_title <- c("Example Plot")
#' chart_subtitle <- c("This visualization is an example.")
#' chart_source <- c("\n\n Source: Here \nLink to Data: here")
#' cc_chart_filename <- c("example_plot.png")
circ_col_chart <- function(player_data,
                           ring_scale,
                           ring_inner,
                           ring_middle,
                           ring_outer,
                           ringlab_inner,
                           ringlab_middle,
                           ringlab_outer,
                           col_pal,
                           chart_title,
                           chart_subtitle,
                           chart_source,
                           cc_chart_filename){
  # Radar Pts Plot
  pts_plot <- ggplot2::ggplot(player_data,
                              aes(x = reorder(str_wrap(player, 5), data),
                                  y = data)
  ) +
    # Custom Panel Grid (500, 1000, 1500)
    geom_hline(
      aes(yintercept =y),
      data.frame(y=c(0:3)*ring_scale),
      color = "lightgrey"
    ) +
    geom_col(
      show.legend = TRUE,
      fill = col_pal,
      position = "dodge2",
      alpha = 0.9
    ) +
    # Annotate custom scale inside plot
    annotate(
      x = 0,
      y = ring_inner,
      label = ringlab_inner,
      geom = "text",
      color = "gray12"
    ) +
    annotate(
      x = 0,
      y = ring_middle,
      label = ringlab_middle,
      geom = "text",
      color = "gray12"
    ) +
    annotate(
      x = 0,
      y = ring_outer,
      label = ringlab_outer,
      geom = "text",
      color = "gray12"
    ) +
    theme(
      # Remove axis ticks and text
      axis.title = element_blank(),
      axis.ticks = element_blank(),
      axis.text.y = element_blank(),

      # Use gray text for the region names
      axis.text.x = element_text(color = "gray12", size = 12),

      # Remove legend
      legend.position = "none",

      # Customize the text in the title, subtitle, and caption
      plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
      plot.subtitle = element_text(size = 10, hjust = .5),
      plot.caption = element_text(size = 8, hjust = .5),

      # Make the background white and remove extra grid lines
      panel.background = element_rect(fill = "white", color = "white"),
      panel.grid = element_blank(),
      panel.grid.major.x = element_blank()
    ) +
    labs(
      title = chart_title,
      subtitle = chart_subtitle,
      caption = chart_source
    ) +
    coord_polar()

  # Save Data
  ggsave(cc_chart_filename, pts_plot, width = 9, height = 12.6)

  # Print Data
  knitr::include_graphics(cc_chart_filename)
}
