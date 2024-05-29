test_that("duckdb table to duckplyr df works", {
 
  prev_meta_skip_val <- Sys.getenv("DUCKPLYR_META_SKIP")
  Sys.setenv("DUCKPLYR_META_SKIP"=TRUE)

  drv <- duckdb::duckdb("")
  con <- DBI::dbConnect(drv)
  
  DBI::dbExecute(con, "create table foo as select range a from range(100)")
  duckplyr:::set_default_duckdb_connection(con)
  foo_df <- table_to_duckplyr_df("foo")

  expect_false(duckdb$df_is_materialized(foo_df))
  filtered <- foo_df %>% filter(a > 90)

  expect_false(duckdb$df_is_materialized(filtered))
  answer <- as_duckplyr_df(data.frame(a=c(91, 92, 93, 94, 95, 96, 97, 98, 99)))
  dim(filtered)
  expect_equal(
    answer,
    filtered
  )

  Sys.setenv("DUCKPLYR_META_SKIP"=prev_meta_skip_val)
})