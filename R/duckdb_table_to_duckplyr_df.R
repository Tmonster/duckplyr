#' create a duckplyr df from a table in a duckdb connection
#'
#' The con object **MUST** be the default con for duckplyr
#' The DUCKPLYR_META_SKIP setting will be off for this to work
#'
#' @param table_name the name of the table in the duckdb database that will be referenced as a duckplyr df
#'
#' @return An object of class `"duckplyr_df"`
#'
table_to_duckplyr_df <- function(table_name) {
  # TODO: better comparison to make sure the connections are **Actually** the same.
  con <- get_default_duckdb_connection()
  rel <- duckdb:::rel_from_table(con, table_name) 
  altrep_rel <- duckdb:::rel_to_altrep(rel)
  altrep_df <- as_duckplyr_df(altrep_rel)
  altrep_df
}
