# R FOR DATA SCIENCE 2E - CHAPTER 1 

## 1.2.5 Exercises

##### 1. How many rows are in penguins? How many columns?
'penguins' into console or 'glimpse(penguins)'  
Rows: 344  
Columns: 8

##### 2. What does the bill_depth_mm variable in the penguins data frame describe? Read the help for ?penguins to find out.
a number denoting bill length (millimeters)

##### 3. Make a scatterplot of bill_depth_mm vs. bill_length_mm. that is, make a scatterplot with bill_depth_mm on the y-axis and bill_length_mm on the x-axis. Describe the relationship between these two variables.
```
ggplot(data=penguins, mapping=aes(x=bill_length_mm, y=bill_depth_mm)) + geom_point()
```
low positive correlation

##### 4. What happens if you make a scatterplot of species vs. bill_depth_mm? What might be a better choice of geom?
```
ggplot(data=penguins, mapping=aes(x=species, y=bill_depth_mm)) + geom_point()
```
a better choice of geom might be a bar chart

##### 5. Why does the following give an error and how would you fix it?
```
ggplot(data = penguins) + 
  geom_point()
```
needs axes to plot

##### 6. What does the na.rm argument do in geom_point()? What is the default value of the argument? Create a scatterplot where you successfully use this argument set to TRUE.
na.rm ignores/removes missing values  
default is FALSE
```
ggplot(data=penguins, mapping=aes(x=flipper_length_mm, y=body_mass_g)) + geom_point(na.rm=TRUE)
```
no warning for missing values

##### 7. Add the following caption to the plot you made in the previous exercise: "Data comes from the palmerpenguins package." Hint: Take a look at the documentation for labs().
```
ggplot(data=penguins, mapping=aes(x=flipper_length_mm, y=body_mass_g)) + geom_point(na.rm=TRUE) + labs(title="Data comes from the palmerpenguins package")
```

##### 8. Recreate the following visualization. What aesthetic should bill_depth_mm be mapped to? And should it be mapped at the global level or at the geom level?
```
ggplot(data=penguins, mapping=aes(x=flipper_length_mm, y=body_mass_g)) + geom_point(mapping=aes(color=bill_depth_mm)) + geom_smooth()
```
bill_depth_mm should be mapped to the color aesthetic on the geom level

##### 9. Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.
```
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)
```

##### 10. Will these two graphs look different? Why/why not?
```
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()
```
```
ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
)
```
no; in this instance, data and mapping is the same defined globally vs geom

## 1.4.3 Exercises

##### 1. Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?
Assigning species to the y aesthetic will flip the axes (species on y and count on x), effectively rotating the plot 90 degrees

##### 2. How are the following two plots different? Which aesthetic, color or fill, is more useful for changing the color of bars?
```
ggplot(penguins, aes(x = species)) + geom_bar(color = "red")
```
```
ggplot(penguins, aes(x = species)) + geom_bar(fill = "red")
```
geom_bar(color="red") only assigns the color red to the borders of the bars, whereas geom_bar(fill="red") recolors the whole bar

##### 3. What does the bins argument in geom_histogram() do?
determines the number of bins the histogram is divided into

##### 4. Make a histogram of the carat variable in the diamonds dataset that is available when you load the vidyverse package. Experiment with different binwidths. What binwidth reveals the most interesting patterns?
```
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = .5)
```
smaller binwidths (.125) reveal more variation in the data, while larger binwidths (1) generalize beyond usefulness; a binwidth of .5 shows a clear relationship without overgeneralizing.

## 1.5.5 Exercises

##### 1. The mpg data frame that is bundled with the ggplot2 package contains 234 observations collected by the US Environmental Protection Agency on 38 car models. Which variables in mpg are categorical? Which variables are numerical? (Hint: Type ?mpg to read the documentation for the dataset.) How can you see this information when you run mpg?  
Categorical: manufacturer, model, trans, drv, fl, class  
Numerical: displ, year, cyl, cty, hwy  
Data types can be seen in tabular format when mpg is run; however the categorical/quantitative divide is not as simple as the difference between string data types and int/double/float types

##### 2. Make a scatterplot of hwy vs. displ using the mpg data frame. Next, map a third, numerical variable to color, then size, then both color and size, then shape. How do these aesthetics behave differently for categorical vs. numerical variables?
```
ggplot(
  data = mpg,
  mapping = aes(x = hwy, y = displ)
) +
  geom_point()
```
```
ggplot(
  data = mpg,
  mapping = aes(x = hwy, y = displ)
) +
  geom_point(mapping= aes(color=cyl))
```
```
ggplot(
  data = mpg,
  mapping = aes(x = hwy, y = displ)
) +
  geom_point(mapping= aes(size=year))
```
```
ggplot(
  data = mpg,
  mapping = aes(x = hwy, y = displ)
) +
  geom_point(mapping= aes(color=cyl, size=year))
```
```
ggplot(
  data = mpg,
  mapping = aes(x = hwy, y = displ)
) +
  geom_point(mapping= aes(shape=manufacturer))
```
continuous values (numeric) are permissible for color and size, but not for shape. Color can be represented continuously (for numeric data) or discretely (for categorical data). size can be assigned categorical or numeric data, however size is better suited for visual representations of numeric data than categorical data.

##### 3. In the scatterplot of hwy vs. displ, what happens if you map a third variable to linewidth?
generates a warning message ("ignoring unknown aesthetics: linewidth") because the scatterplot has no line to map linewidth to

##### 4. What happens if you map the same variable to multiple aesthetics?
the relationship between those features/aesthetics will be 1:1

##### 5. Make a scatterplot of bill_depth_mm vs. bill_length_mm and color the points by species. What does adding coloring by species reveal about the relationship between these two variables? What about faceting by species?
```
ggplot(
  data = penguins,
  mapping = aes(x = bill_depth_mm, y = bill_length_mm)
) +
  geom_point(mapping= aes(color=species))
```
shows how the bill_length_mm/bill_depth_mm relationship clusters by species

##### 6. Why does the following yield two separate legends? How would you fix it to combine the two legends?
```
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species")
```
remove lab(color= "Species")

##### 7. Create the two following stacked bar plots. Which question can you answer with the first one? Which question can you answer with the second one?
```
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")
```
```
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")
```
first stacked bar answers the question of which penguins and how many live on each island, whereas the second stacked bar plot answers the question of which islands do each penguin live on

## 1.6.1 Exercises

##### 1. Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?
```
ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.png")
```
the second because it is the most recently run plot

##### 2. What do you need to change in the code above to save the plot as a PDF instead of a PNG? How could you find out what types of image files would work in ggsave()?
change the file extension  
use ?ggsave and read documentation
