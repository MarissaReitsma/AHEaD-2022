#########################################
## Explore the use of the bindata package
#########################################
install.packages("bindata")
library(bindata)
?rmvbin

df <- read.csv("C:/Users/steph/Downloads/correlated_binary_data.csv")
View(df)

marg_probs <- c(mean(df$cvd), mean(df$diabetes), mean(df$fracture)) # One way to compute marginal probabilities
marg_probs <- colMeans(df) # Another way to compute marginals

## Compute matrix of conditional probabilities
cond_mat <- condprob(df)
cond_mat #shows us the matrix of the probability of each HCC when conditional to another

mean(df$cvd[df$diabetes==1]) ## Compute conditional probabilities manually (p(cvd|diabetes))
mean(df$cvd[df$fracture==1]) ## Compute conditional probabilities manually (p(cvd|fracture))
mean(df$diabetes[df$fracture==1]) #Compute conditional probabilities manually (p(diabetes|fracture))

cond_mat
marg_probs

com_prob_mat <- cond_mat*marg_probs ## Scale by marginal probabilities to produce common_prob matrix input
com_prob_mat #common probability matrix

## Compute Binary Correlation Matrix
cor_mat <- cor(df, method = "pearson") # computes the pearson binary correlation between the columns of 'df'
cor_mat # binary correlation matrix

## Manually compute pearson correlation for CVD & Diabetes
p_a <- nrow(df[df$cvd==1,])/nrow(df) # Probability of cvd
p_b <- nrow(df[df$diabetes==1,])/nrow(df) # Probability of diabetes
p_ab <- nrow(df[df$cvd==1 & df$diabetes==1,])/nrow(df) # Probability of cvd and diabetes
(p_ab-(p_a*p_b))/(sqrt(p_a*(1-p_a)*p_b*(1-p_b)))
cor_mat # Confirm manual and function work the same

#Manually compute pearson correlation for CVD & Fractures
p_a <- nrow(df[df$cvd==1,])/nrow(df) # Probability of cvd
p_c <- nrow(df[df$fracture==1,])/nrow(df) # Probability of fractures
p_ac <- nrow(df[df$cvd==1 & df$fracture==1,])/nrow(df) # Probability of cvd and fractures
(p_ac-(p_a*p_c))/(sqrt(p_a*(1-p_a)*p_c*(1-p_c)))
cor_mat # They match!

#Manually compute pearson correlation for Diabetes & Fractures
p_b <- nrow(df[df$diabetes==1,])/nrow(df) # Probability of diabetes
p_c <- nrow(df[df$fracture==1,])/nrow(df) # Probability of fractures
p_bc <- nrow(df[df$diabetes==1 & df$fracture==1,])/nrow(df) # Probability of cvd and fractures
(p_bc-(p_b*p_c))/(sqrt(p_b*(1-p_b)*p_c*(1-p_c)))
cor_mat #They match again!

bincorr2commonprob(marg_probs, cor_mat) ## Use the built-in function to convert the binary correlation matrix to common prob matrix
com_prob_mat ## Yay they're the same! It works!
# The conditionalprob*marginalprob == common probability matrix

#Testing out the function using the commonprob argument
set.seed(12345)
test1 <- rmvbin(100000, margprob = marg_probs, commonprob = com_prob_mat)
#Testing out the function using the binary correlation
set.seed(12345)
test2 <- rmvbin(100000, margprob = marg_probs, bincorr = cor_mat)

#Test if both tests yield about the same results
all.equal(test, test2) ## Show that either simulating using the commonprob method or the correlation method will return the same result 

## To summarize: our goal is to extract the structure from observed binary data and replicate this structure in our simulated data.
## This can either be accomplished by extracting a matrix of pairwise probabilities and entering this as the commonprob argument,
## or by extracting a binary correlation matrix and entering this as the bincorr argument.
## The important piece is to know which approach you've taken and make sure that it is entered as the correct argument in the rmvbin function.
test2 <- rmvbin(100000, margprob = marg_probs, bincorr = cor_mat)

all.equal(test, test2) ## Show that either simulating using the commonprob method or the correlation method will return the same result 

## To summarize: our goal is to extract the structure from observed binary data and replicate this structure in our simulated data.
## This can either be accomplished by extracting a matrix of pairwise probabilities and entering this as the commonprob argument,
## or by extracting a binary correlation matrix and entering this as the bincorr argument.
## The important piece is to know which approach you've taken and make sure that it is entered as the correct argument in the rmvbin function.

