# AHEaD-2022

## Improving Equity for Health Care Payments

*Faculty Mentor*: Sherri Rose, [sherrirose@stanford.edu](mailto:sherrirose@stanford.edu) </br>
*Near-Peer Mentor*: Marissa Reitsma, [mreitsma@stanford.edu](mailto:mreitsma@stanford.edu)

## Table of contents
- [Week 1](#week-1-june-21---june-24)
- [Week 2](#week-2-june-27---july-1)
- [Week 3](#week-3-july-5---july-8)
- [Week 4](#week-4-july-11---july-15)
- [Week 5](#week-5-july-18---july-22)
- [Week 6](#week-6-july-25---july-29)
- [Week 7](#week-7-august-1---august-5)
- [Week 8](#week-8-august-8---august-12)

## Project description
What constitutes a fair or unfair algorithm is context specific. Metrics for evaluating fairness have been developed, as have methods for prioritizing measures of fairness when building algorithms. However, algorithms are not neutral and optimization choices will reflect a specific value system and the distribution of power to make these decisions. Data also reflect societal bias, such as structural racism. Algorithmic fairness research spans many fields, including sociology, ethics, computer science, statistics, and population health. These concepts are incredibly important given the potential for and actual realized harm to marginalized groups. This summer,  students will have the opportunity to learn more about ethical pipelines for algorithms and contribute to an ongoing project in health care insurance plan payment among older adults.  Changes in payment systems can lead to tremendous gains in access to care and improved health outcomes.  The specific goal of the overall project is to improve the undercompensation of minoritized racial and ethnic groups in the Medicare risk adjustment formula. 

Over the summer, AHEaD scholars will help make progress on improving equity for health care payments by working on some or all of the below: 

- Review and critique existing approaches to healthcare payment in a literature review
- Develop simulation data that reflects the population of older adults insured by Medicare
- Compare predictions of healthcare spending from ordinary least squares regressions and machine learning methods in simulated data
- Apply fair(er) algorithms to improve the undercompensation of minoritized racial and ethnic groups in simulated data

## Week 1 (June 21 - June 24)

#### *In-person programming at Stanford. Welcome!! :-)*

## Week 2 (June 27 - July 1)

#### Introduction to health insurance payment and algorithmic fairness in healthcare

This week we will focus on developing foundational knowledge for the project, including conducting a literature review. We don't expect you to understand everything, and we'll plan to discuss the readings each week as a group. Think about the main take-aways of each reading rather than feeling the need to keep track of specific details. 

**Meetings** 

This week we will meet twice to get the project started! The first meeting will be on Tuesday, June 28 at 1p Pacific via zoom with Sherri. The second meeting is Friday, July 1 at 1:30p Pacific via zoom with Sherri and Marissa. Sherri will send calendar invitations with the zoom link.

**Readings** 

- [International Health Care System Profiles: United States](https://www.commonwealthfund.org/international-health-policy-center/countries/united-states)
- [Ethical Machine Learning in Health care](https://github.com/MarissaReitsma/AHEaD-2022/raw/main/Readings/Chen%202021.pdf)


**Tasks** 
- Conduct a literature review using the National Library of Medicine's
  [MeSH](https://www.ncbi.nlm.nih.gov/mesh) terms and
  [PubMed](https://pubmed.ncbi.nlm.nih.gov/). Try starting with the MeSH terms "Health Care Costs" and "Health Expenditures." You might also want to explore others and experiment to see the full power of MeSH. You can access [Stanford PubMed](https://pubmed-ncbi-nlm-nih-gov.laneproxy.stanford.edu/?otool=stanford&holding=F1000) by logging in with your SUNetID.
- Find 8-10 articles that study plan payment risk adjustment and put the references in a Google Doc. Summarize each in a couple sentences. Upload your google doc [here](https://drive.google.com/drive/u/2/folders/1dl5aoBucVoZpRxfUJIgpTaaCs02RI4G4).

## Week 3 (July 5 - July 8)

#### Diving into plan payment risk adjustment and our first simulation

**Readings** 
- [Risk Adjustment for Health Plan Payment](https://github.com/MarissaReitsma/AHEaD-2022/raw/main/Readings/2018_EllisMartinsRose_RABook.pdf)
- [The Design of Simulation Studies in Medical Statistics](https://onlinelibrary.wiley.com/doi/abs/10.1002/sim.2673) (Use the Stanford PubMed link above to access the full text!)

**Tasks** 


#### Simulation Data Exercise

Run the code below and respond to the questions in the [Week 3 R Markdown template](https://github.com/MarissaReitsma/AHEaD-2022/tree/main/Code). Download the markdown template by following the hyperlink to the code folder, right clicking the file name, and choosing "Save Link As..."

![image](https://user-images.githubusercontent.com/63253799/176952548-d21c7d75-d0fb-44ef-b343-f28f3be3d432.png)

Remember you can use '?' in R to look up a help file for any function to learn more. For example, ?set.seed will give you the help file for generating random seeds.

```r
################
#Simulated Data#
################

# Set random seed so that data reproduces the same each time it is run
set.seed(27)

# Sample Size
n <- 1000

# Generate data
df <- data.frame(W1=runif(n, min=0.5, max=1),
		  W2=runif(n, min=0, max=1))
df <-  transform(df, #add Y
		  Y=rbinom(n, 1, 1 / (1 + exp(-(-3*W1 - 2*W2 + 2))) ) )
```
1) Summarize and visualize the data frame df. Start to learn ggplot for data visualization: https://r4ds.had.co.nz/data-visualisation.html#first-steps
2) Adapt the above code to add a variable W3 that is from a normal distribution to create a new data frame df2. W3, along with W1 and W2, should be used to generate Y in df2.
3) Summarize and and visualize the data frame df2. Did you find anything unusual or troublesome about the Y variable in df2 versus df?
4) If you have additional time, try the following:
	+ Generate a categorical variable W4 (eg. three different age groups, colors, or countries)
	+ Summarize your data separately by each category of W4 (hint: explore `group_by` and `summarize` in dplyr)
	+ Visualize your data separately by each category of W4 (hint: look up `facet_wrap` in ggplot2)
	+ Compute the correlation between W1 and W2, W1 and Y, and W2 and Y. How is are these quantities related to the way that W1, W2, and Y were generated?
5) Save your results in an R Markdown HTML and upload it [here](https://drive.google.com/drive/u/2/folders/1llPziG8XUFz9unH474nPrSAslk-JzPak).

Let us know if you have questions in our fairness group Slack channel or by email! We're happy to help, including if the instructions above are not clear enough. We are also trying to calibrate the amount of work such that it is not too much or too little, so it's OK if you don't finish everything in your 20 hours. (Or, in the other direction, if you finish early and would like more tasks, we will gladly provide!) But please do not overwork yourselves. We want to pace the project at a good speed for you to make steady progress while still engaging in the AHEaD coursework and, of course, caring for your physical and mental well being. :)

## Week 4 (July 11 - July 15)

#### Regression and generating realistic simulation data

This week will build upon your coding work last week. We will implement regressions in the simulated dataset from week 3, exploring how different aspects of model specification and simulation sample size change coefficients. Then, we will start to build a simulation dataset for risk adjustment in the Medicare population. This will ultimately include generating many more variables (binary, categorical, and continuous) that have realistic covariance and relate to a healthcare spending outcome indicator.

##### Regression on Week 3 Simulated Data

Extend your R Markdown file from Week 3 to run a set of exploratory generalized linear models:

1) Following the steps from the Week 3 regression curriculum, implement a logistic regression (`Y~W`) using the `glm` function and specifying an appropriate distribution for Y.
2) How do the model coefficients relate to how the data were generated?
3) What happens when you increase or decrease your simulation data sample size? 
4) Explore how alternative model specifications (both which covariates are included and which response distribution is specified) change the model fit.

##### Build the Risk Adjustment Simulation Data

Read more about the Medicare risk adjustment formula and data in the Supplementary Material of Zink & Rose (2021) [here](https://informatics.bmj.com/content/bmjhci/28/1/e100414.full.pdf?with-ds=yes).

Select five variables to start with to generate: age, female documented sex, CCS code arthritis, CCS code cancer, CCS code diabetes. Rely on the information in the above Supplementary Material to guide the distributions you select.

## Week 5 (July 18 - July 22)

#### Git for Version Control and Collaboration

Git is a tool for version control, open science, and collaboration. We will use Git to work collaboratively on code and eventually publish our code so that other researchers can better understand and replicate our work.

You can use Git entirely through your computer's terminal, but it is generally easiest to get going with a desktop client that provides a nice user interface. Start by downloading [GitHub Desktop](https://desktop.github.com/), which will also install Git on your computer. Then complete the following tasks to get started:

* First, review the basics of Git (https://docs.github.com/en/desktop/installing-and-configuring-github-desktop/overview/getting-started-with-github-desktop, or https://www.youtube.com/watch?v=RPagOAUx2SQ may be good places to start)
* Next, `clone` this repository to your computer
* Finally, `commit + push` your simulation data code from last week to the `Code` folder

Post in our slack channel if you're encountering issues with Git!

#### Build the Risk Adjustment Simulation Data

Continue working on generating the five variables from last week's task if that is not complete. 

Let's now start considering the totality of variables that would need to be generated for a realistic set of simulated data. The predictor variables in the risk adjustment formula focus on documented sex, age, Medicaid status, and dozens of hierarchical condition categories (HCCs). You can get an estimate of the prevalence for the HCCs from [this document](https://www.cms.gov/research-statistics-data-and-systems/statistics-trends-and-reports/reports/downloads/pope_2000_2.pdf) (starting on Page 59 in Table 3-3). There is more than one way to generate large sets of correlated variables (i.e., variables that have a relationship which each other). We have learned about one way, where we generate the variable dependent on others, such as Y from Week 3's task. We can also use new functions like rmvbin. Explore this function as a pair (see [example](https://www.rdocumentation.org/packages/bindata/versions/0.9-20/topics/rmvbin) in the R documentation) and we will also discuss it in our meetings this week! Begin generating simulated HCC variables if you are ready! Please feel free to ask for additional guidance and direction in the slack channel.

## Week 6 (July 25 - July 29)

This week we will focus on wrapping up work on generating structured predictor variables for risk adjustment, including gaining experience with the `bindata` package and the `rmvbin` function. Then we will begin work on generating the outcome variable (healthcare spending). Concurently, spend time developing an abstract outline (due 7/29).

* Review the [summary paper](https://epub.wu.ac.at/286/1/document.pdf) and learn to use `rmvbin`, including understanding how to capture correlation structure through pairwise probabilities (`commonprob`) vs. a binary correlation matrix (`bincorr`). Practice with the brief [tutorial script](https://github.com/MarissaReitsma/AHEaD-2022/blob/main/Code/bindata_exploration.R).
* Finish generating code to simulate predictor variables:

	1) Simulate individual-level predictors (n = 100000) for documented sex, age, Medicaid status, and HCCs without a pre-specified correlation structure.
	2) Capture the correlation structure in the simulated data. Any correlations should be small and due to the randomness in the step 1 simulation, but this is okay because eventually we will use the code from this step on the real Medicare data that has structure.
	3) Re-simulate individual-level data, but supplying the correlation structure captured in step 2.	

## Week 7 (August 1 - August 5)

#### Risk adjustment, simulation design, regression, and R

Using the simulated data (including demographics, HCCs, and the healthcare spending outcome), evaluate different approaches to predict healthcare spending. Start with a linear regression. Recall the code from the regression lectures that you can modify (on canvas "AHEaDRegressonDemo.R"). After implementing the regression, continue to implementing an ensemble of algorithms, including machine learning algorithms and a linear regression. There is sample ensembling code using the SuperLearner package in the "AHEaDMLDemo.R" file on canvas that is also duplicated below. The sample code implements a linear regression, randomForest, and penalized regression (lasso). The algorithms the SuperLearner considers is in the line of code for SL.library. Compare and assess performance using 10-fold cross validation (this is built into the SuperLearner package for the individual algorithms), computing mean squared error and R^2.

If you have time:
* Consider what happens if you reduce the number of predictors included. Are there benefits to this?
* Change the SL.library to include one more algorithm. How does performance change, if at all?
* Does performance vary across different demographic groups?
* Which approach would you recommend to CMS, and why?

```r
##################################################################
##Sample ENSEMBLING Code!                                       ##
##Take a weighted average of multiple algorithms                ##
##################################################################
library(SuperLearner)

set.seed(27);n<-500
data <- data.frame(W1=runif(n, min = .5, max = 1),
W2=runif(n, min = 0, max = 1),
W3=runif(n, min = .25, max = .75),
W4=runif(n, min = 0, max = 1))
data <- transform(data, #add W5 dependent on W2, W3
W5=rbinom(n, 1, 1/(1+exp(1.5*W2-W3))))
data <- transform(data, #add Y
Y=rbinom(n, 1,1/(1+exp(-(-.2*W5-2*W1+4*W5*W1-1.5*W2+sin(W4))))))

barplot(colMeans(data))

#Specify a library of algorithms
SL.library <- c("SL.glm", "SL.randomForest", "SL.glmnet")

#Run the super learner to obtain final predicted values for the super learner
#as well as CV risk for algorithms in the library
fit.data.SL<-SuperLearner(Y=data[,6],X=data[,1:5],
	SL.library=SL.library, family=binomial(),
	method="method.NNLS", verbose=TRUE)

#CV risks for algorithms in the library
fit.data.SL

#Run the cross-validated super learner to obtain its CV risk
fitSL.data.CV <- CV.SuperLearner(Y=data[,6],X=data[,1:5], V=10,
	SL.library=SL.library, verbose = TRUE,
	method = "method.NNLS", family = binomial())

#CV risk for super learner
mean((data[,6]-fitSL.data.CV$SL.predict)^2)
```

## Week 8 (August 8 - August 12)

#### Wrap-up and presentation final preparations

We'll use Week 8 to do final preparations to present on your summer research. 

**Readings**

- Check out these twitter threads on [desigining effective slides](https://twitter.com/iamscicomm/status/1532531980398641164), [using colors](https://twitter.com/iamscicomm/status/1531651972776054785), and [using text](https://twitter.com/iamscicomm/status/1531766604626857989).







