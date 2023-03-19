load("tools/tpch/001.rda")
con <- DBI::dbConnect(duckdb::duckdb())
invisible(DBI::dbExecute(con, "CREATE MACRO \"<\"(a, b) AS a < b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"<=\"(a, b) AS a <= b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \">\"(a, b) AS a > b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \">=\"(a, b) AS a >= b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"==\"(a, b) AS a = b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"!=\"(a, b) AS a <> b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"is.na\"(a) AS (a IS NULL)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"n\"() AS (COUNT(*))"))
invisible(
  DBI::dbExecute(con, "CREATE MACRO \"sum\"(x) AS (CASE WHEN SUM(x) IS NULL THEN 0 ELSE SUM(x) END)")
)
invisible(DBI::dbExecute(con, "CREATE MACRO \"log10\"(x) AS log(x)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"log\"(x) AS ln(x)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"as.Date\"(x) AS strptime(x, '%Y-%m-%d')"))
invisible(
  DBI::dbExecute(con, "CREATE MACRO \"grepl\"(pattern, x) AS regexp_matches(x, pattern)")
)
invisible(DBI::dbExecute(con, "CREATE MACRO \"as.integer\"(x) AS CAST(x AS int32)"))
invisible(
  DBI::dbExecute(
    con,
    "CREATE MACRO \"ifelse\"(test, yes, no) AS (CASE WHEN test THEN yes ELSE no END)"
  )
)
invisible(DBI::dbExecute(con, "CREATE MACRO \"|\"(x, y) AS (x OR y)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"&\"(x, y) AS (x AND y)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"!\"(x) AS (NOT x)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"any\"(x) AS (bool_or(x))"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"desc\"(x) AS (-x)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"n_distinct\"(x) AS (COUNT(DISTINCT x))"))
invisible(
  DBI::dbExecute(
    con,
    "CREATE MACRO \"___eq_na_matches_na\"(a, b) AS ((a IS NULL AND b IS NULL) OR (a = b))"
  )
)
invisible(DBI::dbExecute(con, "CREATE MACRO \"___coalesce\"(a, b) AS COALESCE(a, b)"))
df1 <- nation
rel1 <- duckdb:::rel_from_df(con, df1)
rel2 <- duckdb:::rel_filter(
  rel1,
  list(
    duckdb:::expr_function("==", list(duckdb:::expr_reference("n_name"), duckdb:::expr_constant("CANADA")))
  )
)
df2 <- supplier
rel3 <- duckdb:::rel_from_df(con, df2)
rel4 <- duckdb:::rel_set_alias(rel3, "lhs")
rel5 <- duckdb:::rel_set_alias(rel2, "rhs")
rel6 <- duckdb:::rel_join(
  rel4,
  rel5,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("s_nationkey", rel4), duckdb:::expr_reference("n_nationkey", rel5))
    )
  ),
  "inner"
)
rel7 <- duckdb:::rel_project(
  rel6,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("s_suppkey")
      duckdb:::expr_set_alias(tmp_expr, "s_suppkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_name")
      duckdb:::expr_set_alias(tmp_expr, "s_name")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_address")
      duckdb:::expr_set_alias(tmp_expr, "s_address")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_nationkey")
      duckdb:::expr_set_alias(tmp_expr, "s_nationkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_phone")
      duckdb:::expr_set_alias(tmp_expr, "s_phone")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_acctbal")
      duckdb:::expr_set_alias(tmp_expr, "s_acctbal")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_comment")
      duckdb:::expr_set_alias(tmp_expr, "s_comment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("n_name")
      duckdb:::expr_set_alias(tmp_expr, "n_name")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("n_regionkey")
      duckdb:::expr_set_alias(tmp_expr, "n_regionkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("n_comment")
      duckdb:::expr_set_alias(tmp_expr, "n_comment")
      tmp_expr
    }
  )
)
rel8 <- duckdb:::rel_project(
  rel7,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("s_suppkey")
      duckdb:::expr_set_alias(tmp_expr, "s_suppkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_name")
      duckdb:::expr_set_alias(tmp_expr, "s_name")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_address")
      duckdb:::expr_set_alias(tmp_expr, "s_address")
      tmp_expr
    }
  )
)
df3 <- part
rel9 <- duckdb:::rel_from_df(con, df3)
rel10 <- duckdb:::rel_filter(
  rel9,
  list(
    duckdb:::expr_function("grepl", list(duckdb:::expr_constant("^forest"), duckdb:::expr_reference("p_name")))
  )
)
df4 <- partsupp
rel11 <- duckdb:::rel_from_df(con, df4)
rel12 <- duckdb:::rel_set_alias(rel11, "lhs")
rel13 <- duckdb:::rel_set_alias(rel8, "rhs")
rel14 <- duckdb:::rel_join(
  rel12,
  rel13,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("ps_suppkey", rel12), duckdb:::expr_reference("s_suppkey", rel13))
    )
  ),
  "semi"
)
rel15 <- duckdb:::rel_set_alias(rel14, "lhs")
rel16 <- duckdb:::rel_set_alias(rel10, "rhs")
rel17 <- duckdb:::rel_join(
  rel15,
  rel16,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("ps_partkey", rel15), duckdb:::expr_reference("p_partkey", rel16))
    )
  ),
  "semi"
)
df5 <- lineitem
rel18 <- duckdb:::rel_from_df(con, df5)
rel19 <- duckdb:::rel_filter(
  rel18,
  list(
    duckdb:::expr_function(
      ">=",
      list(duckdb:::expr_reference("l_shipdate"), duckdb:::expr_function("as.Date", list(duckdb:::expr_constant("1994-01-01"))))
    ),
    duckdb:::expr_function(
      "<",
      list(duckdb:::expr_reference("l_shipdate"), duckdb:::expr_function("as.Date", list(duckdb:::expr_constant("1995-01-01"))))
    )
  )
)
rel20 <- duckdb:::rel_set_alias(rel19, "lhs")
rel21 <- duckdb:::rel_set_alias(rel17, "rhs")
rel22 <- duckdb:::rel_join(
  rel20,
  rel21,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("l_partkey", rel20), duckdb:::expr_reference("ps_partkey", rel21))
    ),
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("l_suppkey", rel20), duckdb:::expr_reference("ps_suppkey", rel21))
    )
  ),
  "semi"
)
rel23 <- duckdb:::rel_aggregate(
  rel22,
  list(duckdb:::expr_reference("l_suppkey")),
  list(
    qty_threshold = {
      tmp_expr <- duckdb:::expr_function(
        "*",
        list(duckdb:::expr_constant(0.5), duckdb:::expr_function("sum", list(duckdb:::expr_reference("l_quantity"))))
      )
      duckdb:::expr_set_alias(tmp_expr, "qty_threshold")
      tmp_expr
    }
  )
)
rel24 <- duckdb:::rel_set_alias(rel17, "lhs")
rel25 <- duckdb:::rel_set_alias(rel23, "rhs")
rel26 <- duckdb:::rel_join(
  rel24,
  rel25,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("ps_suppkey", rel24), duckdb:::expr_reference("l_suppkey", rel25))
    )
  ),
  "inner"
)
rel27 <- duckdb:::rel_project(
  rel26,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("ps_partkey")
      duckdb:::expr_set_alias(tmp_expr, "ps_partkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("ps_suppkey")
      duckdb:::expr_set_alias(tmp_expr, "ps_suppkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("ps_availqty")
      duckdb:::expr_set_alias(tmp_expr, "ps_availqty")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("ps_supplycost")
      duckdb:::expr_set_alias(tmp_expr, "ps_supplycost")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("ps_comment")
      duckdb:::expr_set_alias(tmp_expr, "ps_comment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("qty_threshold")
      duckdb:::expr_set_alias(tmp_expr, "qty_threshold")
      tmp_expr
    }
  )
)
rel28 <- duckdb:::rel_filter(
  rel27,
  list(
    duckdb:::expr_function(
      ">",
      list(duckdb:::expr_reference("ps_availqty"), duckdb:::expr_reference("qty_threshold"))
    )
  )
)
rel29 <- duckdb:::rel_set_alias(rel8, "lhs")
rel30 <- duckdb:::rel_set_alias(rel28, "rhs")
rel31 <- duckdb:::rel_join(
  rel29,
  rel30,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("s_suppkey", rel29), duckdb:::expr_reference("ps_suppkey", rel30))
    )
  ),
  "semi"
)
rel32 <- duckdb:::rel_project(
  rel31,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("s_name")
      duckdb:::expr_set_alias(tmp_expr, "s_name")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_address")
      duckdb:::expr_set_alias(tmp_expr, "s_address")
      tmp_expr
    }
  )
)
rel33 <- duckdb:::rel_order(rel32, list(duckdb:::expr_reference("s_name")))
rel33
duckdb:::rel_to_altrep(rel33)