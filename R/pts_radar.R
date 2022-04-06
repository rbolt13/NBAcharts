#' Points Radar Chart
#'
#' @description Create a radar plot of total points scored in
#'    the current season by a single NBA team.
#'
#' @param pts_data a data frame with a player column and a pts column.
#' @param team_cols_pal a color palette whose length is the same as the
#'     number of players in the data set.
#' @param chart_title is a char value that represents the title
#'     of the radar chart.
#' @param pts_filename is a char value that represents the name
#'     the chart file will be saved under.
#'
#' @return A .png file of the total points scored by an NBA team
#'     in the current season over a certain value.
#' @export
#'
