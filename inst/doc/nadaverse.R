## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(httptest2)
start_vignette("start")
set_redactor(function(x) {
  gsub_response(x, "index.php/api/catalog/", "")
})

## ----library------------------------------------------------------------------
library(nadaverse)

## ----catalogs-----------------------------------------------------------------
cats <- catalogs(show = FALSE)
cats[, c("catalog", "name")]

## ----search-------------------------------------------------------------------
res <- search_catalog(
  "wb",
  keyword = "Ethiopia Socioeconomic Survey",
  ps = 5
)
head(res[, c("idno", "nation", "year_start")], 5)

## ----metadata-----------------------------------------------------------------
study <- "ETH_2015_ESS_v03_M"
md <- metadata("wb", study)
names(md)

## ----study-desc---------------------------------------------------------------
names(md$study_desc)

## ----files--------------------------------------------------------------------
files <- data_files("wb", study)
head(files[, c("file_id", "file_name", "case_count")], 5)

## ----dictionary---------------------------------------------------------------
dict <- data_dictionary("wb", study)
head(dict[, c("vid", "name", "labl")], 5)

## ----dictionary-file, eval = FALSE--------------------------------------------
# data_dictionary("wb", study, file_id = files$file_id[[1]])

## ----fao----------------------------------------------------------------------
fao <- search_catalog("fao", keyword = "food insecurity", ps = 5)
head(fao[, c("idno", "nation", "year_start")], 5)

## ----teardown, include = FALSE------------------------------------------------
end_vignette()

