#' Circular Column Chart
#'
#' @import ggplot2
#' @import knitr
#'
#' @description Create a circular column chart.
#'
#' @param player_data a data frame with a player column and a data column.
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
      data.frame(y=c(0:3)*500),
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
      y = 600,
      label = "500",
      geom = "text",
      color = "gray12"
    ) +
    annotate(
      x = 0,
      y = 1100,
      label = "1000",
      geom = "text",
      color = "gray12"
    ) +
    annotate(
      x = 0,
      y = 1600,
      label = "1500",
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
