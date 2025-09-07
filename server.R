library(shiny)
library(here)
library(ggplot2)
library(dplyr)
source("server_umap_tab.R")
source("server_topHPO_tab.R")

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  umap_server(input, output, session)
  topHPO_server(input, output, session)
}

