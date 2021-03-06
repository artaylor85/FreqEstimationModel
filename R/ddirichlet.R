#'@title Dirichlet density
#'@description Calculate the density of the dirichlet distribution. This function is exactly the same as that from MCMCpack, copied to minimise dependencies.
#'@name ddirichlet
#'@export
ddirichlet <- function (x, alpha)
{
  dirichlet1 <- function(x, alpha) {
    logD <- sum(lgamma(alpha)) - lgamma(sum(alpha))
    s <- sum((alpha - 1) * log(x))
    exp(sum(s) - logD)
  }
  if (!is.matrix(x))
    if (is.data.frame(x))
      x <- as.matrix(x)
    else x <- t(x)
    if (!is.matrix(alpha))
      alpha <- matrix(alpha, ncol = length(alpha), nrow = nrow(x),
                      byrow = TRUE)
    if (any(dim(x) != dim(alpha)))
      stop("Mismatch between dimensions of x and alpha in ddirichlet().\n")
    pd <- vector(length = nrow(x))
    for (i in 1:nrow(x)) pd[i] <- dirichlet1(x[i, ], alpha[i,
                                                           ])
    pd[apply(x, 1, function(z) any(z < 0 | z > 1))] <- 0
    pd[apply(x, 1, function(z) all.equal(sum(z), 1) != TRUE)] <- 0
    return(pd)
}


