#' Downloads Book exercises from github
#'
#' This function downloads exercise files from github and unzips it to a chosen directory
#'
#' @param exercise.folder folder to copy exercise files
#'
#' @return TRUE, if sucessful
#' @export
#'
#' @examples
#'
#' \dontrun{
#' exercise.folder <- pmfdR_download.exercises()
#' }
#'
pmfdR_download.exercises <- function(exercise.folder = 'pmfdR-exercises') {

  # error checking

  if (!(dir.exists(exercise.folder))) {
    cat(paste('Directory', exercise.folder, 'does not exist. Creating it..'))
    dir.create(exercise.folder)
  }

  # check internet
  if (!curl::has_internet()) {
    stop('You need an active internet connection to run this function')
  }

  dl.link <- 'https://github.com/msperlin/pmfdR-exercises/archive/master.zip'

  my.tempfile <- tempfile()
  my.tempdir <- tempdir()

  utils::download.file(url = dl.link, destfile = my.tempfile)
  utils::unzip(my.tempfile, exdir = my.tempdir)

  files.to.copy <- list.files(paste0(my.tempdir,
                                     '\\',"pmfdR-exercises-master"),
                              full.names = TRUE)

  my.f.to.copy <- file.copy(from = files.to.copy ,
                            to = exercise.folder,overwrite = TRUE )


  cat('\nFiles available at', exercise.folder,'\n')

  return(TRUE)
}
