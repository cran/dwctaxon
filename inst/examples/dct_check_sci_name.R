dct_check_sci_name(
  data.frame(scientificName = NA_character_),
  on_fail = "summary", quiet = TRUE
)

dct_check_sci_name(data.frame(scientificName = "a"))
