devtools::install_github("clement2323/boutade")
library(BoutadE)
ls("package:BoutadE")

packages <- c(
    "dplyr","data.table","tidyverse",
    "ggplot2","knitr","pbapply","rmdformats","devtools","jsonlite"
    )

tmp <- sapply(packages,installer_package)
tmp <- sapply(packages,function(pkg) library(pkg, character.only = TRUE))
