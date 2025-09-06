source("functions.R")
topHPO_server <- function(input, output, session) {
  observe({
    updateSelectizeInput(session, "gene_HPO",
                         choices = all_genes,  
                         server = TRUE)
    updateSelectizeInput(session, "hpo_HPO",
                         choices = all_hpo,
                         server = TRUE)
  })
  
  output$geneHPO_tfidf <- renderPlot({
    df_tfidf %>% 
      separate(geneDisease, into = c("Gene", "Disease"), sep =" - ", remove = F) %>%
      plotHPOheatmap(filtering_var = "Gene", filter_selections = input$gene_HPO, x_var = "geneDisease")
  })
}
