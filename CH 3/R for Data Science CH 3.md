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
dep_time = sched_dep_time + dep_delay
dep_delay = dep_time - sched_dep_time
arr_time = sched_arr_time + arr_delay
arr_delay = arr_time - sched_arr_time

##### 3. What happens if you specify the name of the same variable multiple times in a select() call?
the variable is called just as it would be if it had been called once

##### 4. What does the any_of() function do? Why might it be helpful in conjunction with this vector?
```
variables <- c("year", "month", "day", "dep_delay", "arr_delay")
```

##### 5. Does the result of running the following code surprise you? How do the select helpers deal with upper and lower case by default? How can you change that default?
```
flights |> select(contains("TIME"))
```

##### 6. Rename air_time to air_time_min to indicate units of measurement and move it to the beginning of the data frame.

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
