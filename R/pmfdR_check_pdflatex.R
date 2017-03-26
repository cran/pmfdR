#' Function to check if system has pdflatex.exe available
#'
#' @return TRUE if the pdflatex is available, FALSE if not
#' @examples
#' pmfdR_check.pdflatex()
#'
#' @export
pmfdR_check.pdflatex <- function(){

  flag <- FALSE

  try({system('pdflatex -version', intern = T)
    flag <- TRUE}, silent = T)


  return(flag)
}
