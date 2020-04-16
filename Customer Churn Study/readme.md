# Customer Churn
Customer Churn, also known as customer attrition and customer turnover, refers to the loss of the customer.
Many competitive contract-based services such as internet and telephone providers, banking, TV and insurance often use this analysis to study and predict the behaviour of customers such that they can develop programs to retain their customers.

# Objective
This project studies the customer churn based on the services they have signed up, customer account information and their demographic. The first objective of this project is to investigate which factors give the most impact on customer churn. The second objective is to predict whether the customer would quit the service based on various models.

# Data Source
The dataset used in this project is from Kaggle. The dataset includes 4 types of information:
Customers who left within the last month
Services that customers have signed up for including phone, multiple lines, internet, etc.
Customer account information including contract status, payment method, monthly charges and total charges.

##### Programming environment: Python
Read the full report with codings here

# Exploratory Data Analysis
Exploratory data analysis (EDA) is an approach to analysing data sets to summarise their main characteristics with visual methods. It is generally used as a primary mean to research and investigate the dataset, before performing advanced modelling.

## Numeric Data
Boxplot is one of the good approaches to understand numeric data since it provides the information of range, median, quantiles and distribution.



## Categorical Data
Now let's produce charts to visualise the data. Since most of the categorical values contain only a few distinct values, we will use donut charts to visualise their patterns.

The variable SeniorCitizen appears to be a numeric column while we check the summary table above. However, it only consists of two values, 0 and 1, identifying whether the customer is a senior citizen or not. Therefore, it actually is a categorical variable and can be visualised by a donut chart.













The following donut charts show the pattern of the rest of the categorical variables. 
We can see the gender split is half-half, similar to the partnership. For the contract status, more than half of the customers are in Month to month contract, which is considered as a high correlated factor driving customer churn in the next part.


## Correlation Matrix
We can easily build a correlation matrix since the preprocessed data are all in numeric values. 
One of the method to visualise the correlation matrix is by using a heatmap. The following heatmap from seaborn library displays the relationship between variables.


However, it is not an easy task to read the correlation heatmap when the amount of variables is considerably large. Instead, we can simply look at the top correlated variables to our target variable, 'Churn' in a bar chart.




We can observe that the top factor relating to Churning is when the customer is under a month to month contract. This is understandable since contracts in month to month have the highest flexibility hence they are easier for customers to turn down and switch to other providers.
The second relating factor would be 'tenure', which is representing the number of months the customer has stayed with the company. When we check the relationship of this variable against churn from the heatmap or correlation table, we can find that it is negatively correlated to the churn. This is also easy to explain the story that customers with larger 'tenure' values mean they are having more stable jobs, hence they also tends to stay in their telecom service.

# Predictive Modelling

## Logistic Regression
The first predictive model we use is logistic regression. Logistic regression is trained in a similar way as linear regression, using the factors as input in a regression equation to calculate the output (Output ~ factor_1 + factor_2 + ...).
However, we will pass the output from the regression equation into a sigmoid function, which makes the result bounds between 0 to 1. This allows us to perform classification when we set a boundary so that all values below the boundary are categorised as 0 and the rest will be as 1.








#### Result
Logistic regression gives 80% accuracy on testing data. 


## SVM (Support Vector Machines)
The basic idea of Support Vector Machines is to find an optimum hyperplane to divide the dataset into two classes, as illustrated by the picture below.


By default, a linear hyperplane is used to divide the dataset. However, in some complicated dataset, other forms of hyperplane may be required such as polynomial hyperplane. In those cases we will use other kernels to train the model, for example sigmoid, rbf, polynomial, etc.

In this project I will use four different kernels to train the model. The result is shown as below.

The model spent most of the time to train the polynomial hyperplane as it carries a higher complexity. However, we can see that the SVM with linear hyperplane gives the highest testing accuracy, which indicates that the dataset itself is not structured in high complexity.

## K-nearest Neighbors Classification (KNN)
KNN is one of the famous non-parametric algorithm, which may not require any parameters to build the algorithm. It focuses on the feature similarity, which aims to find out the most similar data to perform classification or regression. 
For a simple example, if I would like to make a decision based on my body characteristics. KNN algorithm will first find out a few people with similar characteristics with me (height, weight, gender,...) and base on their decisions to predict my decision.
The image below illustrate how can we find the nearest neighbors and categorise the new item (star) as class B as two of its neighbor are in Class B.


By using different nearest neighbors in the KNN algorithm, we can find the best value to produce the largest testing accuracy.


This best K value to predict customer churn is 11, with testing accuracy 79.7%

## Decision Tree Classifiers
A decision tree is a decision support tool that uses a tree-like model of decisions and their possible consequences, including chance event outcomes, resource costs, and utility. It is one way to display an algorithm that only contains conditional control statements.

The following part investigates how the maximum depth limitations affect the training and testing performance and hence suggests the best setting for the model.


### Draw the tree
We can also visualise the tree by using export_graphviz in sklearn library.




## Random Forest
Random forest is built by repeating the decision tree algorithm but with random bags of features selected in each of the trees instead of all features used during the decision tree algorithm. In this way, we can the decision tree overfitting by only of the key features.
Similar to the decision tree, we can set different values or maximum depth and find the optimum depth out.



# Model Comparison
Let's summarise all the models we have developed, together with their training and testing accuracy.




Random Forest gives the best performance to predict customer churn among all models with 80.6%.

# Conclusion
In this project, we have explored the customer churn data and built several models to classify whether will the customers discontinue the service. From the first part (EDA), we can find the top factors driving the customers churn, namely the contract status and tenure length. In the second part (Predictive Modelling), we are able to predict the customers who would potentially terminate the service with an accuracy of 80.6% by using random forest classification.
