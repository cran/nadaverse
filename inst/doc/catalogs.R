## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(httptest2)
start_vignette("hosts")
set_redactor(function(x) {
  gsub_response(x, "index.php/api/catalog/", "")
})

## ----library------------------------------------------------------------------
library(nadaverse)

## ----info---------------------------------------------------------------------
codes <- c("wb", "fao", "ihsn", "kenya")
info <- lapply(codes, search_catalog, ps = 1, rows = FALSE)
names(info) <- codes
total <- function(x) if (is.null(x$total)) NA_real_ else as.numeric(x$total)
vapply(info, total, numeric(1))

## ----columns------------------------------------------------------------------
cols <- lapply(info, function(x) names(x$rows))
Reduce(intersect, cols)

## ----ihsn-collections---------------------------------------------------------
length(suppressWarnings(collections("ihsn")))

## ----agent--------------------------------------------------------------------
old <- set_user_agent("My research project (nadaverse)")
getOption("nadaverse.user_agent")
set_user_agent(old)
getOption("nadaverse.user_agent")

## ----teardown, include = FALSE------------------------------------------------
end_vignette()

