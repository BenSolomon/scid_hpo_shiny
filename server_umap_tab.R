source("functions.R")
umap_server <- function(input, output, session) {
  
  base_list <- list("all" = df_all, "immune" = df_immune, "scid" = df_scid)
  
  # Update selectize inputs with server-side choices
  observe({
    updateSelectizeInput(session, "gene",
                         choices = unique(base_list$all$Gene),
                         server = TRUE)
    
    updateSelectizeInput(session, "cdwg",
                         choices = unique(base_list$all$CDWG),
                         server = TRUE)
    
    updateSelectizeInput(session, "gcep",
                         choices = unique(base_list$all$GCEP),
                         server = TRUE)
    
    updateSelectizeInput(session, "hpo",
                         choices = all_hpo,
                         server = TRUE)
  })
  
  
  filter_list <- reactive({
    lapply(
      base_list,
      function(x) {filterData(
        base_df = x,
        annotation = input$annotation,
        gene = input$gene,
        cdwg = input$cdwg,
        gcep = input$gcep,
        geneSet = input$geneSet,
        hpo = input$hpo,
        pattern = input$pattern
      )})})
  
  highlight_mult <- 2
  output$cdwg <- renderPlot({
    pt_size <- 1.5
    ggplot(base_list$all, aes(x= V1, y = V2))+
      geom_point(color = "grey50", size = pt_size)+
      geom_point(data = filter_list()$all, fill = "darkorange", size = pt_size*highlight_mult, shape = 21)+
      theme_bw() +
      ggtitle("All ClinGen projection") +
      labs(x = "All-UMAP1", y = "All-UMAP2") +
      theme(plot.title = element_text(size = 18))
  })
  
  output$gcep <- renderPlot({
    pt_size <- 2
    ggplot(base_list$immune, aes(x= V1, y = V2))+
      geom_point(color = "grey50", size = pt_size)+
      geom_point(data = filter_list()$immune, fill = "darkorange", size = pt_size*highlight_mult, shape = 21)+
      theme_bw() +
      ggtitle("Immunology CDWG projection") +
      labs(x = "Immuno-UMAP1", y = "Immuno-UMAP2") +
      theme(plot.title = element_text(size = 18))
  })
  
  output$scid <- renderPlot({
    pt_size <- 2.5
    ggplot(base_list$scid, aes(x= V1, y = V2))+
      geom_point(color = "grey50", size = pt_size)+
      geom_point(data = filter_list()$scid, fill = "darkorange", size = pt_size*highlight_mult, shape = 21)+
      theme_bw() +
      ggtitle("SCID GCEP projection") +
      labs(x = "SCID-UMAP1", y = "SCID-UMAP2") +
      theme(plot.title = element_text(size = 18))
  })
}