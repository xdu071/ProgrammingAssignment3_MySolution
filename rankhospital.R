## Find hospital given state, outcome, and its ranking AKA "num"

rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data ##
        
        dat <- read.csv("outcome-of-care-measures.csv", colClasses = "character", header = TRUE)
        
        ## Data Cleaning ##
        
        ## Create new dataframe by combining relevant columns
        datClean <- as.data.frame(cbind(dat[, 2],
                                         dat[, 7],
                                         dat[, 11],
                                         dat[, 17],
                                         dat[, 23]),
                                   stringsAsFactors = FALSE)
        colnames(datClean) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        ## Check validity of arguments ##
        
        if(!state %in% datClean[, "state"]) {
                stop('invalid state')
        } else if(!outcome %in% c("heart attack", "heart failure", "pneumonia")){
                stop('invalid outcome')
        } else if(!num %in% c("best", "worst") && is.numeric(num) != TRUE){
                stop('invalid num')
              
        } else {
                
                ## Evaluate table given input ##
                
                ## Select rows elements only in which "state" matches with user specified "state"
                datChosen <- datClean[which(datClean[, "state"] == state), ]
                
                ## Get rid not "Not Available" objects to avoid warning message
                datChosen <- datChosen[which(datChosen[, outcome] != "Not Available"), ]
                
                ## Turn outcomes to numeric values
                datChosen[, outcome] <- as.numeric(datChosen[, outcome])
                
                ## Order hospitals in state first by outcome, second by hospital name
                datChosen <- datChosen[order(datChosen[, outcome], datChosen[, "hospital"]), ]

                ## Define output as hospital name given relevant "num"
                if (num == "worst") {
                        output <- datChosen[, "hospital"][nrow(datChosen)]
                } else if (num == "best") {
                        output <- datChosen[, "hospital"][1]
                } else {
                        output <- datChosen[, "hospital"][num]
                }
        }
        return(output)
}