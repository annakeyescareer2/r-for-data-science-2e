# R FOR DATA SCIENCE 2E - CHAPTER 3

## 3.2.5 Exercises

##### 1. In a single pipeline for each condition, find all flights that meet the condition:
Had an arrival delay of two or more hours
```
flights |>
  filter(arr_delay >= 2)
```
Flew to Houston (IAH or HOU)
```
flights |>
  filter(dest == "IAH" | dest == "HOU")
```
Were operated by United, American, or Delta
```
flights |>
  filter(carrier == "UA" | carrier == "AA" | carrier == "DL")
```
Departed in summer (July, August, and September)
```
flights |>
  filter(month == 7 | month == 8 | month == 9)
```
Arrived more than two hours late but didn’t leave late
```
flights |>
  filter(arr_delay > 2 & dep_delay == 0)
```
Were delayed by at least an hour, but made up over 30 minutes in flight
```
flights |>
  filter(dep_delay >= 60 & dep_delay - arr_delay > 30)
```

##### 2. Sort flights to find the flights with the longest departure delays. Find the flights that left earliest in the morning.
```
flights |>
  arrange(desc(dep_delay))
```
```
flights |>
  arrange(dep_time)
```

##### 3. Sort flights to find the fastest flights. (Hint: Try including a math calculation inside of your function.)
```
flights |>
  arrange(arr_time - dep_time)
```

##### 4. Was there a flight on every day of 2013?
```
flights |>
  distinct(month, day)
```

##### 5. Which flights traveled the farthest distance? Which traveled the least distance?
```
flights |>
  arrange(desc(distance))
```
```
flights |>
  arrange(distance)
```

##### 6. Does it matter what order you used filter() and arrange() if you’re using both? Why/why not? Think about the results and how much work the functions would have to do.
in terms of work for the function, it would be better to filter before arranging, as there would be fewer records to arrange; the end result, however, should be the same either way

## 3.3.5 Exercises

##### 1. Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?
dep_delay = dep_time - sched_dep_time

##### 2. Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.
```
flights |>
  select(dep_time, dep_delay, arr_time, arr_delay)
flights |>
  select(starts_with("arr"), starts_with("dep"))
```

##### 3. What happens if you specify the name of the same variable multiple times in a select() call?
the variable is called just as it would be if it had been called once

##### 4. What does the any_of() function do? Why might it be helpful in conjunction with this vector?
```
variables <- c("year", "month", "day", "dep_delay", "arr_delay")
```
selects all columns listed and does not return an error if one (or many) does not exist

##### 5. Does the result of running the following code surprise you? How do the select helpers deal with upper and lower case by default? How can you change that default?
```
flights |> select(contains("TIME"))
```
no; select is case-insensitive by default (ignore.case = TRUE), but to change that default you can set ignore.case = FALSE

##### 6. Rename air_time to air_time_min to indicate units of measurement and move it to the beginning of the data frame.
```
flights |> 
  mutate(air_time_min = air_time, .before = 1)
```

##### 7. Why doesn’t the following work, and what does the error mean?
```
flights |> 
  select(tailnum) |> 
  arrange(arr_delay)
#> Error in `arrange()`:
#> ℹ In argument: `..1 = arr_delay`.
#> Caused by error:
#> ! object 'arr_delay' not found
```
you cannot arrange by arr_delay because it does not exist in the selected subset of the table (which only includes the column tailnum); a modification of the statement can be found below:
```
flights |> 
  arrange(arr_delay) |>
    select(tailnum)
```

## 3.5.7 Exercises

##### 1. Which carrier has the worst average delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why/why not? (Hint: think about flights |> group_by(carrier, dest) |> summarize(n()))
```
flights |>
  group_by(carrier) |>
  summarize(arr_delay = mean(arr_delay, na.rm = TRUE), n= n()) |>
  arrange(desc(arr_delay))
```
F9 has the worst average delays
```
flights |>
  group_by(carrier, dest) |>
  summarize(arr_delay = mean(arr_delay, na.rm = TRUE), n= n()) |>
  arrange(desc(arr_delay))
```
no clear pattern of bad airports

##### 2. Find the flights that are most delayed upon departure from each destination.
```
flights |>
  group_by(dest) |>
  arrange(desc(dep_delay)) |>
  relocate(dest, dep_delay)
```

##### 3. How do delays vary over the course of the day? Illustrate your answer with a plot.
```
flights |>
  ggplot(aes(x = dep_time, y=dep_delay)) +
  geom_smooth()
```
delays are greatest at the earliest and latest in the day

##### 4. What happens if you supply a negative n to slice_min() and friends?
it should wrap around and give the last value n can assume

##### 5. Explain what count() does in terms of the dplyr verbs you just learned. What does the sort argument to count() do?
counts observations in a group; the sort argument puts the most frequent observations at the top

##### 6. Suppose we have the following tiny data frame:
```
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)
```

##### a. Write down what you think the output will look like, then check if you were correct, and describe what group_by() does.
```
df |>
  group_by(y)
```
provides information about the groups that exist (Groups: y[2])

##### b. Write down what you think the output will look like, then check if you were correct, and describe what arrange() does. Also, comment on how it’s different from the group_by() in part (a).
```
df |>
  arrange(y)
```
arrange() sorts observations by group; group_by() does not rearrange values

##### c. Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does.
```
df |>
  group_by(y) |>
  summarize(mean_x = mean(x))
```
gives the mean of x for each y

##### d. Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does. Then, comment on what the message says.
```
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))
```
gives the mean of x for each unique (y,z) pair

##### e. Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does. How is the output different from the one in part (d)?
```
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")
```
the output does not give the groups (Groups: y[2])

##### f. Write down what you think the outputs will look like, then check if you were correct, and describe what each pipeline does. How are the outputs of the two pipelines different?
```
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))
```
gives the mean of x for each unique (y,z) pair
```
df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))
```
gives the mean of x for each (y,z) and does not drop duplicate observations
