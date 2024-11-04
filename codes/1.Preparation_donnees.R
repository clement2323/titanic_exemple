
titanic <- read.csv("input/titanic.csv")
titanic <- as.data.table(titanic)
colnames(titanic) <- tolower(colnames(titanic))