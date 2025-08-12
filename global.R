library(shiny)
library(dplyr)
library(tidyr)
library(here)

createProbandLabel <- function(df){
  df %>% 
    mutate(label = as.numeric(factor(proband_id)), .by = c(Gene, MONDO)) %>% 
    unite(label, Gene, MONDO, label, sep = "__")
}


df_all <- readRDS(here("data/umap_allClingen.RDS"))
df_immune <- readRDS(here("data/umap_immunoCDWG.RDS"))
df_scid <- readRDS(here("data/umap_scidGCEP.RDS"))

df_hpo <- readRDS(here("data/proband_hpo.RDS")) %>% 
  createProbandLabel() %>% 
  select(label, HPO_ID, HPO_term) %>% 
  unite(HPO, HPO_ID, HPO_term, sep = " ", remove = F)

table1_genes <- c("IL7R", "CD3D", "CD3E", "CD3Z", "PTPRC", "LAT", "FOXN1", "CORO1A", 
                  "PAX1", "SLP76", "ITPKB", "IL2RG", "JAK3", "LIG4", "NHEJ1", "PRKDC", 
                  "RAG1", "RAG2", "DCLRE1C", "ADA", "AK2", "RAC2", "RFXANK", "CIITA", 
                  "RFX5", "RFXAP", "LCK", "POLD1", "POLD2", "COPG1", "SASH3", "CD8A", 
                  "ZAP70", "TAP2", "TAP1", "TAPBP", "B2M", "DOCK8", "IZKF1", "IL21", 
                  "MAP3K14", "STK4", "MSN", "MAN2B2", "ITK", "RELA", "CD3G", "TRAC", 
                  "FCHO1", "TNFRSF4", "RHOH", "CD40LG", "CD40", "DOCK2", "IFBKB", 
                  "CARD11", "BCL10", "IKKA", "REL", "IKZF1", "IKZF2", "IKZF3", 
                  "IL21R", "ICOS", "ICOSL", "MALT1", "RELB")