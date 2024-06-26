# extra arguments in ... error (#5891)

    Code
      duckplyr_intersect(df1, df2, z = 3)
    Condition
      Error in `intersect()`:
      ! `...` must be empty.
      x Problematic argument:
      * z = 3
    Code
      duckplyr_union(df1, df2, z = 3)
    Condition
      Error in `union()`:
      ! `...` must be empty.
      x Problematic argument:
      * z = 3
    Code
      duckplyr_union_all(df1, df2, z = 3)
    Condition
      Error in `union_all()`:
      ! `...` must be empty.
      x Problematic argument:
      * z = 3
    Code
      duckplyr_setdiff(df1, df2, z = 3)
    Condition
      Error in `setdiff()`:
      ! `...` must be empty.
      x Problematic argument:
      * z = 3
    Code
      duckplyr_symdiff(df1, df2, z = 3)
    Condition
      Error in `symdiff()`:
      ! `...` must be empty.
      x Problematic argument:
      * z = 3

# incompatible data frames error (#903)

    Code
      duckplyr_intersect(df1, df2)
    Condition
      Error in `intersect()`:
      ! `x` and `y` are not compatible.
      x Different number of columns: 1 vs 2.
    Code
      duckplyr_union(df1, df2)
    Condition
      Error in `union_all()`:
      ! `x` and `y` are not compatible.
      x Different number of columns: 1 vs 2.
    Code
      duckplyr_union_all(df1, df2)
    Condition
      Error in `union_all()`:
      ! `x` and `y` are not compatible.
      x Different number of columns: 1 vs 2.
    Code
      duckplyr_setdiff(df1, df2)
    Condition
      Error in `setdiff()`:
      ! `x` and `y` are not compatible.
      x Different number of columns: 1 vs 2.
    Code
      duckplyr_symdiff(df1, df2)
    Condition
      Error in `symdiff()`:
      ! `x` and `y` are not compatible.
      x Different number of columns: 1 vs 2.

# is_compatible generates useful messages for different cases

    Code
      cat(is_compatible(tibble(x = 1), 1))
    Output
      `y` must be a data frame.
    Code
      cat(is_compatible(tibble(x = 1), tibble(x = 1, y = 2)))
    Output
      Different number of columns: 1 vs 2.
    Code
      cat(is_compatible(tibble(x = 1, y = 1), tibble(y = 1, x = 1), ignore_col_order = FALSE))
    Output
      Same column names, but different order.
    Code
      cat(is_compatible(tibble(x = 1), tibble(y = 1)))
    Output
      Cols in `y` but not `x`: `y`. Cols in `x` but not `y`: `x`.
    Code
      cat(is_compatible(tibble(x = 1), tibble(x = 1L), convert = FALSE))
    Output
      Different types for column `x`: double vs integer.
    Code
      cat(is_compatible(tibble(x = 1), tibble(x = "a")))
    Output
      Incompatible types for column `x`: double vs character.

# setequal tibbles must have same rows and columns

    Code
      duckplyr_setequal(tibble(x = 1:2), tibble(y = 1:2))
    Condition
      Error in `setequal()`:
      ! `x` and `y` are not compatible.
      x Cols in `y` but not `x`: `y`.
      x Cols in `x` but not `y`: `x`.

---

    Code
      duckplyr_setequal(tibble(x = 1:2), tibble(x = c("a", "b")))
    Condition
      Error in `setequal()`:
      ! `x` and `y` are not compatible.
      x Incompatible types for column `x`: integer vs character.

# setequal checks for extra arguments

    Code
      duckplyr_setequal(mtcars, mtcars, z = 2)
    Condition
      Error in `setequal()`:
      ! `...` must be empty.
      x Problematic argument:
      * z = 2

