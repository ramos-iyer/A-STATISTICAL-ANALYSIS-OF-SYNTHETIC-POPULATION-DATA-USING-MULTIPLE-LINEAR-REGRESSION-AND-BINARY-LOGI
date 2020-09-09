# Importing Libraries used in the code.
library(foreign)
library(caret)
library(haven)

# Importing the dataset and initial analysis
stats.df <- read.spss("E:/Study Material/Statistics for Data Analytics/Project/DataSet/synthetic_population_dataset.sav", use.value.labels = TRUE, to.data.frame = TRUE)
summary(stats.df)

########## PRE PROCESSING ##########

# Checking for null values
sapply(stats.df, function(x) sum(is.na(x)))

# Removing unwanted columns from the data frame
stats.df <- stats.df[ , !names(stats.df) %in% c("BORN_ACS","HHSIZECAT","internet_access","DIVISION","id","EMPLOYED","hours_vary","FDSTMP_CPS","PUB_OFF_CPS","boycott","COMGRP_CPS","TALK_CPS","TABLET_CPS","TEXTIM_CPS","SOCIAL_CPS","VOLSUM","REGISTERED","VOTE14","FOLGOV")]
summary(stats.df)

# Renaming column names to have more understanding
colnames(stats.df)
names(stats.df)[3] <- "ETHNICITY"
names(stats.df)[4] <- "EDUCATION"
names(stats.df)[5] <- "MARITAL_STATUS"
names(stats.df)[6] <- "CHILDREN"
names(stats.df)[7] <- "US_CITIZEN"
names(stats.df)[8] <- "INCOME"
names(stats.df)[9] <- "WORKER_CLASS"
names(stats.df)[10] <- "WORK_HRS"
names(stats.df)[11] <- "MILITARY_SERVICE"
names(stats.df)[12] <- "HOME_OWNERSHIP"
names(stats.df)[13] <- "AREA"
names(stats.df)[14] <- "TENURE"
names(stats.df)[15] <- "NEIGHBOR_TRUST"
names(stats.df)[16] <- "POL_PARTY"
names(stats.df)[17] <- "RELIGION"
names(stats.df)[18] <- "POL_IDEOLOGY"
names(stats.df)[19] <- "OWN_GUN"
colnames(stats.df)

########## DATA TRANSFORMATION ##########

# Converting 0 to NA and removing all NA values from WOKR_HRS as we are going to use that as
# the predicted variable for multiple linear regression.
sapply(stats.df, function(x) sum(is.na(x)))
stats.df$WORK_HRS[stats.df$WORK_HRS == 0] <- NA
stats.df <- stats.df[!is.na(stats.df$WORK_HRS), ]
sapply(stats.df, function(x) sum(is.na(x)))

# Renaming certain column values for clearer understanding and renaming some factor levels
levels(stats.df$US_CITIZEN)[levels(stats.df$US_CITIZEN) == "Yes, a U.S. citizen"] <- "Yes"
levels(stats.df$US_CITIZEN)[levels(stats.df$US_CITIZEN) == "No, not a U.S. citizen"] <- "No"
levels(stats.df$MILITARY_SERVICE)[levels(stats.df$MILITARY_SERVICE) == "Have been on active duty"] <- "Yes"
levels(stats.df$MILITARY_SERVICE)[levels(stats.df$MILITARY_SERVICE) == "Have never been on active duty"] <- "No"
levels(stats.df$CHILDREN)[levels(stats.df$CHILDREN) == "No children"] <- "No"
levels(stats.df$CHILDREN)[levels(stats.df$CHILDREN) == "One or more children"] <- "Yes"
levels(stats.df$POL_PARTY)[levels(stats.df$POL_PARTY) == "Lean Republican"] <- "Republican"
levels(stats.df$POL_PARTY)[levels(stats.df$POL_PARTY) == "Lean Democrat"] <- "Democrat"
levels(stats.df$POL_PARTY)[levels(stats.df$POL_PARTY) == "Ind/No Lean"] <- "No Opinion"
levels(stats.df$ETHNICITY)[levels(stats.df$ETHNICITY) == "White non-Hispanic"] <- "White"
levels(stats.df$ETHNICITY)[levels(stats.df$ETHNICITY) == "Black non-Hispanic"] <- "Black"
levels(stats.df$ETHNICITY)[levels(stats.df$ETHNICITY) == "Other race"] <- "Other"
levels(stats.df$MARITAL_STATUS)[levels(stats.df$MARITAL_STATUS) == "Now married"] <- "Married"
levels(stats.df$MARITAL_STATUS)[levels(stats.df$MARITAL_STATUS) == "Never married"] <- "Unmarried"
levels(stats.df$WORKER_CLASS)[levels(stats.df$WORKER_CLASS) == "Unemployed or Not in Labor Force"] <- "Unemployed"
levels(stats.df$NEIGHBOR_TRUST)[levels(stats.df$NEIGHBOR_TRUST) == "All of the people in your neighborhood"] <- "All"
levels(stats.df$NEIGHBOR_TRUST)[levels(stats.df$NEIGHBOR_TRUST) == "Most of the people in your neighborhood"] <- "Most"
levels(stats.df$NEIGHBOR_TRUST)[levels(stats.df$NEIGHBOR_TRUST) == "Some of the people in your neighborhood"] <- "Some"
levels(stats.df$NEIGHBOR_TRUST)[levels(stats.df$NEIGHBOR_TRUST) == "None of the people in your neighborhood"] <- "None"
levels(stats.df$INCOME)[levels(stats.df$INCOME) == "Less than $20K"] <- "< $20k"
levels(stats.df$INCOME)[levels(stats.df$INCOME) == "$20K to less than $40K"] <- "$20K to $40K"
levels(stats.df$INCOME)[levels(stats.df$INCOME) == "$40K to less than $75K"] <- "$40K to $75K"
levels(stats.df$INCOME)[levels(stats.df$INCOME) == "$75K to less than $150K"] <- "$75K to $150K"
levels(stats.df$INCOME)[levels(stats.df$INCOME) == "$150K or more"] <- "> $150K"
levels(stats.df$HOME_OWNERSHIP)[levels(stats.df$HOME_OWNERSHIP) == "Occupied without payment of rent"] <- "Illegaly Occupied"
levels(stats.df$AREA)[levels(stats.df$AREA) == "Nonmetropolitan"] <- "Non Metropolitan"

