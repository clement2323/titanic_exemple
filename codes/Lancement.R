rm(list=ls());gc()

source("codes/0.Setup.R",encoding="UTF-8")
source("codes/1.Preparation_donnees.R",encoding = "UTF-8")

table_demandes <- read.csv("input/fichier_demandes_titanic.csv")
out <- pbapply(table_demandes,1,gerer_une_demande)

generer_markdown_auto(table_demandes,out)

rmarkdown::render(
  input = "output/rapport_automatique.Rmd",
  envir = globalenv(),
)


# Lecture du fichier JSON de metadonnées
metadonnees <- fromJSON("input/metadonnees.json")

# Conversion de la partie "variables" en data.frame pour plus de facilité
variables_df <- as.data.frame(metadonnees$variables)

gerer_une_demande(table_demandes[1,],variables_df)
