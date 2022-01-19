# GenoLM: Genome-Language-Model 
## An Attention-based LSTM Neural Model for Predicting DNA Sequences

A Genome Neural Language Model for DNA sequencing that determins the order of nucleic acid sequence by predicting the next nucleotides in DNA.
The goal is to predict the next nucleotide by using the current nucleotides. I trained an attention-based LSTM model to predict the next token or next few tokens in the nucleic acid sequence using the previous tokens as input. The network is trained to generate the most possible (n+1)-th nucleotide regarding the input sequence of n nucleotides. 

## Overview
The R implementation of GenoML 

## Requirements
Requirements: R (3.6+), Keras

## Implementation

The content of the main.R file is as the follow.

**Libraries**
*library(keras)*: For deep learning
*library(stringr)*: For working with strings

Sources
It contains sources for applying different functions.
source("Embedding.R") : For embedding the input
source("Partioning.R") : For portioning the data
source("Building.R") : For building the neural network model
source("Utilities.R"): For some practical functions 
source("OriginalDistributionSoftmax.R") : For predicting the next character based on the original distribution
source("ReweightedOriginalDistribution.R"): For predicting the next character based on the refined distribution

Data Preparation and Preprocessing: The more the data, the efficient is the deep neural language model. First, the text data is loaded and converted to lowercase. Then the variables are defined and initialized.

Embedding
There are various embedding approaches for vectorizing the input. One-hot vector representation is the simplest and the most widely used method. It encodes the data into binary arrays. xOneHotVec and yOneHotVec fill two array x and y. x is a 3-dimensional array consisting of all sequences, their length and unique characters. y is a 2-dimensional array with all sequences and the vector representation of the characters appear after them.

 xOneHotVec(seqs, seqLen, chrs) 
 yOneHotVec(seqs, chrs) 

Test and Train Data Partitioning
The x and y arrays are partitioned as train and test data. 80% of data considered as train data and the rest is considered as test data.

 dataPartitioning(x, y, seqs, seqLen, chrs)

Building the neural network model
The LSTM network is built and compiled. Softmax is used as a probability distribution over all possible characters. categorical_crossentropy is applied as the loss for training the model due to using one-hot encoding.

 BuildingModel(128, 0.2, seqLen, chrs, 0.002)




Fitting the model
The model is trained on the train data and 20% of the train data is used as the validation set. Two plots are created based on the iterations which show the loss and accuracy of the training and validation data over epochs. The visualize model of training history for accuracy and loss also are created.

  fittingModel(myModel, trainxx, trainyy, 32, 16, 0.2)


Evaluating
Training data evaluation
-Training data loss and accuracy are calculated and shown.
-Confusion matrix for training data samples is shown. The first row is for actual classes and the first column is for the predicted classes. The other values show the indexes of the character
- The predicted probability distribution for each training data sample over each class is shown.
  LossAcc(myModel, trainxx, trainyy)  
    calConfusion(predLossAccTrain, traintrainy, seqs)
    predictedDistributionTrain= probDist(myModel, trainxx, predLossAccTrain, traintrainy, seqs)

Test data evaluation
The same functions are also used for evaluating the test data. 

Predictions
This function takes a sequence with the size of seqLen () and generates the next character with high probability.  For some epochs, the model is fitted with the whole dataset and after embedding, it prints the probability distributions over the output classes and chooses the most probable character and prints it. This procedure is continued while it gets the point character (.). 
For instance, the function is called by “This is a ”, a sequence of 10 characters.

    PredictNextCharacter("This is a ", 6,  myModel, x, y, seqLen, chrs)

