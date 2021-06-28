
# A charachter-based languagae model using LSTM -  Helmholtz Center for Infection Research


    # Loading Libraries & Sources

      library(keras)
      library(stringr)
      
      source("Embedding.R")
      source("Partioning.R") 
      source("Building.R") 
      source("Utilities.R")
      source("OriginalDistributionSoftmax.R")
      source("ReweightedOriginalDistribution.R")




# --------------------------------------Data Preparation and Preprocessing-------------------------------
 
      # Loading Data

      fileName <- ("data/Text")
      txt <- tolower(readChar(fileName, file.info(fileName)$size))


     # Preprocessing
      
      seqLen <- 10
      ovrlpDif <- 3
      
      cat("Initializing....\n")                                                  
      seqIndx <- seq(1, nchar(txt) - seqLen, by = ovrlpDif)
      seqs <- str_sub(txt, seqIndx, seqIndx + seqLen - 1)      
      nxChrs <- str_sub(txt, seqIndx + seqLen, seqIndx + seqLen)  
      chrs <- unique(sort(strsplit(txt, "")[[1]]))                             
      chrInd <- 1:length(chrs)                                            
      names(chrInd) <- chrs
      trainy <- array(0L, dim = c(1, length(nxChrs)))
      for (i in 1:length(nxChrs)) { 
        next_ch <- nxChrs[[i]]  
        trainy[1, i] <- as.numeric(chrInd[[next_ch]])
      }                                      
      
      cat("Number of sequences in the corpus is: ", length(seqs), "\n")
      cat("Number of alphabets in the corpus is: ", length(chrs), "\n")
      
      
# --------------------------------------------Embedding---------------------------------------------------
      
     # Embedding
      
       cat("One-hot encoding input...............\n")      
       x=xOneHotVec(seqs, seqLen, chrs) 
       
       cat("One-hot encoding output..............\n")                                                
       y=yOneHotVec(seqs, chrs) 
      
#--------------------------------------------Test and Train Data Partitioning-----------------------------
      
     # Data Partitioning

       mydata= dataPartitioning(x, y, seqs, seqLen, chrs)
       trainxx=mydata[[1]]
       trainyy=mydata[[2]]
       testxx=mydata[[3]]
       testyy=mydata[[4]]

#-----------------------------------------building the model----------------------------------------------
      
      
     # Building the Model  
       
       cat("Building the Model.........\n")                                                
       
       myModel=BuildingModel(128, 0.2, seqLen, chrs, 0.002)
       
       summary(myModel)
      
#-----------------------------------------Fitting the model----------------------------------------------
      
     # Fitting the model 
       
       cat("Training the Model.........\n")                                                
       
       modelHistory=fittingModel(myModel, trainxx, trainyy, 32, 16, 0.2)

       plot(modelHistory)
      
  
#-----------------------------------------------Evaluation------------------------------------------------
   
     
     # Train data Evaluation  
 
      cat("Training Data Evaluation.......\n")                                                
      cat("Loss and Accuracy (Training Data ): \n")  
     
      
     # Training Data- (accuracy and loss)  & Prediction   
      
    
      
       predLossAccTrain=LossAcc(myModel, trainxx, trainyy)  
       predLossAccTrain
       
       traintrainy=trainy[1:1,1:(as.integer(0.8*length(seqs)))]-1
       traintrainy
       
       
     # Training Data- confusion matrix 
       cat("Confusion Matrix: (Training Data )\n") 
    
       predConfiusionTrain=calConfusion(predLossAccTrain, traintrainy, seqs)
       predConfiusionTrain
    
    # Training Data-predicted probability distribution for each training data sample on each class
       cat("probability distribution over classes: (Training Data )\n") 
    
       predictedDistributionTrain=probDist(myModel, trainxx, predLossAccTrain, traintrainy, seqs)
       predictedDistributionTrain
   
       
    # Test data Evaluation  
   
       cat("Test Data Evaluation...\n")  
       cat("Loss and Accuracy (Test Data ): \n") 
   
       predLossAccTest=LossAcc(myModel, testxx, testyy)
       predLossAccTest
   
   
       testrainy=trainy[1:1,(as.integer(0.8*length(seqs))+1):length(seqs)]-1
       cat("Confusion Matrix: (Test Data )\n") 
       predConfiusionTest=calConfusion(predLossAccTest, testrainy, seqs)
       predConfiusionTest
   
       cat("probability distribution over classes: (Test Data )\n") 
       predictedDistributionTest= probDist(myModel, testxx, predLossAccTest, testrainy, seqs)
       predictedDistributionTest

   
#-------------------------------------------------Prediction----------------------------------------------
  
       
       #the functions terminate while they get a point charachter
       # The prediction chrachter is space most of the time (predicting class 0), due to using a tiny data set.
       # By using randomness the ReweightedPredictNextCharacter generates the next charachter to be something  other than space.
      
       
       ReweightedPredictNextCharacter("This is a ", 6, myModel, x, y, seqLen, chrs)
       PredictNextCharacter("This is a ", 6, myModel, x, y, seqLen, chrs)
       

   

