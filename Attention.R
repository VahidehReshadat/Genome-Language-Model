
# An Attention Layer Function based on the paper "Attention-based Bidirectional Long Short-Term Memory
#                                           Networks for Relation Classification

# ---------------------------------------------Attention----------------------------------------------


      AttentionLayer <- function(numChars, sequenceLength, hiddenLayerDistri) {    
        
                                      m=tanh(hiddenLayerDistri)
                                      w=t(runif(37))
                                      wtm=w %*% m
                                      wtm  
                                      ww=c(wtm)
                                      predicts <- as.numeric(wtm)
                                      exp_predicts <- exp(predicts)
                                      b <- exp_predicts / sum(exp_predicts)
                                      a <-matrix(c(b), nrow = 1)
                                      a=t(a)
                                      rAtt=hiddenLayerDistri %*% a
                                      h_att=tanh(rAtt)
                                      h_att
                                      return(h_att)   
            
                                 }
    
      
      # Calling attention function by an artificial random sample
        
      hidLy=matrix(c(runif(370)), nrow=37, ncol=10)
      hAttention=AttentionLayer(37, 10, hidLy) 
      hAttention
      


      