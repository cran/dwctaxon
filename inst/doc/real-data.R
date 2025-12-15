## ----include = FALSE----------------------------------------------------------------------------------------------------------------------
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

## ----download-setup-----------------------------------------------------------------------------------------------------------------------
# - Specify temporary folder for downloading data
temp_dir <- tempdir()
# - Set name of zip file
temp_zip <- paste0(temp_dir, "/dwca-vascan.zip")
# - Set name of unzipped folder
temp_unzip <- paste0(temp_dir, "/dwca-vascan")

## ----get-vascan-url-----------------------------------------------------------------------------------------------------------------------
source(system.file("extdata", "vascan_url.R", package = "dwctaxon"))

# Check that we now have the URL loaded:
vascan_url

## ----echo = FALSE, results = "asis"-------------------------------------------------------------------------------------------------------
# Check if file can be downloaded safely, quit early if not
if (!dwctaxon:::safe_to_download(vascan_url)) {
  cat(
    paste0(
      "Vignette rendering stopped. The zip file (",
      vascan_url,
      ") could not be downloaded. Check your internet connection and the URL."
    )
  )
  knitr::knit_exit()
}

## ----download-unzip-hide, include = FALSE-------------------------------------------------------------------------------------------------
# Download and unzip data
download_success <- dwctaxon:::safe_download_unzip(
  url = vascan_url,
  destfile = temp_zip,
  exdir = temp_unzip
)

# Check if download or unzip failed
if (!download_success) {
  message("Zip file could not be loaded. Stopping vignette rendering.")
  knitr::knit_exit()
}

## ----download-unzip-show, eval = FALSE----------------------------------------------------------------------------------------------------
# # Download data
# download.file(url = vascan_url, destfile = temp_zip, mode = "wb")
# 
# # Unzip
# unzip(temp_zip, exdir = temp_unzip)

## ----list-zip-contents--------------------------------------------------------------------------------------------------------------------
list.files(temp_unzip)

## ----load-data----------------------------------------------------------------------------------------------------------------------------
vascan <- read_tsv(paste0(temp_unzip, "/taxon.txt"))

# Take a peak at the data
vascan

## ----validation, error = TRUE-------------------------------------------------------------------------------------------------------------
try({
dct_validate(vascan)
})

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

## ----include = FALSE----------------------------------------------------------
# Reset options
options(old)

