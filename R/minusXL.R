#' Performs a SQL type minus query on 2 Excel files
#'
#' Performs 2 operations: source-minus-target and target-minus-source
#' If the files are identical all outputs are empty.
#' Choose 2 files via dialog box, and then from the console choose the common column between the files.
#' 3 separate .xlsx files are returned to the user
#'    "source_minus_target.xlsx"
#'    "target_minus_source.xlsx"
#'    "rowsNOTduplicated.xlsx"
#'
#' @name minusXL
#' @usage minusXL()
#' @aliases minusXL()
#' @aliases rightjoinXL()
#' @aliases fulljoinXL()
#' @aliases innerjoinXL()
#' @aliases leftjoinXL()
#' @aliases merge
#' @aliases print
#' @aliases write.xlsx
#' @aliases head
#' @return In working directory: source_minus_target.xlsx, target_minus_source.xlsx, rowsNOTduplicated.xlsx
#'
#' @author Yvonne Glanville, \email{yvonneglanville@@gmail.com}
#' @family <joinXL>
#' @seealso \code{\link{innerjoinXL}} for SQL type inner join, \code{\link{leftjoinXL}} for SQL type left join,
#' \code{\link{rightjoinXL}} for SQL type right join, \code{\link{fulljoinXL}} for SQL type full join
#'
#' @importFrom readxl read_excel
#' @importFrom timeSeries merge
#' @importFrom timeSeries head
#' @importFrom openxlsx write.xlsx
#' @importFrom data.table data.table
#' @import R.utils
#' @import rChoiceDialogs
#' @import Rcpp
#' @import graphics
#' @import grDevices
#' @import stats
#' @import rJava


minusXL <- function(){

  file_a <- rchoose.files(default = getwd(), caption = "Select 2 files",
                          multi = TRUE, Filters = NULL)

  print(file_a)
  n <- readline("Which file is your source file (1 or 2)? ")
  n <- as.integer(n)
  sourceFILE <- read_excel(file_a[n], sheet=1, col_names = TRUE, col_types = NULL, na="", skip=0)
  a <- if (n==1) 2 else 1
  targetFILE <- read_excel(file_a[a], sheet=1, col_names = TRUE, col_types = NULL, na="", skip=0)

  holdingTank <- list(ncol(sourceFILE))
  holdingTank <- colnames(sourceFILE)

  for (g in 1:ncol(sourceFILE)){
    print(paste(g, holdingTank[[g]][1]))
  }
  c <- readline("NUMBER of the source column   ")
  c <- as.numeric(c)
  c <- holdingTank[[c]][[1]]

  holdingTanka <- list(ncol(targetFILE))
  holdingTanka <- colnames(targetFILE)

  for (h in 1:ncol(targetFILE)){
    print(paste(h, holdingTanka[[h]][1]))
  }

  d <- readline("NUMBER of the target column   ")
  d <- as.numeric(d)
  d <- holdingTanka[[d]][1]

  SourceTable <- data.table(sourceFILE, key=c)
  targetTable <- data.table(targetFILE, key=d)
  SmT <- SourceTable[!targetTable]
  SmT <- as.data.frame(SmT)
  print("Top of file: source-minus-target")
  print(head(SmT))
  write.xlsx(SmT, "sourceMINUStarget.xlsx")
  TmS <- targetTable[!SourceTable]
  TmS <- as.data.frame(TmS)
  print("Top of file: target-minus-source")
  print(head(TmS))
  write.xlsx(TmS, "targetMINUSsource.xlsx")
  rowsNOTdulpicated <- merge(SmT, TmS, by.x = c, by.y = d, all=TRUE)
  print("Top of file: all non-duplicated rows")
  print(head(rowsNOTdulpicated))
  write.xlsx(rowsNOTdulpicated, "rowsNOTduplicated.xlsx")
  print(paste("3 .xlsx files have been written to your working directory.", getwd(), sep=""))
}
