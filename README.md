
<!-- README.md is generated from README.Rmd. Please edit that file -->
joinXL
======

This 'R' package performs 'SQL' type joins and minus operations on 'Excel' files. 'SQL' is a programming language, which manipulates relational tables within a database. joinXL provides 5 functions, which perform relational joins and a minus operation on Excel files living on your hard drive.
**innerjoinXL, leftjoinXL, rightjoinXL, fulljoinXL, and minusXL**

Installation
============

joinXL is only on github as of August 22, 2016, but has been submitted to CRAN.

``` r
devtools::install_github("yvonneglanville/joinXL")
```

Usage
=====

The 'Excel' files must have a related **key** (column) for a join or minus operation to be performed. All join operations require one file to be designated as the base file because the base file row values take precedence over those of the join file.

Below are two simple 'Excel' tables, which will be joined using the customer information table as the base file and join on the relational **key** customer ID.

### Base Table

![Alt text](/vignettes/customeraccounts.png)

### Join Table

![Alt text](/vignettes/orders.png)

Once the joinXL package is installed (described below), **each join can be called at the console by typing the function name with parenthesis after the name and hitting enter. There is no need to put file information within the parenthesis because the function will open a dialog box.** Choose 2 files, and then follow the console prompts to designate a base file, and choose the common column in the base and join files. A column is chosen from each file to accomadate inconsistent naming conventions. A joined file is then output to the working directory.

innerjoinXL
-----------

An inner join will output only the rows common to both the base and the join file with respect to the **key**. Type **innerjoinXL()** at the console and press enter. This example uses the customer account table as the base and joins the orders table on the common column, customer ID. The output is written to the file, 'inner_join.xlsx'. ![Alt text](/vignettes/innerjoin.png)

leftjoinXL
----------

A left join outputs all columns from the base file along with common row information from the join file based upon the column key, and is written to 'left_join.xlsx'. ![Alt text](/vignettes/leftjoin.png)

rightjoinXL
-----------

A right join outputs all columns from the join file along with common row information from the base file dependent upon the column key. The output is written to 'right_join.xlsx'. In this case the results are the same as the inner join function, but this is due to the table entries not the joins themselves. ![Alt text](/vignettes/rightjoin.png)

fulljoinXL
----------

A full join outputs all rows from both the base and the join files, and is written to 'full_join.xlsx'. ![Alt text](/vignettes/fulljoin.png)

minusXL
-------

The minusXL function allows the direct comparison of the rows of two tables. This function is called in the same manner as the joins. A dialog window for the input of two files opens, and then there are prompts at the console for the designation of a source file and and the common column in each file. Two operations are then performed on the tables.

**Operation 1.** source file-minus-target file outputs rows found in source file but missing from target    
**Operation 2.** target file-minus-source file outputs rows found in target file but missing from base    

If the source and the target '.xlsx' files are identical, then the output files will be empty.
--------------------------------------------------------------------------------------------

**Output at the console**   
1. Preview of source file-minus-target file     
2. Preview of target file-minus-source file    
3. Preview of source file-minus-target file + target file-minus-source file    

**Output in working directory**    
'sourcemMINUStarget.xlsx'    
'targetMINUSsource.xlsx'    
'rowsNOTduplicated.xlsx'    


[![Travis-CI Build Status](https://travis-ci.org/yvonneglanville/joinXL.svg?branch=master)](https://travis-ci.org/yvonneglanville/joinXL)
