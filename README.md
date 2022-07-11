# AHEaD-2022

## Improving Equity for Health Care Payments

*Faculty Mentor*: Sherri Rose, [sherrirose@stanford.edu](mailto:sherrirose@stanford.edu) </br>
*Near-Peer Mentor*: Marissa Reitsma, [mreitsma@stanford.edu](mailto:mreitsma@stanford.edu)

## Table of contents
- [Week 1](#week-1-june-21---june-24)
- [Week 2](#week-2-june-27---july-1)
- [Week 3](#week-3-july-5---july-8)
- [Week 4](#week-4-july-11---july-15)
- [Weeks 5-7](#weeks-5-7-july-18---august-5)
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
3) Discuss whether the model satisfies the four assumptions of generalized linear models (include plots if appropriate).
4) What happens when you increase or decrease your simulation data sample size? 
5) Explore how alternative model specifications (both which covariates are included and which response distribution is specified) change the model fit.

##### Build the Risk Adjustment Simulation Data

Read more about the Medicare risk adjustment formula and data in the Supplementary Material of Zink & Rose (2021) [here](https://informatics.bmj.com/content/bmjhci/28/1/e100414.full.pdf?with-ds=yes).

Select five variables to start with to generate.

## Weeks 5-7 (July 18 - August 5)

#### Risk adjustment, simulation design, regression, and R

These weeks will focus on further understanding existing approaches for risk adjustment, learning more about and then designing simulated data, and implementing regression and machine learning approaches in R. We will add more specifics each week as we progress through the tasks.

## Week 8 (August 8 - August 12)

#### Wrap-up and presentation final preparations

We'll use Week 8 to do final preparations to present on your summer research. 

**Readings**

- Check out these twitter threads on [desigining effective slides](https://twitter.com/iamscicomm/status/1532531980398641164), [using colors](https://twitter.com/iamscicomm/status/1531651972776054785), and [using text](https://twitter.com/iamscicomm/status/1531766604626857989).







