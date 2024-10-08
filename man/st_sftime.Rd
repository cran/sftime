% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sftime.R
\name{st_sftime}
\alias{st_sftime}
\alias{[.sftime}
\alias{[[<-.sftime}
\alias{$<-.sftime}
\title{Construct an \code{sftime} object from all its components}
\usage{
st_sftime(
  ...,
  agr = sf::NA_agr_,
  row.names,
  stringsAsFactors = TRUE,
  crs,
  precision,
  sf_column_name = NULL,
  time_column_name = NULL,
  check_ring_dir = FALSE,
  sfc_last = TRUE,
  time_column_last = TRUE
)

\method{[}{sftime}(x, i, j, ..., drop = FALSE, op = sf::st_intersects)

\method{[[}{sftime}(x, i) <- value

\method{$}{sftime}(x, i) <- value
}
\arguments{
\item{...}{Column elements to be binded into an \code{sftime} object or a 
single \code{list} or \code{data.frame} with such columns. At least one of 
these columns shall be a geometry list-column of class \code{sfc} and one 
shall be a time column (to be specified with \code{time_column_name}).}

\item{agr}{A character vector; see details below.}

\item{row.names}{row.names for the created \code{sf} object.}

\item{stringsAsFactors}{A logical value; see 
\code{\link[sf]{st_read}}.}

\item{crs}{Coordinate reference system, something suitable as input to 
\code{\link[sf]{st_crs}}.}

\item{precision}{A numeric value; see 
\code{\link[sf]{st_as_binary}}.}

\item{sf_column_name}{A character value; name of the active list-column with 
simple feature geometries; in case there is more than one and 
\code{sf_column_name} is \code{NULL}, the first one is taken.}

\item{time_column_name}{A character value; name of the active 
time column. In case \code{time_column_name} is \code{NULL}, the first 
\code{\link{POSIXct}} column is taken. If there is no \code{POSIXct} column,
the first \code{\link{Date}} column is taken.}

\item{check_ring_dir}{A logical value; see \code{\link[sf]{st_read}}.}

\item{sfc_last}{A logical value; if \code{TRUE}, \code{sfc} columns are 
always put last, otherwise column order is left unmodified.}

\item{time_column_last}{A logical value; if \code{TRUE}, the active time column is 
always put last, otherwise column order is left unmodified. If both \code{sfc_last}
and \code{time_column_last} are \code{TRUE}, the active time column is put last.}

\item{x}{An object of class \code{sf}.}

\item{i}{Record selection, see \link{[.data.frame}}

\item{j}{Variable selection, see \link{[.data.frame}}

\item{drop}{A logical value, default \code{FALSE}; if \code{TRUE} drop the 
geometry column and return a \code{data.frame}, else make the geometry sticky 
and return an \code{sf} object.}

\item{op}{A function; geometrical binary predicate function to apply when 
\code{i} is a simple feature object.}

\item{value}{An object to insert into \code{x} or with which to rename 
columns of \code{x}.}
}
\value{
\code{st_sftime}: An object of class \code{sftime}.

Returned objects for subsetting functions: \code{[.sf} will return a 
\code{data.frame} or vector if the geometry column (of class \code{sfc}) is 
dropped (\code{drop=TRUE}), an \code{sfc} object if only the geometry column 
is selected, and otherwise return an \code{sftime} object.
}
\description{
Construct an \code{sftime} object from all its components
}
\details{
See also \link{[.data.frame}; for \code{[.sftime} \code{...} 
arguments are passed to \code{op}.
}
\examples{
## construction with an sfc object
library(sf)
g <- st_sfc(st_point(1:2))
tc <- Sys.time()
st_sftime(a = 3, g, time = tc)

## construction with an sf object
\dontrun{
st_sftime(st_sf(a = 3, g), time = tc) 
# error, because if ... contains a data.frame-like object, no other objects 
# may be passed through ... . Instead, add the time column before.
}

st_sftime(st_sf(a = 3, g, time = tc))

## Subsetting
g <- st_sfc(st_point(c(1, 2)), st_point(c(1, 3)), st_point(c(2, 3)), 
     st_point(c(2, 1)), st_point(c(3, 1)))
tc <- Sys.time() + 1:5
x <- st_sftime(a = 1:5, g, time = tc)

# rows
x[1, ]
class(x[1, ])

x[x$a < 3, ]
class(x[x$a < 3, ])

# columns
x[, 1]
class(x[, 1]) # drops time column as for ordinary data.frame subsetting, 
# keeps geometry column of sf object

x[, 3]
class(x[, 3]) # keeps time column because it is explicitly selected,
# keeps geometry column of sf object, returns an sftime object

x[, 3, drop = TRUE] 
class(x[, 3, drop = TRUE]) # if the geometry column is dropped, not only the
# sf class is dropped, but also the sftime class

x["a"]
class(x["a"]) # Time columns are not sticky: If a column is selected by a 
# character vector and this does not contain the active time column, the time 
# column is dropped. 

x[c("a", "time")]
class(x[c("a", "time")]) # keeps the time column

# with sf or sftime object 
pol = st_sfc(st_polygon(list(cbind(c(0,2,2,0,0),c(0,0,2,2,0)))))
h = st_sf(r = 5, pol)

x[h, ] 
class(x[h, ]) # returns sftime object

h[x, ] 
class(h[x, ]) # returns sf object

## Assigning values to columns

# assigning new values to a non-time column
x[["a"]] <- 5:1
class(x)

# assigning allowed new values to the time column
x[["time"]] <- Sys.time() + 1:5
class(x)

# assigning new values to the time column which invalidate the time column
x[["time"]] <- list(letters[1:2])
class(x)

# assigning new values with `$`
x$time <- Sys.time() + 1:5
class(x)

}
