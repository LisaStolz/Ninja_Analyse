###################################
# Formatiere Halbfinal Ergebnisse #
###################################
setwd("~/DataScience/Ninja_Projekt/Hindernisse_Ergebnisse/2020/")
df_Halbfinale <- read.delim("20_Ergebnisse_Halbfinale_1_format.txt")

# Finden von leeren Zeilen und löschen
df_Halbfinale['Name'][is.na(df_Halbfinale['Sprung.Tritte'])]
#df_Halbfinale <- df_Halbfinale[-44,]

# Zeit korrigieren (Steht sonst auch bei letzten Hindernissen)
df_Halbfinale$Zeit <- as.character(df_Halbfinale$Zeit)
df_Halbfinale$Doppelter.Rohrschlitten.mit.Cargo.Netz <- as.character(df_Halbfinale$Doppelter.Rohrschlitten.mit.Cargo.Netz)
df_Halbfinale$Riesenrad <- as.character(df_Halbfinale$Riesenrad)

df_Halbfinale[(df_Halbfinale$Doppelter.Rohrschlitten.mit.Cargo.Netz!=1&df_Halbfinale$Doppelter.Rohrschlitten.mit.Cargo.Netz!=0),]$Zeit <- paste(df_Halbfinale[(df_Halbfinale$Doppelter.Rohrschlitten.mit.Cargo.Netz!=1&df_Halbfinale$Doppelter.Rohrschlitten.mit.Cargo.Netz!=0),]$Zeit, df_Halbfinale[(df_Halbfinale$Doppelter.Rohrschlitten.mit.Cargo.Netz!=1&df_Halbfinale$Doppelter.Rohrschlitten.mit.Cargo.Netz!=0),]$Doppelter.Rohrschlitten.mit.Cargo.Netz)
df_Halbfinale[(df_Halbfinale$Doppelter.Rohrschlitten.mit.Cargo.Netz!=1&df_Halbfinale$Doppelter.Rohrschlitten.mit.Cargo.Netz!=0),]$Doppelter.Rohrschlitten.mit.Cargo.Netz <- NA

df_Halbfinale[(df_Halbfinale$Riesenrad!=1&df_Halbfinale$Riesenrad!=0),]$Zeit <- paste(df_Halbfinale[(df_Halbfinale$Riesenrad!=1&df_Halbfinale$Riesenrad!=0),]$Zeit, df_Halbfinale[(df_Halbfinale$Riesenrad!=1&df_Halbfinale$Riesenrad!=0),]$Riesenrad)
df_Halbfinale[(df_Halbfinale$Riesenrad!=1&df_Halbfinale$Riesenrad!=0),]$Riesenrad <- NA

for (i in 1:length(df_Halbfinale[,10])){
  if (is.na(df_Halbfinale[i,10]) & (df_Halbfinale[i,9] != 0 | df_Halbfinale[i,9] != NA)){
    df_Halbfinale[i,10] <- 1
  }
}


# Hinderniss bei dem Athlet gefallen ist
# (Anschließend können NAs mit 0 afgefüllt werden, damit Summe der bewälitigten Hindernisse berechnet werden kann)

# Definiere Funktion für "Gefallen bei Hindernis XY" 
get_hindernisse <- function(df) {
  for (i in colnames(df)){
    df$Gefallen[df[i] == 0] <- i
  };
  return(df)
}

df_Halbfinale_Hindernis <- get_hindernisse(df_Halbfinale)
df_Halbfinale_Hindernis[is.na(df_Halbfinale_Hindernis)] <- 0
df_Halbfinale_Hindernis$Doppelter.Rohrschlitten.mit.Cargo.Netz <- as.numeric(df_Halbfinale_Hindernis$Doppelter.Rohrschlitten.mit.Cargo.Netz)
df_Halbfinale_Hindernis$Riesenrad <- as.numeric(df_Halbfinale_Hindernis$Riesenrad)
df_Halbfinale_Hindernis$Geschafft <- rowSums(df_Halbfinale_Hindernis[,c(2:11)])

# Schreibe mehrere Wörter aus verschiedenen Feldern in eine df-Zelle (Geschaffte Hindernisse/ Staffeln)
get_hindernisse_geschafft <- function(df) {
  for (n in colnames(df[,c(2:11)])){
    df$Bezwungen[df[n] == 1] <- paste(df$Bezwungen[df[n] == 1], n)
  };
  return(df)
}

df_Halbfinale_1 <- get_hindernisse_geschafft(df_Halbfinale_Hindernis)

write_csv(as.data.frame(df_Halbfinale_1, "20_Hindernisse_Halbfinale1.csv")

