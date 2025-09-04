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