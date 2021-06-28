
#--------------------------------------------Prediction (Original)----------------------------------------------
      library(keras)
      library(stringr)
      
      source("Utilities.R")
      source("Embedding.R")


      OrginalPredictNextCharacter <- function(preds) {
        which.max(preds)
      }
      
      
      PredictNextCharacter <-function(inputTxt, nEpoches, mModel, x, y, seqLen, chrs){
        
        for (epoch in 1:nEpoches) {
          
          cat("epoch number:", epoch, "\n")
          
          # Fitting the model on all data portions (x & y)
          mModel %>% fit(x, y, batch_size = 128, epochs = 1) 
          
          initialTxt <- inputTxt
          initialTxt <- tolower(initialTxt)
          
          cat("\nWeighting the output for:", initialTxt, "\n\n")
          cat(initialTxt, "\n")
          
          # generating character while the prediction is point-character
          nxt_char <-""
          
          sampl = xOneHotVec(initialTxt, seqLen, chrs)
          predis <- mModel %>% predict(sampl, verbose = 0)
          
          for (i in 1:length(chrs)) { 
            cat(chrs[i], ":  ",  predis[i], "\n")
         }
          
          cat("The next character is:", chrs[[which.max(predis[1,])]], "\n")
          
          nextTxt <-initialTxt
          
          while(nxt_char != ".") {
            
            smpl = xOneHotVec(nextTxt, seqLen, chrs)
            
            preds <- mModel %>% predict(smpl, verbose = 0)
            nxtCandidCh <- OrginalPredictNextCharacter(preds[1,])
            nxt_char <- chrs[[nxtCandidCh]]
            
            nextTxt <- paste0(nextTxt, nxt_char)
            nextTxt <- substring(nextTxt, 2)
            
            cat(nxt_char)
          }
          cat("\n\n")
         
        }
      }
      
