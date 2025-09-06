ui_topHPO_tab <- sidebarLayout(
  sidebarPanel(
    width = 3,
      selectizeInput("gene_HPO",
                     "Gene:",
                     choices = NULL,
                     selected = NULL,
                     multiple = TRUE,
                     options = list(
                       placeholder = "Type to search genes...",
                       create = FALSE
                     )),
    selectizeInput("hpo_HPO",
                   "HPO IDs:",
                   choices = NULL,
                   selected = NULL,
                   multiple = TRUE,
                   options = list(
                     placeholder = "Type to search HPO IDs...",
                     create = FALSE
                   ))
    ),
  mainPanel(
    fluidRow(
      div(class = "col-lg-4 col-12", div(class = "plot-container", plotOutput("geneHPO_tfidf", height = "100%", width = "100%")))
    )
  )
)