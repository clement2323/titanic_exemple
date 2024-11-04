
rm(list=ls());gc()
source("codes/0.a.Setup.R",encoding="UTF-8")
source("codes/fonctions.R")

Sys.time()
dir <- "X:/HAB-ESANE-DIFFUSION-DIRAG/FARE/DG/Input/"
annee_en_cours <- 2021
source("codes/1.preparation_donnees.R",encoding = "UTF-8")

table_demandes <- read.csv("input/fichier_demandes.csv")

out <- pbapply(table_demandes,1,gerer_une_demande)
out_ollama <- pbapply(table_demandes,1,gerer_une_demande,for_ollama = TRUE)

# Then install the package from GitHub
devtools::install_github("clement2323/ollamax")
library(ollamax); #??ollamax

metadata <- list( 
    dep_FI = "département de la filiale",
    dep_EP = "département de l'entreprise profilée",
    poids_sum = "somme des poids des entreprises (=1 ici), nombre d'entreprise de fait",
    redi_r310_FI = "chiffre d'affaires des filiales",
    dep_FI_relatif = "département relatif (\"interieur\" si même département que l'entreprise)",
    dep_EP_relatif = "département relatif (\"interieur\" si même département que la filiale)"
)

generer_markdown_auto(
    table_demandes, 
    out,
    out_ollama = out_ollama, 
    fonction_ask_ollama = ask_ollama, metadata = metadata,
    prompt_header=NULL,prompt_instruction = NULL,model_name = "mistral-small"
    )

# TO DO sélectionner la metadata nécessaire  seulement ?

rmarkdown::render(
    input = "output/rapport_automatique.Rmd",
    envir = globalenv(),
)

Sys.time()