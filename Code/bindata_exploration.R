#########################################
## Explore the use of the bindata package
#########################################

library(bindata)

df <- read.csv("~/Downloads/correlated_binary_data.csv")

marg_probs <- c(mean(df$cvd), mean(df$diabetes), mean(df$fracture)) # One way to compute marginal probabilities
marg_probs <- colMeans(df) # Another way to compute marginals

## Compute matrix of conditional probabilities
cond_mat <- condprob(df)
cond_mat

mean(df$cvd[df$diabetes==1]) ## Compute conditional probabilities manually (p(cvd|diabetes))
mean(df$cvd[df$fracture==1]) ## Compute conditional probabilities manually (p(cvd|fracture))

com_prob_mat <- cond_mat*marg_probs ## Scale by marginal probabilities to produce common_prob matrix input

## Compute Binary Correlation Matrix
cor_mat <- cor(df, method = "pearson")

## Manually compute pearson correlation for CVD & Diabetes
p_a <- nrow(df[df$cvd==1,])/nrow(df) # Probability of cvd
p_b <- nrow(df[df$diabetes==1,])/nrow(df) # Probability of diabetes
p_ab <- nrow(df[df$cvd==1 & df$diabetes==1,])/nrow(df) # Probability of cvd and diabetes
(p_ab-(p_a*p_b))/(sqrt(p_a*(1-p_a)*p_b*(1-p_b)))
cor_mat # Confirm manual and function work the same

bincorr2commonprob(marg_probs, cor_mat) ## Use the built-in function to convert the binary correlation matrix to common prob matrix
com_prob_mat ## Yay they're the same! It works!

set.seed(12345)
test <- rmvbin(100000, margprob = marg_probs, commonprob = com_prob_mat)
set.seed(12345)
test2 <- rmvbin(100000, margprob = marg_probs, bincorr = cor_mat)

all.equal(test, test2) ## Show that either simulating using the commonprob method or the correlation method will return the same result 

## To summarize: our goal is to extract the structure from observed binary data and replicate this structure in our simulated data.
## This can either be accomplished by extracting a matrix of pairwise probabilities and entering this as the commonprob argument,
## or by extracting a binary correlation matrix and entering this as the bincorr argument.
## The important piece is to know which approach you've taken and make sure that it is entered as the correct argument in the rmvbin function.

