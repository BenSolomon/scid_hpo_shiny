# Sidebar with a slider input for number of bins 
ui_umap_tab <- sidebarLayout(
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
               helpText("Type of data to highlight probands by"),
               
               
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
                                )),
                 helpText("Highlight all probands with variant in selected gene")
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
                                )),
                 helpText("Highlight all probands with gene variants from a specific ClinGen CDWG")
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
                                )),
                 helpText("Highlight all probands with gene variants from a specific ClinGen GCEP")
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
                                )),
                 helpText("Highlight all probands with variant in selected gene. Can select multiple. To remove selection, click and press delete.")
               ),
               conditionalPanel(
                 condition = "input.annotation == 'pattern'",
                 textInput("pattern",
                           "HPO Pattern Search:",
                           value = NULL,
                           placeholder = "Enter text to search within HPO terms..."),
                 helpText("Highlight all probands with HPO terms containing pattern")
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
                                )),
                 helpText("Highlight all probands with selected HPO terms")
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