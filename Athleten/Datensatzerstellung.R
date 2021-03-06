##########################################
# Laden der Übersichten für jede Staffel #
##########################################
setwd("~/DataScience/Ninja_Projekt/Athleten/")

colnames = list('URL', 'Name', 'Nationalität', 'Birthday', 'Season')

txt_athlet <- list("16_Athleten_Overview.txt", "17_Athleten_Overview.txt", "18_Athleten_Overview.txt", "19_Athleten_Overview.txt", "20_Athleten_Overview.txt")
df_list_athlet <- lapply(txt_athlet, function(x) {df <- read.csv(x, sep = ",", col.names = colnames, header=FALSE, comment.char="#"); return(df)})


# Hinzufügen einer Spalte mit der jeweiligen Staffel Nummer
Season_bestimmen <- function(df){
  df['Season'] <- i;
  return(df)
}
df_list_season = df_list_athlet

for (i in 1:5){
  df_list_season[i] <- lapply(df_list_athlet[i], function(df) Season_bestimmen(df))
}


# Join in einen großen Datensatz
library('purrr')
library('tidyverse')
Athleten_df <- df_list_season %>% reduce(full_join, by = c('Name', 'URL', 'Nationalität', 'Birthday'))


# Aufsplitten der Spalte 'Name' in Vor- und Nachname
library(tidyr)
Name <- Athleten_df['Name']
Athleten_df <- extract(Athleten_df, Name, c("Vorname", "Nachname"), "([^ ]+) (.*)")
Athleten_df['Name'] <- Name

# Abgleichen der Vornamen mit Namensliste um Geschlecht zu bestimmen
Namen_Liste <- read.csv("~/DataScience/Ninja_Projekt/Athleten/Namens_Liste.csv", header=FALSE, col.names = c("Vorname", "Geschlecht"))
Athleten_df <- left_join(Athleten_df, Namen_Liste, "Vorname")
#Prbl <- c(Athleten_df['Vorname'][is.na.data.frame(Athleten_df['Geschlecht'])])

#Athleten_Detail_URLs <- Athleten_df['URL']
#write.csv(Athleten_Detail_URLs,"~/DataScience/Ninja_Projekt/Athleten/Athleten_Detail_URLs.csv")

# Überarbeiten der Staffeln an denen Athlet teilgenommen hat
colnames(Athleten_df)
Athleten_df[,6:10][is.na(Athleten_df[,6:10])] <- '' # Damit bei paste von NA Value nichts übertrgaen wird
colnames(Athleten_df[,6:10]) <- c('Season1', 'Season2', 'Season3', 'Season4', 'Season5')
for (i in 1:length(row.names(Athleten_df))){
  Athleten_df$Seasons[i] <- paste(Athleten_df[i,6], Athleten_df[i,7], Athleten_df[i,8], Athleten_df[i,9], Athleten_df[i,10])
}


Athleten_df_final <- Athleten_df[,c(11, 2, 3, 12, 4, 5, 13, 1, 6, 7, 8, 9, 10 )]
write.csv(Athleten_df_final,"Athleten_df.csv")
Athleten_df <- read.csv("Athleten_df.csv")


####################
# Athleten Details #
####################
setwd("/home/lisa/DataScience/Ninja_Projekt/Athleten/Athleten_Details/")
Athleten_det_df <- read.csv("result.txt", sep = ",")

# Formatieren der zu matchenden Spralten
Athleten_det_df$Birthday <- format(as.Date(Athleten_det_df$Birthday), "%d.%m.%Y")
Athleten_det_df <- Athleten_det_df[order(Athleten_det_df$Name),]
Athleten_det_df$Name <- as.character(Athleten_det_df$Name)

Athleten_df$Birthday <- format(as.Date(Athleten_df$Birthday, format = "%d.%m.%Y"), "%d.%m.%Y")
Athleten_df$Name <- as.character(Athleten_df$Name)
Athleten_df$Name <- str_remove(Athleten_df$Name, ' ')
Athleten_df <- Athleten_df[order(as.character(Athleten_df$Name)),]

library('purrr')
library('tidyverse')

Athleten_df_main <- full_join(Athleten_df, Athleten_det_df, by = c("Name", "Birthday", "Nationalität"))
write.csv(Athleten_df_main,"Athleten_df_main.csv")
Athleten_df_main <- read.csv("Athleten_df_main.csv")

