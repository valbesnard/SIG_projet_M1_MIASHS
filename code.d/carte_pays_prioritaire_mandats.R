# Les 3-premiers déplacements
premiers_deplacements <- deplacements_etranger %>%
  filter(
    !is.na(mandat),
    !is.na(date_de_debut)
  ) %>%
  group_by(mandat) %>%
  slice_min(
    order_by = date_de_debut,
    n = 3,
    with_ties = FALSE
  ) %>%
  ungroup()

premiers_deplacements <- st_as_sf(premiers_deplacements)

# Compter les visites par pays et récupérer leur géométrie
centres_pays <- premiers_deplacements %>%
  st_make_valid() %>%
  group_by(pays) %>%
  summarise(
    nb_visites = n(),
    geometry = st_union(geometry),
    .groups = "drop"
  ) %>%
  st_transform(8857) %>%
  st_point_on_surface() %>%
  st_transform(st_crs(monde))

# Afficher la carte
print(
  ggplot(data = monde) +
    geom_sf(
      fill = "#E6DDED",
      color = "#6A4C93",
      linewidth = 0.2
    ) +
    geom_sf(
      data = centres_pays,
      aes(size = nb_visites),
      shape = 21,
      fill = "#F4A261",
      color = "#6A4C93",
      alpha = 0.8
    ) +
    geom_text_repel(
      data = centres_pays %>%
        st_drop_geometry() %>%
        bind_cols(
          st_coordinates(centres_pays) %>%
            as.data.frame()
        ),
      aes(
        x = X,
        y = Y,
        label = pays
      ),
      size = 3,
      fontface = "bold",
      color = "#333333",
      max.overlaps = Inf,
      box.padding = 0.5,
      point.padding = 0.4,
      min.segment.length = 0
    ) +
    scale_size_area(
      max_size = 8,
      name = "Nombre de visites"
    ) +
    labs(
      title = "Trois premiers déplacements par mandat",
      x = NULL,
      y = NULL
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(
        size = 16,
        face = "bold",
        hjust = 0.5
      ),
      panel.grid = element_blank()
    )
)
