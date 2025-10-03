# R FOR DATA SCIENCE 2E - CHAPTER 1 

## 1.2.5

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
