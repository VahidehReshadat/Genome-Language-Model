        
        # -----------------------------------------Fitting the model----------------------------------------------------------
        library(keras)
        library(stringr)
        
        
        fittingModel <- function(mModel, xLbls, yLbls, nEpoches, nBatch, validSplit) {
          
          history <- mModel %>%
            fit(xLbls,
                yLbls,
              epochs = nEpoches,
              batch_size = nBatch,
              validation_split = validSplit)
        
        return(history)
        }
        
        
        LossAcc <- function(myModel, xLabels, yLabels) {
        
          myModel %>% evaluate(xLabels, yLabels)
        pred <- myModel %>% predict_classes(xLabels)
        
        return(pred)
        }
        
        
        
        calConfusion <- function(prdict, triny, sequns) {
          
            table(Predicted = prdict, Actual = triny)
          }
        
        
        
        probDist<-function(mModel, xLbels, prdct, trin, sequs){
          
          probi <- mModel %>% predict_proba(xLbels)
          cbind(probi, Predicted_class = prdct, Actual = trin)
          
        }
        
