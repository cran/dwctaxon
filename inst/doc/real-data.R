## ---- include = FALSE---------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

# Increase width for printing tibbles
old <- options(width = 140)

## ----setup, message = FALSE---------------------------------------------------------------------------------------------------------------
library(dwctaxon)
library(readr)
library(tibble)
library(dplyr)

## ----download-unzip-----------------------------------------------------------------------------------------------------------------------
# Set up folders:
# - Specify temporary folder for downloading data
temp_dir <- tempdir()
# - Set name of zip file
temp_zip <- paste0(temp_dir, "/dwca-vascan.zip")
# - Set name of unzipped folder
temp_unzip <- paste0(temp_dir, "/dwca-vascan")

# Download data
download.file(
  url = "https://data.canadensys.net/ipt/archive.do?r=vascan&v=37.12",
  destfile = temp_zip, mode = "wb"
)

# Unzip
unzip(temp_zip, exdir = temp_unzip)

# Check the contents of the unzipped data (the Darwin Core Archive)
list.files(temp_unzip)

## ----load-data----------------------------------------------------------------------------------------------------------------------------
vascan <- read_tsv(paste0(temp_unzip, "/taxon.txt"))

# OK to delete the tempo

# Take a peak at the data
vascan

## ----validation, error = TRUE-------------------------------------------------------------------------------------------------------------
dct_validate(vascan)

## ----validation-summary-------------------------------------------------------------------------------------------------------------------
validation_res <- dct_validate(vascan, on_fail = "summary")

validation_res

## ----summary-analysis---------------------------------------------------------------------------------------------------------------------
validation_res %>%
  count(check, error)

## ----summary-analysis-hide, show = FALSE, echo = FALSE------------------------------------------------------------------------------------
validation_res_sum <-
  validation_res %>%
  count(check, error)

n_error_types <- nrow(validation_res_sum) %>%
  english::english()

n_bad_cols <- validation_res_sum %>%
  filter(error == "Invalid column names detected: id") %>%
  pull(n) %>%
  english::english()

n_bad_sci_name <- validation_res_sum %>%
  filter(error == "scientificName detected with duplicated value") %>%
  pull(n)

## ----check-sci-name-dups------------------------------------------------------------------------------------------------------------------
dup_names <-
  validation_res %>%
  filter(grepl("scientificName detected with duplicated value", error)) %>%
  arrange(scientificName)

dup_names

## ----check-sci-name-dups-orig-------------------------------------------------------------------------------------------------------------
inner_join(
  select(dup_names, taxonID),
  vascan,
  by = "taxonID"
) %>%
  # Just look at the first 6 columns
  select(1:6)

## ----inspect-id---------------------------------------------------------------------------------------------------------------------------
vascan %>%
  select(id)

n_distinct(vascan$id)

## ----fix-data-----------------------------------------------------------------------------------------------------------------------------
vascan_fixed <-
  vascan %>%
  filter(!duplicated(scientificName))

## ----validation-2-------------------------------------------------------------------------------------------------------------------------
dct_validate(
  vascan_fixed,
  extra_cols = "id"
)

## ---- include = FALSE---------------------------------------------------------
# Reset options
options(old)

