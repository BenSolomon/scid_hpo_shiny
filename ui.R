library(shiny)
source("ui_umap_tab.R")
source("ui_topHPO_tab.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("SCID HPO Data"),
  
  includeCSS("www/custom.css"),
  
  tabsetPanel(
  tabPanel("UMAP Projections",ui_umap_tab),
  tabPanel("Top HPO terms", ui_topHPO_tab)
  )
)