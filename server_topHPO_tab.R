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
    if (input$enrichment == "hpoXgene"){
      plt <- genehpoHeatmap(
        df_tfidf,
        filtering_var = "Gene", 
        filter_selections = input$gene_HPO, 
        x_var = "geneDisease",
        y_var = "hpo",
        top_n = as.numeric(input$topN))
    } else if (input$enrichment == "geneXhpo"){
      plt <- genehpoHeatmap(
        df_tfidf,
        filtering_var = "hpo",
        filter_selections = input$hpo_HPO,
        x_var = "hpo",
        y_var = "geneDisease",
        top_n = as.numeric(input$topN))
    }
    return(plt)
  })
}
