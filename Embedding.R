        
        
# --------------------------------------------Embedding---------------------------------------------------
        
        xOneHotVec <- function(xsequens, sequncLen, nchrs) {
          
          xvec <- array(0L, dim = c(length(xsequens), sequncLen, length(nchrs)))         
        
          for (i in 1:length(xsequens)) {                                           
            sentence <- strsplit(xsequens[[i]], "")[[1]]                           
            for (t in 1:length(sentence)) {                                          
              char <- sentence[[t]]                                                  
              xvec[i, t, chrInd[[char]]] <- 1                                     
            }                                                                        
          } 
          
          return(xvec)
        }
        
        
        yOneHotVec <- function(ysequens, ch) {
          
          yvec <- array(0L, dim = c(length(ysequens), length(ch))) 
          
          for (i in 1:length(ysequens)) {                                           
            next_char <- nxChrs[[i]]                                             
            yvec[i, chrInd[[next_char]]] <- 1                                    
          } 
          
          return(yvec)
        }
        
      
