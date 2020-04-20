Handwritten recognition is known as an important task that transforms a language from a raw form into digital format. This is one of the most important steps in machine learning nowadays since it allows us to explore more information created by human beings in our daily life. 

This project demonstrates how to read the handwritten digits and convert them into digital format with the help of machine learning. Logistic regression was firstly used to explore the dataset and KNN was the final model I used in this project with high predicting accuracy of 97%.

In the first section, I would use a simpler dataset from sklearn with a low resolution (8x8 pixel) and only around 1800 digits to train with. I would use logistic regression classification and K-nearest Neighbor classification (KNN) to compare their performance on predicting handwritten digits. We will find that KNN performs much better than the logistic model - KNN gives 99% accuracy in this data while logistic was 97.1%. 
In the second section, I would apply the K-nearest Neighbor model to train a more complicated dataset, the famous MNIST dataset, with a higher resolution (28x28 pixel) and larger data size (n=70000). The model gives a promising result with a 97% accuracy on testing data.

Programming language: Python
Read the full project with codings here

Section 1: Simple Digit dataset
This section used a simple dataset with 8x8 pixel. Logistic regression and K-nearest Neighbor classification are used to predict the handwritten digits.

Let's have a glance at our dataset. They are indeed in low quality (blurred) comparing to what we have seen and used in our daily life.



Logistic Regression
Logistic regression is one of the fundamental models in machine learning which fits the inputs in a regression formula and makes predictions by applying a sigmoid function over the result from the regression formula hence passing the result into decision boundary.
Testing  accuracy: 0.971
Logistic regression classifier gives 97% accuracy on testing data, which is considerably a decent result. 
Among 1800 digits, there were 13 digits were predicted wrongly by the classifier. Here's the error cases.

Error Cases


K-nearest Neighbor classification (KNN)
So now we will use KNN model to fit the dataset. By default parameters, 5 neighbors was used in the KNN model and it gives a 98.4% accuracy on testing data, which is higher than that from the logistic regression.
Training accuracy: 0.989  
Testing  accuracy: 0.984
To find the optimum value of K nearest neighbors, we can redo the model fitting with different values of k. As a result, we found that K = 3 gives the best result of recognising handwritten digits with 98.7% accuracy.
There were only 6 digits predicted wrongly among about 1800 digits!

Training accuracy: 0.993  
Testing  accuracy: 0.987
This is the classification report of KNN (k=3) model, the error cases are mostly related to '3','7','8' and '9'.


Error cases
Let's have a look of those 6 digits wrongly classified by KNN model among around 1800 digits.


Section 2: MNIST dataset
From the result of section 1, we believe that KNN classifier gives a better result in recognising handwritten digits.
Now, I will use a advanced dataset which has a larger data size and more detailed digits - 70000 digits with 28*28 pixel.

Data Preview
It is obvious to see that the digits in this dataset are in higher quality/resolution, which is closer to what we need to encounter in our daily life.


Result
By using the KNN classifier, it still gives a high accuracy on predicting the testing data (97%).
Training accuracy: 0.980  
Testing  accuracy: 0.970
Error cases
There are 529 digits predicted wrongly by KNN model. Here are some examples of those misclassified cases.



Summary
In this project, we are able to recognise handwritten digits by KNN classification with a high accuracy (97%).
However, there is no absolute perfect model that can suit all scenario. Instead, it depends on the situations and type of problem that we are handling with.
In this handwritten digits recognition, it seems that KNN gives a much better result over the traditional parametric projection (logistic regression). This is understandable because it is just like how we understand the handwritten language. We tend to find the patterns in the handwritten language and relate them to similar patterns that we have seen or learned according to our memory. For example, when we see a digit with two 'o's, we will normally relate it as '8'. This is similar to the mechanism of KNN classifier as it also looks for feature similarity and pick the result of majority.
