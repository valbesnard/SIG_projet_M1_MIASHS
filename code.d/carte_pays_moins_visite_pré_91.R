# Réalisation du df contenant le nombre de visite par pays
nb_visite_par_pays <- deplacements_sf %>% 
  filter(annee_du_voyage < 1991) %>% 
  group_by(pays, code_pays) %>% 
  summarise(nombre_de_visite = n(),
            geometry = first(geometry),
            .groups = "drop") %>% 
  arrange(nombre_de_visite)

# Carte des pays visité une fois
ggplot() +
  geom_sf(
    data = monde,
    aes(fill = "0"),
    colour = "white") +
  geom_sf(
    data = filter(nb_visite_par_pays, nombre_de_visite == 1),
    aes(fill = "1"),
    colour = "white"
  ) +
  geom_sf(
    data = filter(nb_visite_par_pays, nombre_de_visite == 2),
    aes(fill = "2"),
    colour = "white"
  ) +
  geom_sf(
    data = filter(nb_visite_par_pays, nombre_de_visite == 3),
    aes(fill = "3"),
    colour = "white"
  ) +
  geom_sf(
    data = filter(nb_visite_par_pays, nombre_de_visite > 3),
    aes(fill = "> 3"),
    colour = "white"
  ) +
  scale_fill_manual(
    name = "Nombre de visites",
    values = c(
      "0"   = "grey",
      "1"   = "#35B779",
      "2"   = "#26828E",
      "3"   = "#3E4989",
      "> 3" = "#440154"
    ),
    breaks = c("0","1", "2", "3", "> 3")
  ) +
  theme_void() +
  labs(title = "Nombre de visites par pays (1957-1991)") +
  theme(
    plot.title = element_text(
      size = 16,
      face = "bold",
      hjust = 0.5
    ))
