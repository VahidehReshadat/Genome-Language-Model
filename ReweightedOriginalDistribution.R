
#--------------------------------------------Prediction (Original)----------------------------------------------
          library(keras)
          library(stringr)
          
          source("Utilities.R")
          source("Embedding.R")
          

          RewghtPredictNextCharacter <- function(preds, temperature) {
          preds <- as.numeric(preds)
          preds <- log(preds) / temperature
          exp_preds <- exp(preds)
          preds <- exp_preds / sum(exp_preds)
          which.max(t(rmultinom(1, 1, preds)))
          }
          
          
          ReweightedPredictNextCharacter <-function(inputTxt, nEpoches, mModel, x, y, seqLen, chrs){
          
          for (epoch in 1:nEpoches) {
          
          cat("epoch number:", epoch, "\n")
          
          # Fitting the model on all data portions (x & y)
            mModel %>% fit(x, y, batch_size = 128, epochs = 1) 
          
          initialTxt <- inputTxt
          initialTxt <- tolower(initialTxt)
          
          cat("\n Reweighting the output for:", initialTxt, "\n\n")
          
          for (randomRate in c(2, 1.2, 1.0, 0.5, 0.2, 0.01)) {
            
          # generating character while the next char is a point-character
          nxt_char <-""
          
          sampl = xOneHotVec(initialTxt, seqLen, chrs)
          predis <- mModel %>% predict(sampl, verbose = 0)
          
          for (i in 1:length(chrs)) { 
          cat(chrs[i], ":  ",  predis[i], "\n")
          }
          
          cat("The next character based on original weights is:", chrs[[which.max(predis[1,])]], "\n")
          
          cat("Predicting based on randomness\n","Randomness Rate:", randomRate, "\n")
          
          cat(initialTxt, "\n")
              
          nextTxt <-initialTxt
          
          while(nxt_char != ".") {
          
          smpl = xOneHotVec(nextTxt, seqLen, chrs)
          
          preds <- mModel %>% predict(smpl, verbose = 0)
          nxtCandidCh <- RewghtPredictNextCharacter(preds[1,], randomRate)
          nxt_char <- chrs[[nxtCandidCh]]
          
          nextTxt <- paste0(nextTxt, nxt_char)
          nextTxt <- substring(nextTxt, 2)
          
          cat(nxt_char)
          }
          cat("\n\n")
          }
          }
          }

          