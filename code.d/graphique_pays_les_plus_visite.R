# Création du dataframe top 10
top_10_pays_etrangers <- nb_visite_par_pays %>% slice_head(n=11)
top_10_pays_etrangers <- top_10_pays_etrangers[-c(1),]

deplacements_top10 <- deplacements %>% 
  filter(pays %in% top_10_pays_etrangers$pays)


# 4. Stripplot : un point par visite
ggplot(deplacements_top10, aes(x = date_de_debut, y = pays)) +
  geom_jitter(height = 0.15, width = 0,
              size = 2.2, alpha = 0.7, color = "#1f4e79") +
  scale_x_date(
    limits = as.Date(c("1957-01-01", "2017-12-31")),
    date_breaks = "10 years",
    date_labels = "%Y"
  ) +
  labs(
    title = "Les 10 pays les plus visités par les présidents français depuis 1945",
    subtitle = "Un point = un déplacement diplomatique (entre parenthèses : total de visites)",
    x = NULL, y = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_line(color = "grey90"),
    plot.title.position = "plot"
  )