#### Reducing the factors wherever possible to make analysis easier ####
summary(stats.df)

# Marital Status to 3 factors -> Married, Unmarried, Other
levels(stats.df$MARITAL_STATUS)[levels(stats.df$MARITAL_STATUS) %in% c("Widowed","Divorced","Separated")] <- "Other"

# Tenure to 2 Factors -> Same house, Different house
levels(stats.df$TENURE)[levels(stats.df$TENURE) %in% c("Different house outside US","Different house in US")] <- "Different house"

# Merging Evangelical Protestant and Mainline Protestant into one -> Protestant
levels(stats.df$RELIGION)[levels(stats.df$RELIGION) %in% c("Evangelical Protestant","Mainline Protestant")] <- "Protestant"

# Generalizing trust on neighbours as "Yes" or "No"
levels(stats.df$NEIGHBOR_TRUST)[levels(stats.df$NEIGHBOR_TRUST) %in% c("All","Most","Some")] <- "Yes"
levels(stats.df$NEIGHBOR_TRUST)[levels(stats.df$NEIGHBOR_TRUST) %in% c("None")] <- "No"

# Removing unused factors from the data frame
stats.df <- droplevels(stats.df)

# reset the row count
rownames(stats.df) <- NULL

# removing outliers from the data using the boxplot method
boxplot(stats.df$AGE, xlab = "AGE")
boxplot(stats.df$WORK_HRS, xlab = "WORK HOURS")
outlier_values <- boxplot.stats(stats.df$WORK_HRS)$out
outlier_rows <- which(stats.df$WORK_HRS %in% outlier_values)
stats.df <- stats.df[-outlier_rows, ]

# Dividing the data frame into 2 parts for analysis
### stats.df.mlr -> this data frame will be used for multiple linear regression
stats.df.mlr <- stats.df[ , c(1,2,3,4,5,6,7,8,9,10)]

### stats.df.blr -> thsi data frame will be used for bivariate logistic regression
stats.df.blr <- stats.df[ , c(11,12,13,14,15,16,17,18,19)]

# Dividing 2+ level variables into dummy variables for linear multiple regression
dmy <- dummyVars(" ~ GENDER", data = stats.df.mlr, fullRank = T)
gender <- data.frame(predict(dmy, newdata = stats.df.mlr))

dmy <- dummyVars(" ~ ETHNICITY", data = stats.df.mlr, fullRank = T)
ethnicity <- data.frame(predict(dmy, newdata = stats.df.mlr))

dmy <- dummyVars(" ~ EDUCATION", data = stats.df.mlr, fullRank = T)
education <- data.frame(predict(dmy, newdata = stats.df.mlr))

dmy <- dummyVars(" ~ MARITAL_STATUS", data = stats.df.mlr, fullRank = T)
marital_status <- data.frame(predict(dmy, newdata = stats.df.mlr))

dmy <- dummyVars(" ~ CHILDREN", data = stats.df.mlr, fullRank = T)
children <- data.frame(predict(dmy, newdata = stats.df.mlr))

dmy <- dummyVars(" ~ US_CITIZEN", data = stats.df.mlr, fullRank = T)
us_citizen <- data.frame(predict(dmy, newdata = stats.df.mlr))

dmy <- dummyVars(" ~ INCOME", data = stats.df.mlr, fullRank = T)
income <- data.frame(predict(dmy, newdata = stats.df.mlr))

dmy <- dummyVars(" ~ WORKER_CLASS", data = stats.df.mlr, fullRank = T)
worker_class <- data.frame(predict(dmy, newdata = stats.df.mlr))

# Creating a data frame to do further analysis for multiple regression
work.hrs.df <- data.frame(stats.df.mlr$AGE,gender,ethnicity,education,marital_status,children,us_citizen,income,worker_class,stats.df.mlr$WORK_HRS)
names(work.hrs.df)[22] <- "WORK_HRS"
names(work.hrs.df)[1] <- "AGE"

own.gun.df <- stats.df.blr

# Writing these data frames into SPSS Documents to do further analysis
write_sav(work.hrs.df, "E:/Study Material/Statistics for Data Analytics/Project/Cleaned Dataset/WORK HRS MLR.sav")
write_sav(own.gun.df, "E:/Study Material/Statistics for Data Analytics/Project/Cleaned Dataset/OWN GUN BLR.sav")

# Removing unused objects
rm("children","dmy","education","ethnicity","gender","income","marital_status","us_citizen","work_hrs_lm","worker_class")
