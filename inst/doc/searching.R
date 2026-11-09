## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(httptest2)
start_vignette("search")
set_redactor(function(x) {
  gsub_response(x, "index.php/api/catalog/", "")
})

## ----library------------------------------------------------------------------
library(nadaverse)

## ----brief--------------------------------------------------------------------
brief <- function(x) head(x[, c("idno", "nation", "year_start")], 5)

## ----keyword------------------------------------------------------------------
res <- search_catalog("wb", keyword = "poverty", ps = 5)
brief(res)

## ----years--------------------------------------------------------------------
res <- search_catalog("wb", from = 2015, to = 2020, ps = 5)
brief(res)

## ----country------------------------------------------------------------------
res <- search_catalog("wb", country = c("ETH", "UGA"), ps = 5)
brief(res)

## ----collections--------------------------------------------------------------
cl <- collections("wb")
head(cl[, c("repositoryid", "title")], 5)

## ----collection---------------------------------------------------------------
res <- search_catalog("wb", collection = "LSMS", ps = 5)
brief(res)

## ----access-------------------------------------------------------------------
access <- access_codes("wb")
head(access[, c("type", "title")], 5)

## ----dtype--------------------------------------------------------------------
res <- search_catalog("wb", dtype = access$type[1], ps = 5)
brief(res)

## ----sort---------------------------------------------------------------------
res <- search_catalog(
  "wb",
  country = "ETH",
  sort_by = "year",
  sort_order = "desc",
  ps = 5
)
brief(res)

## ----page---------------------------------------------------------------------
res2 <- search_catalog(
  "wb",
  country = "ETH",
  sort_by = "year",
  sort_order = "desc",
  ps = 5,
  page = 2
)
brief(res2)

## ----created, eval = FALSE----------------------------------------------------
# search_catalog("wb", created = "2023/01/01-2023/12/31")

## ----info---------------------------------------------------------------------
info <- search_catalog("wb", keyword = "poverty", ps = 5, rows = FALSE)
info$found
info$total
names(info)

## ----iso----------------------------------------------------------------------
res <- search_catalog("wb", country = "ETH", inc_iso = TRUE, ps = 5)
names(res)

## ----none---------------------------------------------------------------------
none <- suppressWarnings(search_catalog("fao", keyword = "novalidsk"))
is.null(none)

## ----compare------------------------------------------------------------------
codes <- c("wb", "fao", "ihsn")
found <- vapply(
  codes,
  function(code) {
    info <- suppressWarnings(
      search_catalog(code, keyword = "household", ps = 1, rows = FALSE)
    )
    if (is.null(info)) 0 else as.numeric(info$found)
  },
  numeric(1)
)
found

## ----teardown, include = FALSE------------------------------------------------
end_vignette()

