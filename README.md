### Introduction
Hi everyone this is my third R Project and took me a really long while!  Here, I present my solutions 
for Programming Assignment 3 in JHU's coursera course "R Programming".  In this project, I examined hospital
qualities across US states using dataset published by U.S. Department of Health and Human Services on
[Hospital Compare website](https://hospitalcompare.hhs.gov/).  

I am still new to coding so a lot of my code will seem really clunky but hope this helps those that are struggling with
the assignment!

### Objectives
In this assignment, we are suppose to write 3 functions: best.R, rankHospital.R, and rankall.R.  These functions will evaluate
the health care outcomes which are listed as 30-day mortality rate.  Further information is given in the R files.

best() returns a hospital with the lowest mortality rate given state and outcome.

rankhospital() returns a hospital given state, outcome, and rank determined by mortality rates.

rankall() returns hospitals from all states given outcome and rank.


### References
I have struggled to organize outcome data by state in rankall.R.  I learned to split the outcome data into multiple dataframes stored in 
a list from Fan Ouyang's solution to the same problem.  Her code can be found [here](https://rstudio-pubs-static.s3.amazonaws.com/300975_34200e5c7d3f4327af308a2e9c20e75b.html).
I have also made very minor improvements to her code such as removing warning messages when NAs are produced.
