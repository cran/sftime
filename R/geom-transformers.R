#' Geometric operations on pairs of simple feature geometry sets (including \code{sftime} objects)
#'
#' @name geos_binary_ops
#' @param x object of class \code{sftime}, \code{sf}, \code{sfc} or \code{sfg}.
#' @param y object of class \code{sftime}, \code{sf}, \code{sfc} or \code{sfg}.
#' @param ... See \code{\link[sf:geos_binary_ops]{geos_binary_ops}}.
#' @return The intersection, difference or symmetric difference between two sets 
#' of geometries.
#' The returned object has the same class as that of the first argument 
#' (\code{x}) with the non-empty geometries resulting from applying the 
#' operation to all geometry pairs in \code{x} and \code{y}. In case \code{x} 
#' is of class \code{sf} or \code{sftime}, the matching attributes of the 
#' original object(s) are added. The \code{sfc} geometry list-column returned 
#' carries an attribute \code{idx}, which is an \code{n}-by-2 matrix with every 
#' row the index of the corresponding entries of \code{x} and \code{y}, 
#' respectively.
#' 
#' @examples 
#' g <- st_sfc(st_point(c(1, 2)), st_point(c(1, 3)), st_point(c(2, 3)), 
#'      st_point(c(2, 1)), st_point(c(3, 1)))
#' tc <- Sys.time() + 1:5
#' x1 <- st_sftime(a = 1:5, g, time = tc)
#' x2 <- st_buffer(x1, dist = 1)
#' 
NULL

#' Intersection
#' @name geos_binary_ops
#' @details \code{st_intersection}: When called with a missing \code{y}, the 
#' \code{sftime} method for \code{st_intersection} returns an \code{sftime} 
#' object with attributes taken from the contributing feature with lowest index; 
#' two fields are added: 
#' \describe{
#'   \item{\code{n.overlaps}}{The number of overlapping features in \code{x}.}
#'   \item{\code{origins}}{A list-column with indexes of all overlapping 
#'   features.}
#' }
#' 
#' @examples 
#' ## intersection
#' 
#' # only x provided (no y)
#' plot(st_intersection(x2))
#' 
#' # with arguments x and y provided
#' plot(st_intersection(x2, x1))
#' 
#' @export
st_intersection.sftime <- function(x, y, ...) {
  time_column_name <- attr(x, "time_column")
  reclass_sftime(NextMethod(), time_column_name = time_column_name)
}

#' Difference
#' @name geos_binary_ops
#' @details \code{st_difference}: When \code{st_difference} is called with a 
#' single argument, overlapping areas are erased from geometries that are 
#' indexed at greater numbers in the argument to \code{x}; geometries that are 
#' empty or contained fully inside geometries with higher priority are removed 
#' entirely.
#' 
#' @examples 
#' ## difference
#' 
#' # only x provided (no y)
#' plot(st_difference(x2))
#' 
#' # with arguments x and y provided
#' plot(st_difference(x2, x1))
#' 
#' @export
st_difference.sftime <- function(x, y, ...) {
  time_column_name <- attr(x, "time_column")
  reclass_sftime(NextMethod(), time_column_name = time_column_name)
}

#' @name geos_binary_ops
#' @examples 
#' ## symmetric difference
#' plot(st_sym_difference(x1, x2))
#' 
#' @export
st_sym_difference.sftime <- function(x, y, ...) {
  time_column_name <- attr(x, "time_column")
  reclass_sftime(NextMethod(), time_column_name = time_column_name)
}

#' Combine or union feature geometries (including \code{sftime} objects)
#' 
#' @name geos_combine
#' @param x An object of class \code{sftime}, \code{sf}, \code{sfc} or 
#' \code{sfg}.
#' @param y An object of class \code{sftime}, \code{sf}, \code{sfc} or 
#' \code{sfg} (optional).
#' @param by_feature See \code{\link[sf:geos_combine]{geos_combine}}.
#' @param is_coverage See \code{\link[sf:geos_combine]{geos_combine}}.
#' @param ... See \code{\link[sf:geos_combine]{geos_combine}}.
#' @return If \code{y} is missing, \code{st_union(x)} returns a single geometry 
#' with resolved boundaries, else the geometries for all unioned pairs of 
#' \code{x[i]} and \code{y[j]}.
#' @details
#' See \code{\link[sf:geos_combine]{geos_combine}}.
#' 
#' @examples 
#' # union simple features in an sftime object
#' g <- st_sfc(st_point(c(1, 2)), st_point(c(1, 3)), st_point(c(2, 3)), 
#'      st_point(c(2, 1)), st_point(c(3, 1)))
#' tc <- Sys.time() + 1:5
#' x <- st_sftime(a = 1:5, g, time = tc)
#' 
#' # only x provided (no y)
#' plot(st_union(st_buffer(x, dist = 1)))
#' 
#' # with arguments x and y provided
#' plot(st_union(st_buffer(x, dist = 1), st_buffer(x, dist = 0.5)), "a")
#' 
#' @export
st_union.sftime <- function(x, y, ..., by_feature = FALSE, is_coverage = FALSE) {
  time_column_name <- attr(x, "time_column")
  reclass_sftime(NextMethod(), time_column_name = time_column_name)
}