######################################
# Laden der Ergebnisse der Staffel 5 #
######################################
setwd("~/DataScience/Ninja_Projekt/Hindernisse_Ergebnisse/2020/")
txt_list <- list("20_Ergebnisse_Vorrunde_1_format.txt", "20_Ergebnisse_Vorrunde_2_format.txt", "20_Ergebnisse_Vorrunde_3_format.txt", "20_Ergebnisse_Vorrunde_4_format.txt", "20_Ergebnisse_Vorrunde_5_format.txt", "20_Ergebnisse_Vorrunde_6_format.txt")
df_list <- lapply(txt_list, function(x) {df <- read.delim(x); return(df)})


# Finden von leeren Zeilen und löschen (Muss aber df bleiben!)
Ergebnisse_Vorrunde_6 <- as.data.frame(df_list[6])
Ergebnisse_Vorrunde_6['Name'][is.na(Ergebnisse_Vorrunde_6['Pfeil.Sprung'])]
is.na(Ergebnisse_Vorrunde_6['Pfeil.Sprung'])
Ergebnisse_Vorrunde_6 <- Ergebnisse_Vorrunde_6[-44,]
class(Ergebnisse_Vorrunde_6)

# Zeit korrigieren (Steht sonst auch bei Power.Tower)
df_list <- list(Ergebnisse_Vorrunde_1, Ergebnisse_Vorrunde_2, Ergebnisse_Vorrunde_3, Ergebnisse_Vorrunde_4, Ergebnisse_Vorrunde_5, Ergebnisse_Vorrunde_6)

df_list_ch1 <- lapply(df_list, function(x) {x$Zeit <- as.character(x$Zeit); return(x)})
df_list_ch <- lapply(df_list_ch1, function(x) {x$Power.Tower <- as.character(x$Power.Tower); return(x)})

df_list_Zeit <- lapply(df_list_ch, function(x) {x$Zeit[3:length(x$Zeit)] <- paste(x$Power.Tower[3:length(x$Power.Tower)], x$Zeit[3:length(x$Zeit)]); return(x)})
df_list_Zeit_PowerT <- lapply(df_list_Zeit, function(x) {x$Power.Tower[3:length(x$Power.Tower)] <- ""; return(x)})


# Zeit ist in verschiedenen Formaten angegeben - müsste unterschieden werden
# Ergebnisse_Vorrunde_1$Zeit <- as.PO(Ergebnisse_Vorrunde_1$Zeit, format="%H:%M.%OSm")


# Hinderniss bei dem Athlet gefallen ist
# (Anschließend können NAs mit 0 afgefüllt werden, damit Summe der bewälitigten Hindernisse berechnet werden kann)

# Definiere Funktion für "Gefallen bei Hindernis XY" 
# (Problem mit Automatisierung - lapply und for loops klappen nicht - evtl. Prbl. mit name?)
get_hindernisse <- function(df) {
  for (i in colnames(df)){
    df$Gefallen[df[i] == 0] <- i
  };
  return(df)
}

df_list_Hindernis <- lapply(df_list_Zeit_PowerT, function(x) get_hindernisse(x))
df_list_Hindernis_zero <- lapply(df_list_Hindernis, function(x) {x[is.na(x)] <- 0; return(x)})
df_list_Hindernisse <- lapply(df_list_Hindernis_zero, function(x) {x$Geschafft = rowSums(x[,c(2, 3, 4, 5, 6, 7, 8, 9, 10)]); return(x)})

# Schreibe mehrere Wörter aus verschiedenen Feldern in eine df-Zelle (Geschaffte Hindernisse/ Staffeln)
df <- as.data.frame(df_list_Hindernisse[2])

get_hindernisse_geschafft <- function(df) {
  for (n in colnames(df[,c(2, 3, 4, 5, 6, 7, 8, 9, 10)])){
    df$Bezwungen[df[n] == 1] <- paste(df$Bezwungen[df[n] == 1], n)
  };
  return(df)
}

df_list_Geschafft <- lapply(df_list_Hindernisse, function(x) get_hindernisse_geschafft(x))

df <- as.data.frame(df_list_Geschafft[3])

write_csv(as.data.frame(df_list_Geschafft[1]), "20_Hindernisse_Vorrunde1.csv")
write_csv(as.data.frame(df_list_Geschafft[2]), "20_Hindernisse_Vorrunde2.csv")
write_csv(as.data.frame(df_list_Geschafft[3]), "20_Hindernisse_Vorrunde3.csv")
write_csv(as.data.frame(df_list_Geschafft[4]), "20_Hindernisse_Vorrunde4.csv")
write_csv(as.data.frame(df_list_Geschafft[5]), "20_Hindernisse_Vorrunde5.csv")
write_csv(as.data.frame(df_list_Geschafft[6]), "20_Hindernisse_Vorrunde6.csv")
df['Geschafft']
