#' Builds exercises using package exams
#'
#' This function build a pdf file and a solution sheet from R exercises available at github.
#'
#' @param lan Language of exercises ('en' or 'pt-br')
#' @param exercise.folder Folder with exercise files (if not found, will download from github)
#' @param pdf.folder Folder to output pdf file and solutions
#'
#' @return TRUE, if sucessful
#' @export
#' @import exams stringr
#' @examples
#'
#' \dontrun{
#' pmfdR_build.exercise()
#' }
#'
pmfdR_build.exercise <- function(lan = 'en',
                                 exercise.folder = 'pmfdR-exercises',
                                 pdf.folder = 'pdf out'){

  # TODO: add option for using chapters in exercise

  # check latex installation
  my.pdftex.flag <- pmfdR_check.pdflatex()

  if (!my.pdftex.flag) {
    stop('cant find pdflatex.exe! Check your latex installation and also if the command is available at userpath')
  }

  # check inputs classes
  if (class(lan)!= 'character') {
    stop('Class of en should be character')
  }

  possible.lan <- c('en', 'pt-br')
  if ( !(lan %in% possible.lan)) {
    stop(paste('Input lan (language) should be one of:', paste(possible.lan,collapse = ', ')))
  }

  if (class(exercise.folder) != 'character') {
    stop('Class of exercise.folder should be character')
  }

  my.f <- list.files(path = exercise.folder,pattern = '*.Rnw', full.names = T)

  if (length(my.f)==0) {
    cat('Cant find any .Rnw files in ', exercise.folder,
        '. Will download it with pmfdR_download.exercises()')

    pmfdR_download.exercises(exercise.folder = exercise.folder)
  }

  my.f <- list.files(path = exercise.folder, pattern = '*.Rnw', full.names = T)

  if (lan == 'pt-br'){
    my.template <- system.file('ext/myexam_pt-br.tex', package = 'pmfdR')
    my.fig.input <- system.file('ext/CAPADigital_DadosFinanceirosR.jpg', package = 'pmfdR')
    my.name <- paste0('pmfdR-Exercicios-',lan,'-',Sys.Date())
  }

  if (lan == 'en') {
    my.template <- system.file('ext/myexam_en.tex', package = 'pmfdR')
    my.fig.input <- system.file('ext/CAPADigital_FinancialDataR.jpg', package = 'pmfdR')
    my.name <- paste0('pmfdR-Exercises-',lan,'-',Sys.Date())
  }

  n.q <- length(my.f)

  n.ver <- 1

  # set a global that is used within exercises
  lan <<- lan
  #browser()
  cat('\npmfdR - Building Exercises')
  my.exam <- exams::exams2pdf(file = my.f,
                              n=n.ver,
                              name=my.name,
                              inputs = my.fig.input,
                              template = my.template,
                              language = lan,
                              institution = '',
                              title = 'R Exercises',
                              course = '',
                              duplex = T,
                              encoding = 'UTF-8',
                              dir = pdf.folder,
                              date = Sys.Date(),
                              intro = '',
                              verbose = FALSE)

  # fix name of pdf
  file.rename(from = paste0(pdf.folder,'/',my.name,'1','.pdf'),
              to = paste0(pdf.folder,'/',my.name, '.pdf'))

  # write answers to csv
  df.answer.key <- data.frame()
  exam.now <- my.exam[[1]]
  n.q <- length(exam.now)

  for (i.q in seq(n.q)){

    sol.now <- letters[which(exam.now[[i.q]]$metainfo$solution)]

    temp <- data.frame(Question = i.q,
                       Solution = sol.now)

    df.answer.key <- rbind(df.answer.key, temp)
  }

  sol.file <- paste0(pdf.folder,'/Solutions_', my.name,'.txt')
  utils::write.csv(x = df.answer.key, file = sol.file, row.names = FALSE)

  cat('\n\nDONE!\n')
  cat('Pdf file available at: ',paste0(pdf.folder,'/',my.name))
  cat('\nSolutions available at: ',sol.file)

  return(TRUE)
}
