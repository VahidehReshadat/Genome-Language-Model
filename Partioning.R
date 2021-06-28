       
# ---------------------------------------Test and Train Data Partitioning--------------------------------------------

        library(stringr)
        
        dataPartitioning <- function(xdata, ydata, seqsdata, seqLendata, chrsdata) {
        
        train=xdata[1:(as.integer(0.8*length(seqsdata))), 1:seqLendata, 1:length(chrsdata)]
        trainLabels=ydata[1:(as.integer(0.8*length(seqsdata))), 1:length(chrsdata)]
        
        trainLabels
        
        test=xdata[(as.integer(0.8*length(seqsdata))+1):length(seqsdata), 1:seqLendata, 1:length(chrsdata)]
        testLabels=ydata[(as.integer(0.8*length(seqsdata))+1):length(seqsdata), 1:length(chrsdata)]
        
        testLabels
        
        return(list(train, trainLabels ,test, testLabels))
        }
