#' Darwin Core Taxon terms
#'
#' A table of valid Darwin Core terms. Only terms in the Taxon class or at the
#' record-level are included.
#'
#' Modified from data downloaded from [TDWG Darwin Core](https://dwc.tdwg.org/)
#' under the [Creative Commons Attribution (CC BY)
#'  4.0](https://creativecommons.org/licenses/by/4.0/)
#' license.
#'
#' @format Dataframe (tibble), including two columns:
#' - `group`: Darwin Core term group; either "taxon" (terms in the Taxon class)
#' or "record-level" (terms that are generic in that they might apply
#' to any type of record in a dataset.)
#' - `term`: Darwin Core term
#'
#' with two additional attributes:
#' - `retrieved`: Date the terms were obtained
#' - `url`: URL from which the terms were obtained
#' @source \url{https://dwc.tdwg.org/terms/#taxon}
#' @examples
#' dct_terms
"dct_terms"

#' Taxonomic data of filmy ferns
#'
#' Taxonomic data of filmy ferns (family Hymenophyllaceae) in Darwin Core
#' format. Non-ASCII characters have been converted to ASCII, so some author
#' names may not be as expected. Meant for demonstration purposes only, not
#' formal data analysis.
#'
#' Modified from data downloaded from the [Catalog of
#' Life](https://www.catalogueoflife.org/) under the [Creative Commons
#' Attribution (CC BY) 4.0](https://creativecommons.org/licenses/by/4.0/)
#' license.
#'
#' @format Dataframe (tibble), with `r nrow(dct_filmies)` rows and
#' `r ncol(dct_filmies)` columns. For details about data format, see
#'   <https://dwc.tdwg.org/terms/#taxon>.
#'
#' @source \url{https://www.catalogueoflife.org/}
#' @examples
#' dct_filmies
"dct_filmies"
