library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("HPO UMAP Projections"),
  
  includeCSS("www/custom.css"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(width = 3, 
      selectInput("annotation",
                  "Annotate by:",
                  choices = c("None" = "none",
                              "CDWG" = "cdwg", 
                              "GCEP" = "gcep", 
                              "Gene" = "gene",
                              "Gene set" = "geneSet",
                              "HPO term" = "hpo",
                              "HPO pattern" = "pattern",
                              "IUIS table 1" = "iuis1"),
                  selected = "None"),
      
      # Conditional Gene input
      conditionalPanel(
        condition = "input.annotation == 'gene'",
        selectizeInput("gene",
                       "Gene:",
                       choices = NULL,
                       selected = NULL,
                       options = list(
                         placeholder = "Type to search genes...",
                         create = FALSE
                       ))
      ),
      # Conditional CDWG input
      conditionalPanel(
        condition = "input.annotation == 'cdwg'",
        selectizeInput("cdwg",
                       "CDWG:",
                       choices = NULL,
                       selected = NULL,
                       options = list(
                         placeholder = "Type to search genes...",
                         create = FALSE
                       ))
      ),
      # Conditional CDWG input
      conditionalPanel(
        condition = "input.annotation == 'gcep'",
        selectizeInput("gcep",
                       "GCEP:",
                       choices = NULL,
                       selected = NULL,
                       options = list(
                         placeholder = "Type to search genes...",
                         create = FALSE
                       ))
        ),
      conditionalPanel(
        condition = "input.annotation == 'geneSet'",
        selectizeInput("geneSet",
                       "Gene Set:",
                       choices = NULL,
                       selected = NULL,
                       multiple = TRUE,
                       options = list(
                         placeholder = "Type genes separated by commas...",
                         create = TRUE,
                         persist = FALSE
                       ))
      ),
      conditionalPanel(
        condition = "input.annotation == 'pattern'",
        textInput("pattern",
                  "HPO Pattern Search:",
                  value = NULL,
                  placeholder = "Enter text to search within HPO terms...")
      ),
      conditionalPanel(
        condition = "input.annotation == 'hpo'",
        selectizeInput("hpo",
                       "HPO IDs:",
                       choices = NULL,
                       selected = NULL,
                       options = list(
                         placeholder = "Type to search HPO IDs...",
                         create = FALSE
                       ))
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(
        div(class = "col-lg-4 col-12", div(class = "plot-container", plotOutput("cdwg", height = "100%", width = "100%"))),
        div(class = "col-lg-4 col-12", div(class = "plot-container", plotOutput("gcep", height = "100%", width = "100%"))),
        div(class = "col-lg-4 col-12", div(class = "plot-container", plotOutput("scid", height = "100%", width = "100%")))
        )
    )
  )
)