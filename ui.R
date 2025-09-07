library(shiny)
source("ui_umap_tab.R")
source("ui_topHPO_tab.R")
source("ui_test.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("SCID HPO Data"),
  
  includeCSS("www/custom.css"),
  
  tabsetPanel(
  tabPanel("UMAP Projections",ui_umap_tab),
  tabPanel("HPO Enrichment Heatmaps", ui_topHPO_tab)
  )
)