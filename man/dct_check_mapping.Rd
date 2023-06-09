% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dct_check_mapping.R
\name{dct_check_mapping}
\alias{dct_check_mapping}
\title{Check mapping of usage taxonomic IDs}
\usage{
dct_check_mapping(
  tax_dat,
  on_fail = dct_options()$on_fail,
  on_success = dct_options()$on_success,
  col_select = "acceptedNameUsageID",
  quiet = dct_options()$quiet
)
}
\arguments{
\item{tax_dat}{Dataframe; taxonomic database in DwC format.}

\item{on_fail}{Character vector of length 1, either "error" or "summary". Describes what to do if the check fails. Default \code{"error"}.}

\item{on_success}{Character vector of length 1, either "logical" or "data". Describes what to do if the check passes. Default \code{"data"}.}

\item{col_select}{Character vector of length 1; the name of the column
(DwC term) to check. Default \code{"acceptedNameUsageID"}.}

\item{quiet}{Logical vector of length 1; should warnings be silenced? Default \code{FALSE}.}
}
\value{
Depends on the result of the check and on values of \code{on_fail} and
\code{on_success}:
\itemize{
\item If the check passes and \code{on_success} is "logical", return \code{TRUE}
\item If the check passes and \code{on_success} is "data", return the input dataframe
\item If the check fails and \code{on_fail} is "error", return an error
\item If the check fails and \code{on_fail} is "summary", issue a warning and
return a dataframe with a summary of the reasons for failure
}
}
\description{
Check that values of terms like 'acceptedUsageID' map properly to taxonID in
Darwin Core (DwC) taxonomic data.
}
\details{
The following rules are enforced:
\itemize{
\item Value of taxonID may not be identical to that of the selected column within
a single row (in other words, a name cannot be its own accepted name,
parent taxon, or basionym).
\item Every value in the selected column must have a corresponding taxonID.
}

\code{col_select} can take one of the following values:
\itemize{
\item \code{"acceptedNameUsageID"}: taxonID corresponding to the accepted name (of
a synonym).
\item \code{"parentNameUsageID"}: taxonID corresponding to the immediate parent taxon
of a name (for example, for a species, this would be the genus).
\item \code{"originalNameUsageID"}: taxonID corresponding to the basionym of a name.
}
}
\examples{
# The bad data has an acceptedNameUsageID (third row, "4") that lacks a
# corresponding taxonID
bad_dat <- tibble::tribble(
  ~taxonID, ~acceptedNameUsageID, ~taxonomicStatus, ~scientificName,
  "1", NA, "accepted", "Species foo",
  "2", "1", "synonym", "Species bar",
  "3", "4", "synonym", "Species bat"
)

dct_check_mapping(bad_dat, on_fail = "summary", quiet = TRUE)
}
