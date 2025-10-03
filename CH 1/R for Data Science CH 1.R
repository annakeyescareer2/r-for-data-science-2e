library(tidyverse)
library(palmerpenguins)
library(ggthemes)

penguins

glimpse(penguins)

#add dataset
ggplot(data = penguins)

#add axes
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)

#add scatterplot
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()

#color key for species
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point()

#linear model for each species
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth(method = "lm")

#linear model for whole set
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth(method = "lm")

#species shape key
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

#labels and colorblind safe
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()

#implicit arguments for data and mapping
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

#pipe -- tbd
penguins |> 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

#bar chart
ggplot(penguins, aes(x = species)) +
  geom_bar()

#ordered bar chart
ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()

#histogram
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)

#binwidth demonstration -- too small, too large
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 20)
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 2000)

#density plot
ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

#box plot by species
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

#density plot by species
ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75)

#density plot with alpha set under curve
ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.5)

#stacked bar plot by count
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

#relative frequency bar plot by percentage
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

#SUMMARY

#two numerical values - scatterplot
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()

#three+ numerical values - scatterplots with categorical keys
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))

#categorical data split into facets
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)

#saving plots
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()

ggsave(filename = "penguin-plot.png")
