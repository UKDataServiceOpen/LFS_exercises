* Encoding: UTF-8.

*LFS Exercise 2: The distribution of weekly earnings of full-time employees

*This exercise recreates ONS labour market analysis reported in the table EARN04: Gross weekly earnings of full-time employees
*https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/earningsandworkinghours/datasets/grossweeklyearningsoffulltimeemployeesearn04 [last accessed 24/04/2021]
This table is updated four times a year in February, May, August and November using the Quarterly Labour Force Survey. 

*Data: Quarterly Labour Force Survey, October - December, 2020, which is accessible from the UK Data Service.

*Set working directory and open data. 
cd 'C:\Your\filepath\1\LFS exercises'. 
get file 'UKDA-8777-spss\spss\spss25\lfsp_od20_eul_pwt22.sav'. 

*Apply the weight. 
weight by PIWT22.


*QUESTION
*1. Why do we use a different weight from exercise 1?


*Create and apply a filter to select those with a weight greater than 0. 
USE ALL.
COMPUTE filter_$=(PIWT22>0).
VARIABLE LABELS filter_$ 'PIWT22>0 (FILTER)'.
VALUE LABELS filter_$  0 'Not Selected' 1 'Selected'.
FORMAT filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE .

*Select only those in fulltime employment (and valid income values) 
Question 2. What values are needed to replace the three asterixs (*) to complete the syntax below?
*Note - you can use the code below to check values and value labels for variables. 
CODEBOOK inecac05 ftpt.

select if (PIWT22>0) and (hourpay>=0 and hourpay<=100) and (inecac05=*) and (ftpt=* or ftpt=*).
execute.

*Create table containing earnings statistics by sex using either Custom tables or crosstab

* Custom Tables.
FREQUENCIES sex.
CTABLES
  /VLABELS VARIABLES=grsswk sex DISPLAY=DEFAULT
  /TABLE sex BY grsswk [MEAN, MEDIAN, PTILE 10, PTILE 25, PTILE 75, PTILE 90]
  /CATEGORIES VARIABLES=sex ORDER=A KEY=VALUE EMPTY=INCLUDE TOTAL=YES POSITION=AFTER MISSING=EXCLUDE.

*Alternative for those without CTables add on using a filter to select females and then males. 

*For female values.
FILTER OFF.
select if (PIWT22>0) and (hourpay>=0 and hourpay<=100) and (inecac05=1) and (ftpt=1 or ftpt=3) and (Sex=2).
execute.
FREQUENCIES VARIABLES=GRSSWK
    /format =NOTABLE
    /PERCENTILES=10.0 25.0 75.0 90.0 
  /STATISTICS=MEDIAN
  /ORDER=ANALYSIS.

***For male values.
FILTER OFF.
select if (PIWT22>0) and (hourpay>=0 and hourpay<=100) and (inecac05=1) and (ftpt=1 or ftpt=3) and (Sex=1).
execute.

FREQUENCIES VARIABLES=GRSSWK
    /format =NOTABLE
    /PERCENTILES=10.0 25.0 75.0 90.0 
  /STATISTICS=MEDIAN
  /ORDER=ANALYSIS.

*Consult the table 
QUESTION 
3. what are median weekly earnings?
4. what are earnings at the lowest decile for males and females? 


* Get a frequency table of sex to examine the gender breakdown of fulltime employees. 
FREQUENCIES SEX.

*QUESTION
5. The ONS table associated with this report gives the estimated number of fulltime employees as 21,215, 000. 
*Using the frequency above, we get 213,138,049. Why is there a difference? What steps above need to be different to get the 
correct estimate of the number of fulltime employees?

