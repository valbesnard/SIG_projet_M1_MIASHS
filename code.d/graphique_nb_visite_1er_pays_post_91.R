
visites_premieres_post91 <- deplacements_etranger %>%
  filter(
    date_de_debut >= as.Date("1991-01-01"),
    date_de_debut <= as.Date("2017-12-31")
  ) %>%
  group_by(annee_du_voyage) %>%
  arrange(date_de_debut, .by_group = TRUE) %>%
  slice_min(date_de_debut, n = 1, with_ties = TRUE) %>%
  ungroup() %>%
  count(pays, name = "nb_premieres_visites") %>%
  arrange(desc(nb_premieres_visites))

print(
  ggplot(
    visites_premieres_post91,
    aes(
      x = reorder(pays, nb_premieres_visites),
      y = nb_premieres_visites
    )
  ) +
    geom_col(fill = "#E98A15") +
    coord_flip() +
    labs(
      title = "Pays visités en premier par année (1991-2017)",
      x = "Pays",
      y = "Nombre de premières visites"
    ) +
    theme_minimal() +
    theme(
      text = element_text(size = 13),
      plot.title = element_text(size = 18, face = "bold"),
      axis.text = element_text(size = 12)
    )
)
