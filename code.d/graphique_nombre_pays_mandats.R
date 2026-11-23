# Nombre de pays visités et par mandat
visites_par_mandat <- deplacements_etranger %>%
  count(mandat, name = "nb_visites")

print(
  ggplot(
    visites_par_mandat, 
    aes(x = mandat, y = nb_visites)
  ) + 
    geom_col(fill = "#59114D") +
    labs(
      title = "Nombre de déplacements à l'étranger entre les mandats",
      x = "Mandat",
      y = "Nombre de déplacements",
    ) + 
    theme_minimal() +
    theme(
      text = element_text(size = 15),
      plot.title = element_text(size = 20, face = "bold"),
      axis.title = element_text(size = 15),
      axis.text = element_text(size = 15,),
      axis.text.x = element_text(
        angle = 80,
        hjust = 1),
      legend.title = element_text(size = 15),
      legend.text = element_text(size = 15)
    )
)
