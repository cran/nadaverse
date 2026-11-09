## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(httptest2)
start_vignette("std")
set_redactor(function(x) {
  gsub_response(x, "index.php/api/catalog/", "")
})

## ----library------------------------------------------------------------------
library(nadaverse)

## ----ids----------------------------------------------------------------------
md_num <- metadata("wb", 8098)
md_txt <- metadata("wb", "ALB_2012_LSMS_v01_M_v01_A_PUF")
md_num$study_desc$title_statement$title
md_txt$study_desc$title_statement$title

## ----sections-----------------------------------------------------------------
names(md_txt)
names(md_txt$study_desc)

## ----title--------------------------------------------------------------------
str(md_txt$study_desc$title_statement)

## ----study-info---------------------------------------------------------------
names(md_txt$study_desc$study_info)

## ----files--------------------------------------------------------------------
study <- "ETH_2015_ESS_v03_M"
files <- data_files("wb", study)
nrow(files)

## ----files-tidy---------------------------------------------------------------
files_tidy <- data.frame(
  file_id = unlist(files$file_id),
  file_name = unlist(files$file_name),
  vars = as.numeric(unlist(files$var_count))
)
head(files_tidy, 5)

## ----dictionary---------------------------------------------------------------
dict <- data_dictionary("wb", study)
nrow(dict)
head(dict[, c("vid", "name", "labl")], 5)

## ----one-file-----------------------------------------------------------------
smallest <- files_tidy$file_id[which.min(files_tidy$vars)]
dict_file <- data_dictionary("wb", study, file_id = smallest)
nrow(dict_file)

## ----find---------------------------------------------------------------------
hits <- dict[grepl("household", dict$labl, ignore.case = TRUE), ]
head(hits[, c("vid", "name", "labl")], 5)

## ----teardown, include = FALSE------------------------------------------------
end_vignette()

