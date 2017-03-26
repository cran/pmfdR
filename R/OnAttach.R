.onAttach <- function(libname, pkgname) {

  my.message <- paste('\nThank you for using pmfdR. You can find more details about the book in:',
                      '\n\nhttps://sites.google.com/view/pmfdr/home',
                      '\n')
  packageStartupMessage(my.message)
}
