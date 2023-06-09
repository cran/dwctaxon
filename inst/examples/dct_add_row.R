tibble::tibble(
  taxonID = "123",
  scientificName = "Foogenus barspecies",
  acceptedNameUsageID = NA_character_,
  taxonomicStatus = "accepted"
) |>
  dct_add_row(
    scientificName = "Foogenus barspecies var. bla",
    parentNameUsageID = "123",
    nameAccordingTo = "me",
    strict = TRUE
  )
