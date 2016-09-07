#' Performs a SQL type left join on 2 Excel files
#'
#' Selects all rows from the base file, and all rows from the join file if the join
#' condition is met. Choose 2 files via dialog box. Prompted at the console to make 1 file
#' a base file. Prompted to choose a column from each Excel file to use as the join condition.
#'
#' @name leftjoinXL
#' @usage leftjoinXL()
#' @aliases leftjoinXL()
#' @aliases rightjoinXL()
#' @aliases fulljoinXL()
#' @aliases innerjoinXL()
#' @aliases minusXL()
#' @aliases merge
#' @aliases print
#' @aliases write.xlsx
#' @return The joined file, left_join.xlsx is placed in the working directory.
#'
#' @author Yvonne Glanville, \email{yvonneglanville@@gmail.com}
#' @family <joinXL>
#' @seealso \code{\link{innerjoinXL}} for SQL type inner join, \code{\link{fulljoinXL}} for SQL type full join,
#' \code{\link{rightjoinXL}} for SQL type right join, \code{\link{minusXL}} for file1 minus file2
#'
#'
#' @export leftjoinXL
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


leftjoinXL <- function(){

  file_a <- rchoose.files(default = getwd(), caption = "Select 2 files",
                         multi = TRUE, Filters = NULL)

  print(file_a)
  n <- readline("Which file is your base (1 or 2)? ")
  n <- as.integer(n)
  basefile <- read_excel(file_a[n], sheet=1, col_names = TRUE, col_types = NULL, na="", skip=0)
  a <- if (n==1) 2 else 1
  joinTobase <- read_excel(file_a[a], sheet=1, col_names = TRUE, col_types = NULL, na="", skip=0)


  #########################################################################################################
  #Choose base and join columns for the join

  holdingTank <- list(ncol(basefile))
  holdingTank <- colnames(basefile)

  for (g in 1:ncol(basefile)){
    print(paste(g, holdingTank[[g]][1]))
  }
  c <- readline("NUMBER of the base column to join on   ")
  c <- as.numeric(c)
  c <- holdingTank[[c]][[1]]



  holdingTanka <- list(ncol(joinTobase))
  holdingTanka <- colnames(joinTobase)

  for (h in 1:ncol(joinTobase)){
    print(paste(h, holdingTanka[[h]][1]))
  }
  d <- readline("NUMBER of the join column   ")
  d <- as.numeric(d)
  d <- holdingTanka[[d]][1]

  combination <- merge(basefile,joinTobase, by.x=c, by.y=d, all.x=TRUE)
  write.xlsx(combination, "left_join.xlsx")
  print(paste("left_join.xlsx has been written to your working directory.", getwd(), sep=""))
}
