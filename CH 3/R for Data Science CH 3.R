# DATA TRANSFORMATION

# 3.1 INTRODUCTION

# install.packages("nycflights13") in console
library(nycflights13)
library(tidyverse)

#useful calls for exploring datasets:
flights
glimpse(flights)
view(flights)

# pipe: arg 1 is a data frame, subsequent args describe columns to operate on using var names, output is a new data frame
flights |>
  filter(dest == "IAH") |> 
  group_by(year, month, day) |> 
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

# 3.2 ROWS

# filter() function example:
flights |> 
  filter(dep_delay > 120)
# and
flights |> 
  filter(month == 1 & day == 1)
# or
flights |> 
  filter(month == 1 | month == 2)
# also or
flights |> 
  filter(month %in% c(1, 2))

# saving result of filter() in a variable
jan1 <- flights |> 
  filter(month == 1 & day == 1)

# arrange() function example:
flights |> 
  arrange(year, month, day, dep_time)
# descending order
flights |> 
  arrange(desc(dep_delay))

# distinct() function example (removes duplicates):
flights |> 
  distinct()
# find unique origin-destination pairs
flights |> 
  distinct(origin, dest)
# keep other columns in result
flights |> 
  distinct(origin, dest, .keep_all = TRUE)

# count() function example (number of occurences):
flights |>
  count(origin, dest, sort = TRUE)

# 3.2.5 EXERCISES

flights |>
  filter(arr_delay >= 2)
flights |>
  filter(dest == "IAH" | dest == "HOU")
flights |>
  filter(carrier == "UA" | carrier == "AA" | carrier == "DL")
flights |>
  filter(month == 7 | month == 8 | month == 9)
flights |>
  filter(arr_delay > 2 & dep_delay == 0)
flights |>
  filter(dep_delay >= 60 & dep_delay - arr_delay > 30)

flights |>
  arrange(desc(dep_delay))
flights |>
  arrange(dep_time)

flights |>
  arrange(arr_time - dep_time)

flights |>
  distinct(month, day)

flights |>
  arrange(desc(distance))
flights |>
  arrange(distance)

# 3.3 COLUMNS

# adds new cols to the right of the table
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60
  )

# .before adds the cols to the left of 1
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  )

# adds cols after day
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )

# contains only variables used in expressions
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

# select cols by name
flights |> 
  select(year, month, day)

# select all cols between year and day inclusive
flights |> 
  select(year:day)

# select all cols except those between year and day inclusive
flights |> 
  select(!year:day)

# select all cols that are characters
flights |> 
  select(where(is.character))

?select

# rename variables as a part of select
flights |> 
  select(tail_num = tailnum)

# rename variable and keep all existing variables
flights |> 
  rename(tail_num = tailnum)

# moves to select variables front
flights |> 
  relocate(time_hour, air_time)

# moves to specified location
flights |> 
  relocate(year:dep_time, .after = time_hour)
flights |> 
  relocate(starts_with("arr"), .before = dep_time)

# 3.3.5 EXERCISES

flights |>
  select(dep_time, dep_delay, arr_time, arr_delay)
flights |>
  select(starts_with("arr"), starts_with("dep"))

flights |> select(contains("TIME"))

?select(contains())

flights |> 
  mutate(air_time_min = air_time, .before = 1)

flights |> 
  arrange(arr_delay) |>
    select(tailnum)

# 3.5 THE PIPE

# using the pipe
flights |> 
  filter(dest == "IAH") |> 
  mutate(speed = distance / air_time * 60) |> 
  select(year:day, dep_time, carrier, flight, speed) |> 
  arrange(desc(speed))

# nested
arrange(
  select(
    mutate(
      filter(
        flights, 
        dest == "IAH"
      ),
      speed = distance / air_time * 60
    ),
    year:day, dep_time, carrier, flight, speed
  ),
  desc(speed)
)

# intermediate objects
flights1 <- filter(flights, dest == "IAH")
flights2 <- mutate(flights1, speed = distance / air_time * 60)
flights3 <- select(flights2, year:day, dep_time, carrier, flight, speed)
arrange(flights3, desc(speed))

mtcars %>% 
  group_by(cyl) %>%
  summarize(n = n())

# 3.5 Groups

#use group_by() to divide dataset into meaningful groups
flights |> 
  group_by(month)

# reduces data frame to have as single row per group
flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay)
  )

# ignore missing values explicitly in mean()
flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE)
  )

# n() returns number of rows
flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    n = n()
  )

?slice()

# finds flights most delayed upon arrival at each destination
flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1) |>
  relocate(dest)

# group by multiple variable - ex. by each date
daily <- flights |>  
  group_by(year, month, day)
daily 

# summarizing a tibble grouped by more than one variable peels off last group
daily_flights <- daily |> 
  summarize(n = n())

# suppress warning message
daily_flights <- daily |> 
  summarize(
    n = n(), 
    .groups = "drop_last"
  )

# remove groupiing without using summarize
daily |> 
  ungroup()

# summary of ungrouped data frame
daily |> 
  ungroup() |>
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    flights = n()
  )  

# .by - group within single operation
flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = month
  )

# .by - group by multiple variables
flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = c(origin, dest)
  )

# 3.5.7 EXERCISES
flights |>
  group_by(carrier) |>
  summarize(arr_delay = mean(arr_delay, na.rm = TRUE), n= n()) |>
  arrange(desc(arr_delay))

flights |>
  group_by(origin) |>
  arrange(desc(dep_delay)) |>
  relocate(origin, dep_delay)
  
flights |>
  ggplot(aes(x = dep_time, y=dep_delay)) +
  geom_smooth()

?count()
   
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)

df |>
  group_by(y)

df |>
  arrange(y)

df |>
  group_by(y) |>
  summarize(mean_x = mean(x))

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))