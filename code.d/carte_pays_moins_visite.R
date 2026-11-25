# Réalisation du df contenant le nombre de visite par pays
nb_visite_par_pays <- deplacements_sf %>% 
  group_by(pays, code_pays) %>% 
  summarise(nombre_de_visite = n(),
            geometry = first(geometry),
            .groups = "drop") %>% 
  arrange(nombre_de_visite)

# Carte des pays visité une fois
ggplot() +
  geom_sf(data = monde, fill = "grey90", colour = "white") +
  geom_sf(data = filter(nb_visite_par_pays, nombre_de_visite == 1),
          fill = "purple", colour = "white") +
  geom_sf(data = filter(nb_visite_par_pays, nombre_de_visite == 2),
          fill = "cyan", colour = "white") +
  geom_sf(data = filter(nb_visite_par_pays, nombre_de_visite == 3),
          fill = "red", colour = "white") +
  theme_void()