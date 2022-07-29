library(bindata)
library(tidyverse)
library(truncnorm)

## Step 1: Build the Risk Adjustment Simulation Data
##generate binomial distributions of age, female documented sex, CCS code arthritis, CCS code cancer, and CCS code diabetes based on the percentages by year in the Medicare Sample Characteristics (Figure SS2):
##data of binomal distribution taken form Table 3-3:https://www.cms.gov/research-statistics-data-and-systems/statistics-trends-and-reports/reports/downloads/pope_2000_2.pdf

n <- 1000000
set.seed(600)


female_sex_2016 <- rbinom(n, 1, 0.552)
age <- sample(x = c("age_65_69_2016", "age_70_79_2016", "age_80_89_2016", "age_90up_2016"), 
              size = n, replace = T, prob = c(.279, .451, .221, .049))
arthritis_2016 <- rbinom(n, 1, 0.289)
cancer_2016 <- rbinom(n, 1, 0.33)
diabetes_2016 <- rbinom(n, 1, 0.357)
hypertention <- rbinom (n, 1, 457915/1394701)
coronary_Atherosclerosis<- rbinom (n, 1, 169807/1394701)
musculoskeletal_issues <- rbinom(n, 1, 376220/1394701)
symptoms_of_abnormality <- rbinom(n, 1, 517269/1394701)
Endocronic_metabolic_nutritional_disorders <- rbinom(n, 1, 340288/1394701)

#create data frame of our 2016 variable characteristics:
df <- data.frame(female_sex_2016, age, arthritis_2016, cancer_2016, diabetes_2016, hypertention, coronary_Atherosclerosis, musculoskeletal_issues, symptoms_of_abnormality, Endocronic_metabolic_nutritional_disorders)
df <- df %>%
  mutate("Ages 65-69" = ifelse(age == "age_65_69_2016", 1, 0)) %>%
  mutate("Ages 70-79" = ifelse(age == "age_70_79_2016", 1, 0)) %>%
  mutate("Ages 80-89" = ifelse(age == "age_80_89_2016", 1, 0)) %>%
  mutate("Ages 90+" = ifelse(age == "age_90up_2016", 1, 0)) %>%
  select(-c("age"))
colnames(df) <- c("Female Sex", "Arthritis", "Cancer", "Diabetes", "Hypertension", "Coronary Atherosclerosis/Other Chronic Ischemic Heart Disease",
                  "Other Musculoskeletal and Connective Tissue Disorders", "Major Symptoms_Abnormalities", "EMN Disorders",
                  "Ages 65-69", "Ages 70-79", "Ages 80-89", "Ages 90+")
View(df)

## Step 2: Create the conditional probability matrix, common probability matrix, and binary correlation matrix.
#find marginal probabilities
marg_probs <- colMeans(df)
marg_probs #they match probabilities we used to construct the dataframes!

#create conditional prob matrix
cond_mat <- condprob(df)
cond_mat

#compute common probability matrix
com_prob_mat <- cond_mat*marg_probs
com_prob_mat

#compute binary correlation matrix
cor_mat <- cor(df, method = "pearson")
cor_mat

## Step 3: Extract Correlation Structure
#Testing out the function using common probability argument
set.seed(600)
commtest <- rmvbin(n, margprob=marg_probs, commonprob=com_prob_mat)
#Testing out the function using the binary correlation argument
set.seed(600)
bincorrtest <- rmvbin(n, margprob = marg_probs, bincorr = cor_mat)

#Do these two tests yield similar results/are the structures similar?
all.equal(commtest, bincorrtest)
#TRUE

# Create healthcare spending outcome variable as a function of demographics and HCCs
df <- df %>%
  mutate(Spending = rtruncnorm(n, a=100, b=100000,
                        7000-
                          100*`Female Sex`+
                          200*Arthritis+
                          1000*Cancer-
                          60*Diabetes-
                          100*Hypertension+
                          300*Diabetes*Hypertension+
                          4000*`Coronary Atherosclerosis/Other Chronic Ischemic Heart Disease`-
                          6*sin(`Other Musculoskeletal and Connective Tissue Disorders`)-
                          200*`Major Symptoms_Abnormalities`*Cancer+
                          20*`EMN Disorders`-
                          400*`Ages 65-69`-
                          200*`Ages 70-79`+
                          400*`Ages 80-89`+
                          1000*`Ages 90+`-
                          100*`Female Sex`*`Ages 65-69`-
                          200*`Female Sex`*`Ages 70-79`, 2000))


