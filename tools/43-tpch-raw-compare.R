pkgload::load_all()

load("tools/tpch/001.rda")
answer <- "tpch-sf0.01"

# load("tools/tpch/100.rda")
# answer <- "tpch-sf1"

con <- get_default_duckdb_connection()
experimental <- FALSE

res <- tpch_raw_01(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q01.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_02(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q02.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_03(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q03.csv"), sep = "|")
correct$o_orderdate <- as.Date(correct$o_orderdate)
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_04(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q04.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_05(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q05.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_06(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q06.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_07(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q07.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_08(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q08.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_09(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q09.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_10(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q10.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_11(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q11.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_12(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q12.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_13(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q13.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_14(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q14.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_15(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q15.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_16(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q16.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_17(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q17.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_18(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q18.csv"), sep = "|")
correct$o_orderdate <- as.Date(correct$o_orderdate)
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_19(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q19.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_20(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q20.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_21(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q21.csv"), sep = "|")
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))

res <- tpch_raw_22(experimental)
correct <- read.delim(fs::path("tests/testthat", answer, "q22.csv"), sep = "|")
correct$cntrycode <- as.character(correct$cntrycode)
stopifnot(isTRUE(all.equal(res, correct, tolerance = 1e-12)))