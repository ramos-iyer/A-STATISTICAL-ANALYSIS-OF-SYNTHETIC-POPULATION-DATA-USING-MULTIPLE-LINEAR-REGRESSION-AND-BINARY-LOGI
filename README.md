# A-STATISTICAL-ANALYSIS-OF-SYNTHETIC-POPULATION-DATA-USING-MULTIPLE-LINEAR-REGRESSION-AND-BINARY-LOGI

# Masters in Data Analytics Project

## Project: A STATISTICAL ANALYSIS OF SYNTHETIC POPULATION DATA USING MULTIPLE LINEAR REGRESSION AND BINARY LOGISTIC REGRESSION

## Table of Contents

- [Overview](#overview)
- [Components](#components)
  - [Data Preparation and Transformations](#data)
  - [Multiple Linear Regression](#mlr)
  - [Binary Logistic Regression](#blr)
- [Running the Code](#running)
- [Screenshots](#screenshots)
- [System Configuration steps](#config)
- [File Descriptions](#files)
- [Credits and Acknowledgements](#credits)

***

<a id='overview'></a>

### Overview
The primary objective of this research is to focus on the use of Multiple Linear Regression and Binary Logistic Regression. Using data from the Pew research center website, we will analyze the use of these regression techniques for predicting continuous as well as dichotomous variables and discuss on the statistical findings thereof. The dataset being used for the research is from a “2016 Online Opt-In Comparison Study” .  It contains two data files, from which we will be studying the synthetic population data set. The underlying research performed has been as per the below analysis –  a. Considering personal factors like Age, Gender, Ethnicity, Education, Marital Status, Children, US Citizenship, Income class and Worker class to analyze the hours of work put in by a person every week. b. Considering political, interpersonal, geographical and cultural factors like Military Service, Ownership of home, Area, Tenure (more than 1 year or not), trust in neighbor, supporting political party, religion and political ideology to analyze the ownership of a gun in the house.

<a id='components'></a>

### Components
There are three components to this project:

<a id='data'></a>

#### Data Preparation and Transformations
File _'Statistics.r'_ :

- Loads the `synthetic population` dataset.
- Performs the necessary transformations on the data to gain knowledge.
- Removes the outliers from the data.
- Divides the data into two different tables with different coumns based on the group of factors.
- Exports the two datasets into 'SPSS' format for model application.

<a id='mlr'></a>

#### Multiple Linear Regression
File _'WorkHrsMulLinReg.spv'_ :

- Loads the `WORK HRS MLR.sav` dataset.
- Checks for all the assumptions of Multiple Linear Regression.
- Evaluates the model performance.

<a id='blr'></a>

#### Binary Logistic Regression
File _'OwnGunBinLogReg.spv'_ :

- Loads the `OWN GUN BLR.sav` dataset.
- Checks for all the assumptions of Binary Logistic Regression.
- Evaluates the model performance.

<a id='running'></a>

### Running the Code

The code in 'Statistics.r' needs to be opened on R Studio and can be run as a whole or run line by line. The code contains comments which provides details on what each chunk of code performs on the data.

The 'WorkHrsMulLinReg.spv' and 'OwnGunBinLogReg.spv' are SPSS files and needs to be opened on SPSS in order to understand what are the results and how the analysis is performed.

<a id='screenshots'></a>

### Screenshots

<a id='config'></a>

### System Configuration Steps

In order to run the code, below are the necessary requirements:

- R and R Studio: As the code in 'Statistics.r' is developed in R, you need to install R as well as R Studio in order to open and execute the files.
- Packages: Below is a list of packages that need to be installed before execution of the code.

haven, caret, foreign

- SPSS: As the implementation of Multiple Linear Regression and Binary Logistic Regression in the files 'WorkHrsMulLinReg.spv' and 'OwnGunBinLogReg.spv' have been performed using SPSS, it has to be installed. SPSS is a GUI based Tool that can be used for performing statistical analysis.

<a id='files'></a>

### File Descriptions

There are 2 main folders and 3 files in the root directory that are necessary for the project:

1. DataSet:
  - synthetic_population_dataset.sav: This file contains the entire synthetic population dataset in SPSS format.

2. Statistics.r: This file contains the code for Data Preparation and Transformations.

3. Cleaned Dataset:
  - OWN GUN BLR.sav: This file contains the dataset that is specific for application for Binary Logistic Regression.
  - WORK HRS MLR.sav: This file contains teh dataset that is specific for application of Multiple Linear Regression.

4. OwnGunBinLogReg.spv: This file contains the implementation of Binary Logistic Regression in SPSS format.

5. WorkHrsMulLinReg.spv: This file contains the implementation of Multiple Linear Regression in SPSS format.

<a id='credits'></a>

### Credits and Acknowledgements

* [Pew Research](https://www.pewresearch.org/methods/dataset/2016-online-opt-in-comparison-study/) for providing the dataset used for this project.
* [NCI](https://www.ncirl.ie/) for a challenging project as part of their full-time masters in data analytics course subject 'Statistics for Data Analytics'
