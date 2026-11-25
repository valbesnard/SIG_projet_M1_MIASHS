deplacements <- 
  st_read("./data.d/deplacements-presidents-republique-et-premiers-ministres-depuis-1945.geojson") %>%
  as_tibble()

deplacements[["date_de_debut"]] <- as.Date(deplacements$date_de_debut)

deplacements <- deplacements %>%
  mutate(
    date = date_de_debut,
    mandat = case_when(
      
      date >= as.Date("1959-01-08") & date < as.Date("1966-01-08") ~
        "Mandat 01 - Charles de Gaulle",
      
      date >= as.Date("1966-01-08") & date < as.Date("1969-04-28") ~
        "Mandat 02 - Charles de Gaulle",
      
      date >= as.Date("1969-06-20") & date < as.Date("1974-04-02") ~
        "Mandat 03 - Georges Pompidou",
      
      date >= as.Date("1974-05-27") & date < as.Date("1981-05-21") ~
        "Mandat 04 - Valéry Giscard d'Estaing",
      
      date >= as.Date("1981-05-21") & date < as.Date("1988-05-21") ~
        "Mandat 05 - François Mitterrand",
      
      date >= as.Date("1988-05-21") & date < as.Date("1995-05-17") ~
        "Mandat 06 - François Mitterrand",
      
      date >= as.Date("1995-05-17") & date < as.Date("2002-05-17") ~
        "Mandat 07 - Jacques Chirac",
      
      date >= as.Date("2002-05-17") & date < as.Date("2007-05-16") ~
        "Mandat 08 - Jacques Chirac",
      
      date >= as.Date("2007-05-16") & date < as.Date("2012-05-15") ~
        "Mandat 09 - Nicolas Sarkozy",
      
      date >= as.Date("2012-05-15") & date < as.Date("2017-05-14") ~
        "Mandat 10 - François Hollande",
      
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(mandat)) %>%
  select(-date) 

deplacements_etranger <- deplacements[deplacements$pays != "France",] %>% as_tibble()
monde <- world

deplacements_sf <- st_as_sf(deplacements, sf_column_name = "geometry")

nb_visite_par_pays <- deplacements_sf %>% 
  group_by(pays, code_pays) %>% 
  summarise(nombre_de_visite = n(),
            geometry = first(geometry),
            .groups = "drop") %>% 
  arrange(desc(nombre_de_visite))
