library(bindata)
library(tidyverse)
library(truncnorm)
library(SuperLearner)
library(glmnet)

## Step 1: Build the Risk Adjustment Simulation Data
##generate binomial distributions of age, female documented sex, CCS code arthritis, CCS code cancer, and CCS code diabetes based on the percentages by year in the Medicare Sample Characteristics (Figure SS2):
##data of binomal distribution taken form Table 3-3:https://www.cms.gov/research-statistics-data-and-systems/statistics-trends-and-reports/reports/downloads/pope_2000_2.pdf

n <- 10000 #10,000
set.seed(600)

female_sex <- rbinom(n, 1, 0.552)
age <- sample(x = c("age_65_69_2016", "age_70_79_2016", "age_80_89_2016", "age_90up_2016"), 
              size = n, replace = T, prob = c(.279, .451, .221, .049))
arthritis <- rbinom(n, 1, 0.289)
cancer <- rbinom(n, 1, 0.33)
diabetes <- rbinom(n, 1, 0.357)
hypertension <- rbinom (n, 1, 457915/1394701)
coronary_atherosclerosis<- rbinom (n, 1, 169807/1394701)
musculoskeletal_issues <- rbinom(n, 1, 376220/1394701)
symptoms_of_abnormality <- rbinom(n, 1, 517269/1394701)
endocronic_metabolic_nutritional_disorders <- rbinom(n, 1, 340288/1394701)
         
#create data frame of our 2016 variable characteristics:
df <- data.frame(female_sex, age, arthritis, cancer, diabetes, hypertension, coronary_atherosclerosis, musculoskeletal_issues, symptoms_of_abnormality, endocronic_metabolic_nutritional_disorders)
df <- df    %>%
  mutate("Ages 65-69" = ifelse(age == "age_65_69_2016", 1, 0)) %>%
  mutate("Ages 70-79" = ifelse(age == "age_70_79_2016", 1, 0)) %>%
  mutate("Ages 80-89" = ifelse(age == "age_80_89_2016", 1, 0)) %>%
  mutate("Ages 90+" = ifelse(age == "age_90up_2016", 1, 0)) %>%
  select(-c("age"))
colnames(df) <- c("FemaleSex", "Arthritis", "Cancer", "Diabetes", "Hypertension", "CoronaryAtherosclerosisOtherChronicIschemicHeartDisease",
                  "OtherMusculoskeletalandConnectiveTissueDisorders", "MajorSymptomsAbnormalities", "EMNDisorders",
                  "Ages65_69", "Ages70_79", "Ages80_89", "Ages90up")
View(df)

#---------------------------------------------------------------------------------------
## Step Two: Create healthcare spending outcome variable as a function of demographics and HCCs
df <- df %>%
  mutate(Spending = rtruncnorm(n, a=100, b=100000,
                               7000 -
                                 100*FemaleSex +
                                 200*Arthritis +
                                 1000*Cancer -
                                 60*Diabetes -
                                 100*Hypertension +
                                 300*Diabetes*Hypertension +
                                 4000*CoronaryAtherosclerosisOtherChronicIschemicHeartDisease -
                                 6*sin(OtherMusculoskeletalandConnectiveTissueDisorders) -
                                 200*MajorSymptomsAbnormalities*Cancer +
                                 20*EMNDisorders -
                                 400*Ages65_69 -
                                 200*Ages70_79 +
                                 400*Ages80_89 +
                                 1000*Ages90up -
                                 100*FemaleSex*Ages65_69 -
                                 200*FemaleSex*Ages70_79, 2000))
View(df)
summary(df)

#----------------------------------------------------------------------------------------
## Step Three: Use Different Approaches to Predict Healthcare Spending

# A. Start with a linear regression
SpendingLRegression <- glm(Spending ~ female_sex + arthritis + cancer + diabetes + hypertension + coronary_atherosclerosis + musculoskeletal_issues + symptoms_of_abnormality + endocronic_metabolic_nutritional_disorders, data=df, family="gaussian")
SpendingLRegression
# finding CV risks of regression
fit.data.glmSL<- SuperLearner(Y=df[,14],X=df[,1:12],
                          SL.library="SL.glm", family=gaussian(),
                          method="method.NNLS", verbose=TRUE)
fit.data.glmSL
#
fit.data.glmCV <- CV.SuperLearner(Y=df[,14],X=df[,1:12], V=10,
                                 SL.library="SL.glm", verbose=TRUE,
                                 method="method.NNLS", family=gaussian())
fitSL.data.glmCV
# sd
mean((df[,14]-fit.data.glmSL$SL.predict)^2)
#4023048 -> 2005.75

#--------------------------------------------------
# Step Four: Use an ensemble approach to assess performance collectively (10-fold cross vlaidation)
# Specifying a library of algorithms we will be using in our ensemble approach.
SL.library <- c("SL.glm", "SL.randomForest", "SL.glmnet")

#finding CV risks of ensemble
fit.data.SL<- SuperLearner(Y=df[,14],X=df[,1:12],
                          SL.library=SL.library, family=gaussian(),
                          method="method.NNLS", verbose=TRUE)
fit.data.SL

#cross-validated SuperLearner CV risks
fitSL.data.CV <- CV.SuperLearner(Y=df[,14],X=df[,1:12], V=10,
                                 SL.library=SL.library, verbose=TRUE,
                                 method="method.NNLS", family=gaussian())
fitSL.data.CV

#CV risk for SuperLearner
# computing mean squared error and R^2
mean((df[,14]-fitSL.data.CV$SL.predict)^2)
#4036741 -> 2009.16
