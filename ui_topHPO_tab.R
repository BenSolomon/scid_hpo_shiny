ui_topHPO_tab <- sidebarLayout(
  sidebarPanel(
    width = 3,
    selectInput(
      "enrichment",
      "Find top:",
      choices = c("HPOs by gene" = "hpoXgene",
                  "Genes by HPO" = "geneXhpo"),
      selected = NULL
    ),
    conditionalPanel(
      condition = "input.enrichment == 'hpoXgene'",
      selectizeInput(
        "gene_HPO",
        "Gene:",
        choices = NULL,
        selected = NULL,
        multiple = TRUE,
        options = list(placeholder = "Type to search genes...",
                       create = FALSE)
      ),
      helpText("Can select multiple. To remove selection, click and press delete.")
    ),
    conditionalPanel(
      condition = "input.enrichment == 'geneXhpo'",
      selectizeInput(
        "hpo_HPO",
        "HPO IDs:",
        choices = NULL,
        selected = NULL,
        multiple = TRUE,
        options = list(placeholder = "Type to search HPO IDs...",
                       create = FALSE)
      ),
      helpText("Can select multiple. To remove selection, click and press delete.")
    ),
    numericInput("topN",
                 "Top N",
                 value = 10, min = 1, max = 20, step = 1),
    helpText("Number of top HPO terms or genes to display")
  ),
  mainPanel(
    uiOutput("geneHPO_tfidf")
  )
)