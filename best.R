## Find the best hospital in a given state based on a given outcome

best<-function(state, outcome){
        ## Read outcome data ##
        
        dat <- read.csv("outcome-of-care-measures.csv", colClasses = "character", header=TRUE)
       
        ## Data Cleaning ##
        
        ## Create new data frame from combining relevant columns
        datClean   <- as.data.frame(cbind(dat[, 2],   
                                    dat[, 7],   
                                    dat[, 11],  
                                    dat[, 17],  
                                    dat[, 23]), 
                              stringsAsFactors = FALSE)
        
        ## Rename columns in "datClean" with colnames corresponding to arguments of best()
        colnames(datClean) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        ## Check validity of arguments ##
        
        if(!state %in% datClean[, "state"]){
                stop('invalid state')
        } else if(!outcome %in% c("heart attack", "heart failure", "pneumonia")){
                stop('invalid outcome')
        } else {
                
                ## Evaluate data given input ## 
                
                ## Select rows only in which "state" matches with user specified "state"
                datChosen <- datClean[which(datClean[, "state"] == state), ]
                
                ## Get rid not "Not Available" objects to avoid warning message
                datChosen <- datChosen[which(datChosen[, outcome] != "Not Available"), ]

                ## Convert Selected outcomes into numerics
                datChosen[, outcome] <- as.numeric(datChosen[, outcome])
                
                ## Order elements by outcome smallest to largest, then by States alphabetically
                datChosen <- datChosen[order(datChosen[, outcome], datChosen[, "state"]), ]
                
                ## Determine best hospital as first in the dataframe 
                output <- datChosen[, "hospital"][1]
        }
        return(output)
}
