# Handwritten Digit Recognition II - Neural Network Model
In the first part of the handwritten digit recognition, I have used several 'shallow' learning - logistic regression, SVM, random forest and K-nearest neighbour to read the handwritten digits. The best result was 97% given by K-nearest neighbour model with almost 2 hours running time.

Although KNN gives a great result on the digit prediction, it requires a long running time to read the digits. It is due to the mechanism of KNN where for every data (digit), it has to compare with all the data existing in the dataset to find out the nearest k neighbours. It will take a long running time especially when the dataset is huge.

In this project, I would further investigate the method to read handwritten digits in deep learning - Convolutional Neural Network.

## Convolutional Neural Network 
Convolutional Neural Network (CNN) is one type of neural network models. It is proven strong to deal with image recognition and classification. It expects input in the form of the matrix, therefore images are suitable in this case. It firstly zooms the images into a smaller level - we called this step Convolution. Between each zooming, some actions can be done to extract features from the sub-images during each zooming - this is called Pooling. Hence, these zoomed sub-images are then connected to form a neural network to perform the optimization to find the best parameters to predict/ classify the images. The following picture illustrates the basic idea of Convolutional Neural Network model. 
![CNN illustration](http://www.wildml.com/wp-content/uploads/2015/11/Screen-Shot-2015-11-07-at-7.26.20-AM.png)

# Data Loading and preprocessing
Keras library also contains the mnist handwritten digits dataset so we can easily import by keras.

The data in Keras library contains 70000 digits with labels of digits that they are represented.

Let's have a look of some of the digits.

![digits]()

Before starting the CNN model, the dataset needs to be restructured for the model. They will be reshaped in from (28x28) to (28x28x1) where one is representing the greyscale of their colour.

The images are represented by 28x28 pixels with values of 0 to 255 to represent the colour of each of the pixel.

The value ranging from 0 to 255 will also be rescaled into 0 to 1 by dividing by 255 - we called this Pixel Normalization. This move lowers the value size in our data and it can prevent the huge number driving the model away and also reduce the impact of noise.

For the target labels, they are represented by numbers from 0-9. However, in the CNN model, we expect the target variable in the form of matrix. In this case, each numerical value should be represented by a matrix with a length of 10. For example, [1,0,0,0,0,0,0,0,0,0] represents 0 and [0,0,0,1,0,0,0,0,0,0] represents 3.

Therefore, it will be transformed by using the utility function np_utils from keras library.

# Build the Convolutional Neural Network model
From the experience of previous shallow learning, the handwritten digits can be easily read with high accuracy. Therefore, it is reasonable to suggest that CNN would not require a highly complicated network.

To illustrate the CNN model, I will use a 3-layer CNN model.

With around 45 mins training time, the Convolutional Neural Network model gives 98.7% on validation data. The graph below also shows the accuracy and loss during the model training.

![CNN_result]()

So now, we can use this trained CNN model to test our data. It takes around 8 seconds to read through 10000 digits with 98.7% accuracy!

There are 133 among 10000 testing data are classified into wrong classes. Let's take a look at those wrongly classified images and see if they are reasonable.

![wrong]()

# Summary
Convolution Neural Network model is a strong model to handle images data. It can read the handwritten digits with a promising 98.7% accuracy, which is higher than Logistic regression and K-nearest neighbour classification from the previous project.

CNN requires some time to train the model - 45 mins for 60000 of 28*28 pixel images. However, it takes only a short period to predict new images with a built model - 8s for 10000 images.

**Convolution Neural Network vs K-nearest Neighbor**

Both models give high accuracy towards reading handwritten digits. However, CNN requires a short period to predict a new image while KNN would take a huge time to do so. It is because in KNN, every new item needs to compare with all existing data in the dataset. It takes significantly longer time especially when the data size is huge.
