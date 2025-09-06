require(dplyr)

filterData <- function(base_df, 
                       annotation,
                       gene,
                       cdwg,
                       gcep,
                       geneSet,
                       hpo,
                       pattern
                       ){
  if (annotation == "none") {
    return(base_df[0, ])
  } else if (annotation == "gene" && !is.null(gene)) {
    return(base_df %>% filter(Gene == gene))
  } else if (annotation == "cdwg" && !is.null(cdwg)) {
    return(base_df %>% filter(CDWG == cdwg))
  } else if (annotation == "gcep" && !is.null(gcep)) {
    return(base_df %>% filter(GCEP == gcep))
  } else if (annotation == "geneSet" && !is.null(geneSet) && length(geneSet) > 0) {
    return(base_df %>% filter(Gene %in% geneSet))
  } else if (annotation == "hpo" && !is.null(hpo)) {
    probands <- base_df %>% 
      left_join(df_hpo, by = c("label"), relationship = "many-to-many") %>% 
      filter(HPO == hpo) %>% 
      pull(label) %>% 
      unique()
    return(base_df %>% filter(label %in% probands))
  } else if (annotation == "pattern" && nchar(pattern) > 0) {
    probands <- base_df %>% 
      left_join(df_hpo, by = c("label"), relationship = "many-to-many") %>% 
      filter(grepl(pattern, HPO_term, ignore.case = TRUE)) %>% 
      pull(label) %>% 
      unique()
    return(base_df %>% filter(label %in% probands))
  } else if (annotation == "iuis1") {
    return(base_df %>% filter(Gene %in% table1_genes))
  } else {
    # Return empty data frame if annotation is selected but no specific value chosen
    return(base_df[0, ])
  }
}


genehpoHeatmap <- function(df, x_var, y_var, filtering_var, filter_selections, top_n =10, wrap_width = 40){
  # browser()
  topYvar <- df %>% 
    filter(.data[[filtering_var]] %in% filter_selections) %>% 
    slice_max(order_by = tf_idf, n = top_n, by = !!sym(x_var)) %>% 
    arrange(!!sym(x_var), desc(tf_idf)) 
  
  orderYvar <- unique(topYvar[[y_var]])
  orderXvar <- unique(topYvar[[x_var]])
  
  
  df <- df[df[[y_var]] %in% orderYvar, ]
  df <- df[df[[filtering_var]] %in% filter_selections, ]
  df <- df[, c(x_var, y_var, "tf_idf")]
  df <- complete(df, !!sym(x_var), !!sym(y_var), fill = list(tf_idf = 0))
  df[[y_var]] <- factor(df[[y_var]], levels = rev(orderYvar))
  # df[[x_var]] <- stringr::str_wrap(df[[x_var]], width = wrap_width)
  df[["hpo"]] <- stringr::str_wrap(df[["hpo"]], width = wrap_width)
  df[["geneDisease"]] <- stringr::str_wrap(df[["geneDisease"]], width = wrap_width)
  df[[x_var]] <- forcats::fct_relevel(
    df[[x_var]], 
    stringr::str_wrap(orderXvar, width = wrap_width))
  df[[y_var]] <- forcats::fct_relevel(
    df[[y_var]], 
    stringr::str_wrap(rev(orderYvar), width = wrap_width))
  
  ggplot(df, aes_string(x = x_var, y = y_var, fill = "tf_idf"))+
    geom_tile()+
    scale_fill_viridis_c(limits = c(0,NA)) +
    theme_classic()+
    theme(axis.text.x = element_text(angle= 90, hjust= 1)) +
    labs(x = NULL, y = NULL, fill = "TF-IDF")
}



