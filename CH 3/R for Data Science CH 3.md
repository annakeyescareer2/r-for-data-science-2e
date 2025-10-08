# R FOR DATA SCIENCE 2E - CHAPTER 3

## 3.2.5 Exercises

##### In a single pipeline for each condition, find all flights that meet the condition:
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
```
