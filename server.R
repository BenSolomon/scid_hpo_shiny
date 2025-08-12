library(shiny)
library(here)
library(ggplot2)
library(dplyr)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  df <- reactive({switch(input$projection, "all" = df_all, "immunology" = df_immune, "scid" = df_scid)})
  
  
  # Update selectize inputs with server-side choices
  observe({
    updateSelectizeInput(session, "gene",
                         choices = unique(df()$Gene),
                         server = TRUE)
    
    updateSelectizeInput(session, "cdwg",
                         choices = unique(df()$CDWG),
                         server = TRUE)
    
    updateSelectizeInput(session, "gcep",
                         choices = unique(df()$GCEP),
                         server = TRUE)
    
    updateSelectizeInput(session, "hpo",
                         choices = unique(df_hpo$HPO),
                         server = TRUE)
  })
  
  
  # Highlight search
  df_filter <- reactive({
    base_df <- df()
    
    if (input$annotation == "none") {
      return(base_df[0, ])
    } else if (input$annotation == "gene" && !is.null(input$gene)) {
      return(base_df %>% filter(Gene == input$gene))
    } else if (input$annotation == "cdwg" && !is.null(input$cdwg)) {
      return(base_df %>% filter(CDWG == input$cdwg))
      } else if (input$annotation == "gcep" && !is.null(input$gcep)) {
        return(base_df %>% filter(GCEP == input$gcep))
      } else if (input$annotation == "geneSet" && !is.null(input$geneSet) && length(input$geneSet) > 0) {
        return(base_df %>% filter(Gene %in% input$geneSet))
      } else if (input$annotation == "hpo" && !is.null(input$hpo)) {
        probands <- base_df %>% 
          left_join(df_hpo, by = c("label"), relationship = "many-to-many") %>% 
          filter(HPO == input$hpo) %>% 
          pull(label) %>% 
          unique()
        return(base_df %>% filter(label %in% probands))
      } else if (input$annotation == "pattern" && nchar(input$pattern) > 0) {
        probands <- base_df %>% 
          left_join(df_hpo, by = c("label"), relationship = "many-to-many") %>% 
          filter(grepl(input$pattern, HPO_term, ignore.case = TRUE)) %>% 
          pull(label) %>% 
          unique()
        return(base_df %>% filter(label %in% probands))
      } else if (input$annotation == "iuis1") {
        return(base_df %>% filter(Gene %in% table1_genes))
    } else {
      # Return empty data frame if annotation is selected but no specific value chosen
      return(base_df[0, ])
    }
  })
  
  
  output$distPlot <- renderPlot({
    ggplot(df(), aes(x= V1, y = V2))+
      geom_point(color = "grey50")+
      geom_point(data = df_filter(), fill = "darkorange", size = 3, shape = 21)+
      theme_bw() +
      ggtitle(input$GCEP) +
      labs(x = "UMAP1", y = "UMAP2")
    
  })
}

