# TÂCHES -----------------------------------------------------------------------

# Faire une analyse sur la période de 1958 à 2017

#1. Le nombre de pays visité pour chaque mandat


#2. La répartition des déplacement à l'étranger entre le premier ministre et 
#le président, et en France entre le premier ministre et le président. 
#L'ensemble par année puis  mandats.


#3. La liste des pays ayant eut le moins de visites avec une répartition 
#de ces visites sur la période étudié.

#--------------------------------------------------------------------------------


# Importation des librairies et des données ------------------------------------

library(sf)
library(tidyverse)
library(ggplot2)
library(spData)
library(countries) #pour avoir des données avec les noms de pays en français
library(countrycode)

deplacements <- st_read("./data/deplacements-presidents-republique-et-premiers-ministres-depuis-1945.geojson") %>% st_as_sf
monde <- world


# Ajout d'une colonne mandat ---------------------------------------------------

deplacements <- deplacements %>%
  mutate(
    date = as.Date(as.character(deplacements$date_de_debut)),
    mandat = case_when(
      
      date >= as.Date("1959-01-08") & date < as.Date("1966-01-08") ~
        "Mandat 1 - Charles de Gaulle",
      
      date >= as.Date("1966-01-08") & date < as.Date("1969-04-28") ~
        "Mandat 2 - Charles de Gaulle",
      
      date >= as.Date("1969-06-20") & date < as.Date("1974-04-02") ~
        "Mandat 3 - Georges Pompidou",
      
      date >= as.Date("1974-05-27") & date < as.Date("1981-05-21") ~
        "Mandat 4 - Valéry Giscard d'Estaing",
      
      date >= as.Date("1981-05-21") & date < as.Date("1988-05-21") ~
        "Mandat 5 - François Mitterrand",
      
      date >= as.Date("1988-05-21") & date < as.Date("1995-05-17") ~
        "Mandat 6 - François Mitterrand",
      
      date >= as.Date("1995-05-17") & date < as.Date("2002-05-17") ~
        "Mandat 7 - Jacques Chirac",
      
      date >= as.Date("2002-05-17") & date < as.Date("2007-05-16") ~
        "Mandat 8 - Jacques Chirac",
      
      date >= as.Date("2007-05-16") & date < as.Date("2012-05-15") ~
        "Mandat 9 - Nicolas Sarkozy",
      
      date >= as.Date("2012-05-15") & date < as.Date("2017-05-14") ~
        "Mandat 10 - François Hollande",
      
      TRUE ~ NA_character_
    )
  ) %>%
  select(-date)

#-------------------------------------------------------------------------------


# Partie 1 ---------------------------------------------------------------------

# Liste des colonnes à conserver
columnstokeep <- c(
  "fonction",
  "individu",
  "pays",
  "code_pays",
  "date_de_debut",
  "date_de_fin",
  "mandat")

# Nouveau df avec la liste de colonne seulement. Mise sous forme de tibble car pour l'instant, les polygônes ne nous intéresse pas
df_visite <- deplacements %>% as_tibble %>% select(all_of(columnstokeep))

# Filtre le df pour n'obtenir que les déplacements à l'étranger du président
df_visite_pres_etranger <- df_visite %>% filter(code_pays != "FRA" & fonction == "Président de la République")

# Agrégation pour obtenir le nombre de pays visité par mandat
nb_pays_etranger_par_mandat <- df_visite_pres_etranger %>% 
  group_by(mandat) %>% 
  summarise(nombre_visites = n()) 

# Tri selon les mandats
nb_pays_etranger_par_mandat <- arrange(nb_pays_etranger_par_mandat, as.numeric(str_extract(mandat, "\\d+")))

# Pour que ggplot garde l'ordre du df
nb_pays_etranger_par_mandat$mandat <- factor(
  nb_pays_etranger_par_mandat$mandat,
  levels = rev(nb_pays_etranger_par_mandat$mandat)
)


# Diagramme en bâton
ggplot(nb_pays_etranger_par_mandat[!is.na(nb_pays_etranger_par_mandat$mandat),],
       mapping = aes(x=nombre_visites, 
                     y=mandat)
) +
  geom_bar(stat = "identity", 
           lineend = "round",
           linejoin = "round",
           colour = "blue",
           fill = "blue",
           width = 0.5)

#Faire par morceau en fonction des régions du monde ?

#-------------------------------------------------------------------------------


# Partie 2 ---------------------------------------------------------------------

# Filtre pour avoir les visites en France
df_visite_en_france <- df_visite %>% filter(code_pays == "FRA")

# Agrégation selon fonction et mandat
nb_visite_france_pres_vs_prem <- df_visite_en_france %>% 
  select(-c("pays","code_pays","date_de_debut","date_de_fin")) %>% 
  group_by(fonction,mandat) %>% 
  summarise(nombre_visites=n())


ggplot(nb_visite_france_pres_vs_prem[!is.na(nb_visite_france_pres_vs_prem$mandat),],
       mapping = aes(x=nombre_visites, 
                     y=mandat,
                     fill = fonction)
) +
  geom_bar(stat = "identity",
           lineend = "round",
           linejoin = "round",
           width = 0.5)


# ------------------------------------------------------------------------------


# Partie 3 ---------------------------------------------------------------------

# Agrégation par pays
nb_visite_par_pays <- deplacements %>% 
  as_tibble %>% 
  group_by(pays,code_pays) %>% 
  summarise(nombre_de_visite= n()) %>% 
  order_by(arrange(., nombre_de_visite))

#-------------------------------------------------------------------------------
  