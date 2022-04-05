#' Points Radar Chart
#'
#' @description Create a radar plot of total points scored in
#'    the current season by a single NBA team.
#'
#' @param team_name a char value which represents an NBA name,
#'    which includes the city.
#' @param slug a char value that represents uniquely represents the
#'    url for an NBA team on Basket Reference.
#' @param team_cols two or more char values which represent the
#'     team colors for an NBA team
#' @param pts_value is a numerical value that will filter out
#'     shooters whose total points are less than this value.
#' @param chart_title is a char value that represents the title
#'     of the radar chart.
#' @param pts_filename is a char value that represents the name
#'     the chart file will be saved under.
#'
#' @return A .png file of the total points scored by an NBA team
#'     in the current season.
#' @export
#'
#' @examples
#' team_name <- "Phoenix Suns"
#' slug <- "PHO"
#' team_cols <- c("#1D1160", "#E56020", "#63727A", "#000000", "#F9AD1B")
#' pts_value <- 500
#' chart_title <- "Phoenix Suns Total Points for 21-22 Season"
#' pts_filename <- "suns_pts_radar.png"
#' pts_radar(
#'     team_name,
#'     slug,
#'     team_cols,
#'     pts_value,
#'     chart_title,
#'     pts_filename)
pts_radar <- function(
  team_name,
  slug,
  team_cols,
  pts_value,
  chart_title,
  pts_filename){

  # define team page URL
  url <- paste0("https://www.basketball-reference.com/teams/",slug,"/2022.html")

  # Read total stats
  ttl_stat <- url %>%
    read_html %>%
    html_node("#totals") %>%
    html_table()

  # Rename Column 2 to Name
  names(ttl_stat)[2] <- "Name"

  # Sort Data
  pts_sort <- ttl_stats %>%
    filter(PTS >= pts_value)

  # Create Data Frame
  pts_data <- data.frame(
    player = pts_sort$Name,
    pts = pts_sort$PTS
  )

  # Data Lengths
  pts_data_length <- length(pts_data$player)

  # Color Palettes
  pts_cols <- colorRampPalette(team_cols)(pts_data_length)

  # Radar Plots
  pts_plot <- ggplot(pts_data,
                     aes(x = reorder(str_wrap(player, 5), pts),
                         y = pts)
  ) +
    # Custom Panel Grid (500, 1000, 1500)
    geom_hline(
      aes(yintercept =y),
      data.frame(y=c(0:3)*500),
      color = "lightgrey"
    ) +
    geom_col(
      show.legend = TRUE,
      fill = pts_cols,
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
      subtitle = paste(
        "This visualisation shows the players whose total points for the
        2021/22 season are over", pts_value,
        sep = " "
      ),
      caption = "\n\n Source: Basketball Reference\nLink to Data: https://www.basketball-reference.com/"
    ) +
    coord_polar()

  # Save Data
  ggsave(pts_filename, pts_plot, width = 9, height = 12.6)

  # Print data
  knitr::include_graphics(pts_filename)
}
