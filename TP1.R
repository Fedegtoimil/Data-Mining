library("data.table")
load_csv_data <- function(csv_file, sample_ratio = 1, drop_cols = NULL,
                          sel_cols = NULL) {
  dt <- fread(csv_file, header = TRUE, sep = ",", stringsAsFactors = TRUE,
              na.strings = "", drop = drop_cols, select = sel_cols,
              showProgress = TRUE)
  if (sample_ratio < 1) {
    sample_size <- as.integer(sample_ratio * nrow(dt))
    dt <- dt[sample(.N, sample_size)]
  }
  return(dt)
}

df1 <- load_csv_data("Maestria MiM+Analytics/2020/01 - Modulo/03 - Data Mining/TP/train_1.csv", sample_ratio = 0.1)
df2 <- load_csv_data("Maestria MiM+Analytics/2020/01 - Modulo/03 - Data Mining/TP/train_2.csv", sample_ratio = 0.1)
df3 <- load_csv_data("Maestria MiM+Analytics/2020/01 - Modulo/03 - Data Mining/TP/train_3.csv", sample_ratio = 0.1)
df4 <- load_csv_data("Maestria MiM+Analytics/2020/01 - Modulo/03 - Data Mining/TP/train_4.csv", sample_ratio = 0.1)
df5 <- load_csv_data("Maestria MiM+Analytics/2020/01 - Modulo/03 - Data Mining/TP/train_5.csv", sample_ratio = 0.1)



sample.conso <- do.call("rbind",list(df1,df2,df3,df4,df5))
is.data.table(sample.conso)

setcolorder(sample.conso,sort(colnames(sample.conso)))

rm(df1,df2,df3,df4,df5)




###########################################################################################

#Como guardar .csv
setwd(dir = "Maestria MiM+Analytics/2020/01 - Modulo/03 - Data Mining/TP/")
write.csv(sample.conso,file = "sample_conso.csv")
setwd(dir = "C:/Users/Jorge/Documents")
rm(sample.conso)
sample_conso = read.csv(file = "Maestria MiM+Analytics/2020/01 - Modulo/03 - Data Mining/TP/sample_conso.csv",)
sample_conso$X<-NULL        #Eliminar la columna que esta de mas a la hora de importar datos


###########################################################################################

#Como ver aquellas obs con muchos NA
na_prop <- sapply(sample.conso, function(x) sum(is.na(x)) / length(x))
df_na <- (data.frame(na_prop))
df_na <- df_na[df_na$na_prop > 0.7, , drop = FALSE]

###########################################################################################
df <- data.table(A = rep(1:3, each=4), B = rep(1:4, each=3), C = rep(1:2, 6),key = )
duplicated(df) #Trae como TRUE aquella fila que tiene una igual a la otra
df<-unique(df) #Elimina filas duplicadas
duplicated(df)

unique(sample.conso)
###########################################################################################
sample.conso[,country_count := .N, by= country ]
head( sample.conso[, c("country","country_count")])


###########################################################################################
sample.conso[, Label := as.numeric(Label_max_played_dsi <= 3)]
table(sample.conso$Label)
prop.table(table(sample.conso$Label))

sample.conso$Lose_Grand_total <- sample.conso$LoseBattle_sum_dsi0 + sample.conso$LoseBattle_sum_dsi1 + sample.conso$LoseBattle_sum_dsi2 + sample.conso$LoseBattle_sum_dsi3

###########################################################################################
#Grafico= Promedio de batallas totales pedidas por cantidad de dias que jugo ¿como hacer?

#haciendo cambios
str(a)

