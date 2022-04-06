
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NBAcharts

<!-- badges: start -->
<!-- badges: end -->

The goal of NBAcharts is to create quick charts of NBA data.

## Installation

You can install the development version of NBAcharts from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("rbolt13/NBAcharts")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(NBAcharts)
## basic example code
plot <- circ_col_chart(
  player_data = data.frame(player = c("DA", "CP3", "CJ", "DB", "MB","CP"),
                           data = c(978, 942, 797, 1789, 1135, 613)),
  col_pal = c("#1D1160", "#813840", "#63727A", "#723010", "#000000", "#F9AD1B"),
  chart_title = c("Example Plot"),
  chart_subtitle = c("This visualization is an example."),
  chart_source = c("\n\n Source: Here \nLink to Data: here"),
  cc_chart_filename = c("example_plot.png"))
plot
```

<img src="example_plot.png" width="100%" />

# Sources