Effect of Income Inequality on Environment Performance Index (EPI)
========================================================
author: Mario Alonso Rodriguez and Raju Adhikari
date: 29 November 2016
autosize: true

Table of Contents
========================================================

- Research Question
- Theoretical Basis
- Operationalization
- Plots, Maps and other Descriptive Statistics
- Regression and Other Inferential Statistics
- Conclusion

Research Question
========================================================


Unrefined Question:


- Does income inequality have an effect on the environment ?

Refined Question:

- Does income inequality of a country affect its Environment Performance Index? If so, How?

Theoretical Premise
========================================================

- Carbon emission and equal countries
- Economic Development and unequal countries
- Environment Performance Index

Operationalization
========================================================

- Explanatory Variable: 
    - Gini coefficient (measure of income inequality)
    - Source: World Bank's API
- Dependendent Variable: 
    - EPI (measure of environment performance)
    - Source: Yale Center for Environmental Law and Policy
- Data Cleaning:
    - Excel File, Yeary data separated by sheets 
    - Columns included items used to calculate EPI
    - Merge the datasets
- Control Variables:
    - Emissions per country, GDP per capita, ...

Descriptive Statistics
========================================================

- Table
- Maps
- Plots

Inferential Statistics
========================================================

- Regression Equation
- Type of Data: Panel
- Pooled OLS, FE, RE (Test to choose)
- Interpretation of estimates and error

Robustness
========================================================

- Heteroscedasticity
- Other problems

Website and Bibliography
========================================================

- Website : Link
- Bibliography using BibTex



Slide With Code
========================================================


```r
summary(cars)
```

```
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

Slide With Plot
========================================================

![plot of chunk unnamed-chunk-2](Presentation-figure/unnamed-chunk-2-1.png)
