# R FOR DATA SCIENCE 2E - CHAPTER 2

## 2.5 EXERCISES

##### 1. Why does this code not work?
```
my_variable <- 10
my_varıable
#> Error: object 'my_varıable' not found
```

##### 2. Tweak each of the following R commands so that they run correctly:
original:
```
libary(todyverse)

ggplot(dTA = mpg) + 
  geom_point(maping = aes(x = displ y = hwy)) +
  geom_smooth(method = "lm)
```
reworked:
```
library(tidyverse)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) +
  geom_smooth(method= "lm")
```
##### 3. Press Option + Shift + K / Alt + Shift + K. What happens? How can you get to the same place using the menus?
tools > keyboard shortcuts menu

##### 4. Let’s revisit an exercise from the Section 1.6. Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?
```
my_bar_plot <- ggplot(mpg, aes(x = class)) +
  geom_bar()
my_scatter_plot <- ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave(filename = "mpg-plot.png", plot = my_bar_plot)
```
the first is saved because it is specified as a parameter in the line of code run
