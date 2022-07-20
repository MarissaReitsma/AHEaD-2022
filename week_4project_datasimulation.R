library(tidyverse)


set.seed(600)

n=1000000

sex_2016 <- rbinom(n, 1, 0.552)
sex_2016


set.seed(615)

n=1000000

arthritis_2016 <- rbinom(n, 1, 0.289)
arthritis_2016

set.seed(615)

n=1000000

cancer_2016 <- rbinom(n, 1, 0.33)
cancer_2016



set.seed(610)

n=1000000
diabetes_2016 <- rbinom(n, 1, 0.357)
diabetes_2016

set.seed(600)
n=1000000
age_65_69 <- rbinom(n,1,0.279)

set.seed(600)
n=1000000
age_70_79 <- rbinom(n,1,0.451)
set.seed(600)
n=1000000
age_80_89 <-rbinom(n,1,0.221)

set.seed(610)
n=1000000
age_90_and_above <-rbinom(n,1,0.049)

summary(age_65_69)
summary(age_70_79)
summary(age_80_89)
summary(age_90_and_above)
year<- rep(c(2016), times=1000000)
simulated_data_table <-data.frame (year, sex_2016, arthritis_2016, cancer_2016, diabetes_2016, age_65_69, age_70_79, age_80_89, age_90_and_above )
colnames(simulated_data_table) <- c("Year", "Documented_Female_Sex", "Arthritis", "Cancer", "Diabetes", "age:65-69", "age:70-79", "age:80-89", "age:>90")
simulated_data_table

##mean_each_variable_distribution
sex<-mean(sex_2016) 
arthritis<-mean(arthritis_2016)
cancer<-mean(cancer_2016) 
diabetes<-mean(diabetes_2016)
age_65<-mean(age_65_69)
age_70 <- mean(age_70_79)
age_80 <- mean(age_80_89)
age_above_90 <-mean(age_90_and_above)

summarizing_data <- matrix(c(sex, arthritis, cancer, diabetes, age_65, age_70, age_80, age_above_90), ncol = 1, byrow=TRUE)
colnames(summarizing_data) <- c("mean value of each data set distribution")
rownames(summarizing_data) <- c("Documented_Female_Sex", "Arthritis", "Cancer", "Diabetes", "age:65-69", "age:70-79", "age:80-89", "age:>90")
table_data <- as.table(summarizing_data)
table_data
