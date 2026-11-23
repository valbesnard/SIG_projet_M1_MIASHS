repartition <- deplacements %>%
  mutate(
    pays = if_else(pays == "France", "France", "Étranger")
  ) %>%
  group_by(fonction, pays) %>%
  summarise(
    nb_deplacements = n(),
    .groups = "drop"
  )

print(
  ggplot(
    repartition, 
    aes(x = fonction, y = nb_deplacements, fill = pays))+ 
  geom_bar(stat = "identity", position="fill") +
  scale_y_continuous(labels=scales::percent) +  
  scale_fill_manual(
    values = c(
      "France" = "#6A4C93",
      "Étranger" = "#F4A261"
    )
  ) +
  labs(
    title = "Répartition des déplacements\nentre le président et le premier ministre",
    x = "Fonction",
    y = "Répartition des déplacements",
    fill = "Destination"
  ) + 
  theme_minimal() +
  theme(
    text = element_text(size = 15),
    plot.title = element_text(size = 20, face = "bold"),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 15),
    legend.title = element_text(size = 15),
    legend.text = element_text(size = 15)
  )
)