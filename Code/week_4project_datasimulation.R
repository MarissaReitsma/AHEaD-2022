library(tidyverse)
library("bindata")

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



set.seed(610)
n=1000000
hypertention <- rbinom (n, 1, 457915/1394701 )


set.seed(610)
n=1000000
coronary <- rbinom (n, 1, 169807/1394701)


set.seed(610)
n=1000000
musculoskeletal_issues <- rbinom(n, 1, 376220/1394701)


set.seed(610)
n=1000000
symptoms_of_abnormality <- rbinom(n, 1, 517269/1394701)


set.seed(610)
n=1000000
Endocronic_metabolic_nutritional_disorders <- rbinom(n, 1, 340288/1394701)

simulated_data_table <-data.frame ( sex_2016, arthritis_2016, cancer_2016, diabetes_2016, age_65_69, age_70_79, age_80_89, age_90_and_above, hypertention, coronary, musculoskeletal_issues, symptoms_of_abnormality, Endocronic_metabolic_nutritional_disorders)
colnames(simulated_data_table) <- c("Documented_Female_Sex", "Arthritis", "Cancer", "Diabetes", "age:65-69", "age:70-79", "age:80-89", "age:>90", "hypertention", "coronary", "Musculoskeletal_issues", "symptoms_of_abnormality", "Endocronic_metabolic_nutritional_disorders")
simulated_data_table

##mean_each_variable_distribution
margin_probability <- colMeans(simulated_data_table) ##generates marginal probability of each variable
margin_probability
cond_mat <- condprob(simulated_data_table)  ##generates conditional probabilities matrix
cond_mat
com_prob_mat <- cond_mat*marg_probs ## Scale by marginal probabilities to produce common_prob matrix input
com_prob_mat
cor_mat <- cor(simulated_data_table, method = "pearson")  ##generates a correlation matrix
cor_mat
bincorr2commonprob(marg_probs, cor_mat) ## Use the built-in function to convert the binary correlation matrix to common prob matrix
com_prob_mat

set.seed(12345)
n=1000000
correlated_binarydata <- rmvbin(n, margprob=margin_probability, commonprob = com_prob_mat)
correlated_binarydata
set.seed(12345)
test2 <- rmvbin(n, margprob = margin_probability, bincorr = cor_mat)
test2

all.equal(correlated_binarydata, test2)





       

