## ---- eval=FALSE---------------------------------------------------------
#  if (!require(pmfdR)){
#    install.packages('pmfdR')
#    library(pmfdR)
#  }
#  
#  my.lan <- 'en' # language of code and data ('en' or 'pt-br')
#  
#  # dl may take some time (around 60 mb)
#  pmfdR_download.code.and.data(lan = my.lan)
#  
#  dir.out <- 'pmfdR-en-code_data-master'
#  
#  # list R code
#  list.files(dir.out, pattern = '*.R')
#  list.files(paste0(dir.out,'/data'))

## ---- eval=FALSE---------------------------------------------------------
#  if (!require(pmfdR)){
#    install.packages('pmfdR')
#    library(pmfdR)
#  }
#  
#  my.lan <- 'en' # language of exercises
#  my.exercise.folder <- 'pmfdR-exercises' # name of folder with exercises files (will download from github)
#  my.pdf.folder <- 'PdfOut' # name of folder to place pdf file and answer sheet
#  
#  pmfdR_build.exercise(lan = my.lan,
#                       exercise.folder = my.exercise.folder,
#                       pdf.folder = my.pdf.folder)
#  
#  list.files(my.pdf.folder)

