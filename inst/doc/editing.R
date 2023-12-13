## ----include = FALSE----------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

# Increase width for printing tibbles
old <- options(width = 140)

## ----setup--------------------------------------------------------------------------------------------------------------------------------
library(dwctaxon)
library(tibble) # recommended for pretty-printing of tibbles

## ----filmy-data---------------------------------------------------------------------------------------------------------------------------
dct_filmies

## ----filmies-small------------------------------------------------------------------------------------------------------------------------
filmies_small <- head(dct_filmies, 5)

## ----add-row-simple-----------------------------------------------------------------------------------------------------------------------
filmies_small |>
  dct_add_row(
    scientificName = c("Homo sapiens", "Drosophila melanogaster"),
    taxonomicStatus = "accepted",
    taxonRank = "species"
  )

## ----dct-terms----------------------------------------------------------------------------------------------------------------------------
dct_terms

## ----add-row-from-df----------------------------------------------------------------------------------------------------------------------
# Let's add some rows from the original dct_filmies
to_add <- tail(dct_filmies)

filmies_small |>
  dct_add_row(new_dat = to_add)

## ----drop-row-----------------------------------------------------------------------------------------------------------------------------
filmies_small |>
  dct_drop_row(scientificName = "Cephalomanes atrovirens Presl")

filmies_small |>
  dct_drop_row(taxonID = "54115096")

## ----modify-1-----------------------------------------------------------------------------------------------------------------------------
# Change the status of Trichomanes crassum Copel. to "accepted"
filmies_small |>
  dct_modify_row(
    taxonID = "54133783", # taxonID of Trichomanes crassum Copel.
    taxonomicStatus = "accepted"
  )

## ----modify-2-----------------------------------------------------------------------------------------------------------------------------
# Change the status of Trichomanes crassum Copel. to "accepted"
filmies_small |>
  dct_modify_row(
    scientificName = "Trichomanes crassum Copel.",
    taxonomicStatus = "accepted"
  )

## ----modify-3-----------------------------------------------------------------------------------------------------------------------------
# Change the name of Trichomanes crassum Copel.
filmies_small |>
  dct_modify_row(
    taxonID = "54133783", # taxonID of Trichomanes crassum Copel.
    scientificName = "Bogus name"
  )

## ----modify-4-----------------------------------------------------------------------------------------------------------------------------
# Change C. densinervium to a synonym of C. crassum
filmies_small |>
  dct_modify_row(
    scientificName = "Cephalomanes densinervium (Copel.) Copel.",
    taxonomicStatus = "synonym",
    acceptedNameUsage = "Cephalomanes crassum (Copel.) M. G. Price"
  )

## ----fill-col-1---------------------------------------------------------------------------------------------------------------------------
# Fill-in the acceptedNameUsage column with scientific names
filmies_small |>
  dct_fill_col(
    fill_to = "acceptedNameUsage",
    fill_from = "scientificName",
    match_to = "taxonID",
    match_from = "acceptedNameUsageID"
  )

## ----include = FALSE----------------------------------------------------------
# Reset options
options(old)

