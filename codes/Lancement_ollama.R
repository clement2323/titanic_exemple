rm(list=ls());gc()

Sys.setenv(no_proxy = "")
Sys.setenv(https_proxy ="http://proxy-rie.http.insee.fr:8080")
Sys.setenv(http_proxy ="http://proxy-rie.http.insee.fr:8080")


detach("package:BoutadE", unload = TRUE)
source("codes/0.Setup.R",encoding="UTF-8")
library("BoutadE")
source("codes/1.Preparation_donnees.R",encoding = "UTF-8")

table_demandes <- read.csv("input/fichier_demandes_titanic.csv")
metadata <- jsonlite::fromJSON("input/metadonnees.json",simplifyDataFrame = FALSE)  # Ajout de la lecture du JSON
#metadata <- NULL
out <- pbapply(table_demandes,1,gerer_une_demande,metadata = metadata)
out_ollama <- pbapply(table_demandes,1,gerer_une_demande,for_ollama = TRUE,metadata = NULL)

# Then install the package from GitHub
devtools::install_github("clement2323/ollamax")
library(ollamax); #??ollamax

cat(preparer_prompt(out_ollama[[1]],metadata =metadata,nom_table = "titanic"))

generer_markdown_auto(table_demandes,out)

rmarkdown::render(
  input = "output/rapport_automatique.Rmd",
  envir = globalenv(),
)

generer_markdown_auto(
    table_demandes, 
    out,
    out_ollama = out_ollama, 
    fonction_ask_ollama = ask_ollama, metadata = "",
    prompt_header=NULL,prompt_instruction = NULL,model_name = "mistral-small"
    )

# TO DO sélectionner la metadata nécessaire  seulement ?

rmarkdown::render(
    input = "output/rapport_automatique.Rmd",
    envir = globalenv(),
)

Sys.time()

# Poser une question en spécifiant un autre modèle et une URL de base personnalisée
reponse <- ask_ollama("Explique la théorie de la relativité.", model_name = "mistral-small")
print(reponse)