#' Beals' smoothing
#'
#' Calculates Beals' smoothing for all species in a target plot, based on Mij matrix
#' @author Francesco Maria Sabatini
#' @author Helge Bruelheide
#' @param x.names vector of species names or labels
#' @param x.cover vector of species presence-absences
#' @param Mij matrix of pairwise likelihood of species co-occurrence (sparse matrices accepted)
#' @return A vector of Bray-Curtis dissimilarity between the target plot and all the other relevés in input.data
#' @references Ewald, J. (2002) Multiple controls of understorey plant richness in mountain forests of the Bavarian Alps. Phytocoenologia, 32, 85-100.
#' @export


beals.all <- function(x.names, x.cover, Mij){
  x.names.in.plot <- as.character(unique(x.names[x.cover>0]))
  sort.cols <- match(x.names.in.plot, as.character(dimnames(Mij)[[2]]))
  M2 <- as.matrix(Mij[,sort.cols])
  #M2 <- as.matrix(Mij[,dimnames(Mij)[[2]] %in% x.names.in.plot])
  # reduce the Mij matrix to those species that occur in the polygon
  if (is.matrix(M2)){
    return(rowSums(M2)/length(x.names.in.plot))
    # devision by Np, the number of species in the polygon
  } else {
    # necessary if Np=1 and the matrix collapses
    return(M2)
  }
}
