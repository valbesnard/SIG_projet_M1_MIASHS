df <- deplacements_etranger %>% 
  arrange(date_de_debut) %>% 
  filter(annee_du_voyage < 1991)

df <- df %>% group_by(annee_du_voyage) %>% 
  summarise(
  pays = first(pays),
  lieu = first(lieu),
  contenu_initial=first(contenu_initial),
  geometry=first(geometry)
  )

df <- df %>% 
  group_by(pays) %>% 
  summarise(nombre_de_visite = n()) %>% 
  arrange(nombre_de_visite) %>% 
  mutate(pays=factor(pays, levels=pays))

  

ggplot (data = df, 
        mapping = aes(x=nombre_de_visite, y=pays)
        ) +
  geom_bar(stat = "identity",
           lineend = "round",
           linejoin = "round",
           width = 0.5) +
  labs(
    title = "Nombre de fois où un pays a été visité en premier dans l'année civile - pré 91",
    y = "Pays",
    x = "Nombre de visite reçue",
  ) +
  theme_minimal() +
  geom_col(fill = "#59114D") 
