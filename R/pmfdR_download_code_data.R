#' Downloads code and data from the book
#'
#' Downloads a zip file from the github repository and unzip it to a folder within
#' the working directory
#'
#' @param lan Language of book/files ('en' or 'pt-br')
#'
#' @return TRUE, if successful
#' @export
#' @examples
#'
#' \dontrun{
#' pmfdR_download.code.and.data()
#' }
pmfdR_download.code.and.data <- function(lan = 'en') {

  # error checking
  if (class(lan) != 'character'){
    stop('Class of en should be character')
  }

  possible.lan <- c('en', 'pt-br')
  if ( !(lan %in% possible.lan)) {
    stop(paste('Input lan (language) should be one of:', paste(possible.lan,collapse = ', ')))
  }

  # check internet
  if (!curl::has_internet()) {
    stop('You need an internet connection to run this function')
  }

  switch(lan,
         'en' = {my.url <- 'https://github.com/msperlin/pmfdR-en-code_data/archive/master.zip'},
         'pt-br' = {my.url <- 'https://github.com/msperlin/pmfdR-pt-code_data/archive/master.zip'})


  # download it
  my.tempfile <- tempfile()
  my.tempfolder <- tempdir()

  utils::download.file(url = my.url, destfile = my.tempfile)
  utils::unzip(my.tempfile, exdir = my.tempfolder)

  cat('\nDownload Ok. \nAll files are available at', paste0(getwd(),'/pmfdR-en-code_data-master\n'))

  return(TRUE)

}
