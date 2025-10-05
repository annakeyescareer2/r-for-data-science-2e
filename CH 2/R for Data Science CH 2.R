# 2.1 CODING BASICS

1 / 200 * 30
#> [1] 0.15
(59 + 73 + 2) / 3
#> [1] 44.66667
sin(pi / 2)
#> [1] 1

x <- 3 * 4
# no output to console - available in environment
primes <- c(2, 3, 5, 7, 11, 13)
# no output to console - available in environment

primes * 2
#> [1]  4  6 10 14 22 26
primes - 1
#> [1]  1  2  4  6 10 12

# 2.2 COMMENTS

# create vector of primes
primes <- c(2, 3, 5, 7, 11, 13)
# multiply primes by 2
primes * 2
#> [1]  4  6 10 14 22 26

# 2.3 WHAT'S IN A NAME

#snake_case recommended
i_use_snake_case <- 1
#inspect object by typing name
x
#> [1] 12

#completion facility
this_is_a_really_long_name <- 2.5
this_is_a_really_long_name
#> [1] 2.5

r_rocks <- 2^3
r_rock
#> Error: object 'r_rock' not found
R_rocks
#> Error: object 'R_rocks' not found

# 2.4 CALLING FUNCTIONS

seq(from = 1, to = 10)
#>  [1]  1  2  3  4  5  6  7  8  9 10
seq(1, 10)
#>  [1]  1  2  3  4  5  6  7  8  9 10

x <- "hello world"