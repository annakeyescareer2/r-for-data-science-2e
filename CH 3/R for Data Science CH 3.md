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
