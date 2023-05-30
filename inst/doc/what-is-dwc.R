## ---- include = FALSE-------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

# Increase width for printing tibbles
old <- options(width = 120)

## ----taxon-wide, echo = FALSE, message = FALSE------------------------------------------------------------------------
taxon_wide <- tibble::tribble(
  ~species, ~genus, ~family, ~order,
  "Crepidomanes minutum", "Crepidomanes", "Hymenophyllaceae", "Hymenophyllales"
)
knitr::kable(taxon_wide)

## ----taxon-long, echo = FALSE-----------------------------------------------------------------------------------------
tidyr::pivot_longer(
  taxon_wide,
  names_to = "taxonRank",
  values_to = "scientificName",
  everything()
) |>
  knitr::kable()

## ----taxon-long-wide, echo = FALSE------------------------------------------------------------------------------------
tidyr::pivot_longer(
  taxon_wide,
  names_to = "taxonRank",
  values_to = "scientificName",
  dplyr::everything()
) |>
  dplyr::mutate(genus = dplyr::case_when(
    stringr::str_detect(scientificName, "Crepidomanes") ~ "Crepidomanes",
    TRUE ~ NA_character_
  )) |>
  dplyr::mutate(family = dplyr::case_when(
    stringr::str_detect(
      scientificName, "Crepidomanes|Hymenophyllaceae"
    ) ~ "Hymenophyllaceae",
    TRUE ~ NA_character_
  )) |>
  dplyr::mutate(order = dplyr::case_when(
    stringr::str_detect(
      scientificName, "Crepidomanes|Hymenophyll"
    ) ~ "Hymenophyllales",
    TRUE ~ NA_character_
  )) |>
  knitr::kable()

## ----filmies----------------------------------------------------------------------------------------------------------
library(dwctaxon)
head(dct_filmies)

## ----count-terms, echo = FALSE----------------------------------------------------------------------------------------
n_taxon_terms <-
  dct_terms$term[dct_terms$group == "taxon"] |>
  unique() |>
  length()

## ---- include = FALSE---------------------------------------------------------
# Reset options
options(old)

