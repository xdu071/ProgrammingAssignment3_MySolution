## Finding hospitals in every state given outcome and ranking AKA "num"

rankall <- function(outcome, num = "best") {
        ## Read outcome data ##
        
        dat <- read.csv("outcome-of-care-measures.csv", colClasses = "character", header = TRUE)
        
        ## Data Cleaning ##
        
        ## Store only relevant columns from outcome data
        datClean <- as.data.frame(cbind(dat[, 2],
                                        dat[, 7],
                                        dat[, 11],
                                        dat[, 17],
                                        dat[, 23]),
                                  stringsAsFactors = FALSE)
        
        colnames(datClean) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
        
        ## Check Validity of Arguments ##
        
        if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
                stop('invalid outcome')
        } 
                
        ## Evaluate table given inputs ##
                
        ## Remove row values as "Not Available"
        datClean <- datClean[which(datClean[, outcome] != "Not Available"), ]
        
        ## Turn outcome values into numerics
        datClean[, outcome] <- as.numeric(datClean[, outcome])
        
        ## Keep only hospital, state, and specified outcome 
        datClean <- datClean[, c("hospital", "state", outcome)]
        
        ## Create a list of data.frames of same structure split by 50 states 
        ## AKA 50 data.frames
        dat_byState <- with(datClean, split(datClean, state))
        
        ## Create empty data.frame for storing hospitals and states of given rank
        output <- data.frame()

        ## Evaluate data given "num"
        if (num == "worst") {
                ## Iterate through list (using a vector of row numbers from dat_byState)
                for (i in seq_along(dat_byState)) {

                        ## In each data.frame, order hospitals from worst to best
                        dat_byState[[i]] <- dat_byState[[i]][order(dat_byState[[i]][, outcome],
                                                                   dat_byState[[i]][, "hospital"],
                                                                   decreasing = TRUE), ]
                        
                        ## Select 1st hospital and state from each data.frame and store in "output"
                        output <- rbind(c(dat_byState[[i]][1, "hospital"], 
                                          dat_byState[[i]][, "state"][1]), output)
                        
                }

        } else if (num == "best") {
                for (i in seq_along(dat_byState)) {
                        
                        ## In each data.frame, order hospitals from best to worst
                        dat_byState[[i]] <- dat_byState[[i]][order(dat_byState[[i]][, outcome],
                                                                   dat_byState[[i]][, "hospital"]), ]
                        
                        ## Select 1st hospital and state from each data.frame and store in "output"
                        output <- rbind(c(dat_byState[[i]][1, "hospital"], 
                                          dat_byState[[i]][, "state"][1]), output)
                }
                
        } else {
                for (i in seq_along(dat_byState)) {
                        
                        ## In each data.frame, order hospitals from best to worst
                        dat_byState[[i]] <- dat_byState[[i]][order(dat_byState[[i]][, outcome],
                                                                   dat_byState[[i]][, "hospital"]), ]
                        
                        ## Select "num"th hospital and state from each data.frame and store in "output"
                        output <- rbind(c(dat_byState[[i]][num, "hospital"], 
                                          dat_byState[[i]][, "state"][1]), output)
                }
        }
        
        colnames(output) <- c("hospital", "state")
        
        ## Order elements in "output" by state alphabetically
        output <- output[order(output[, "state"]), ]
        
        return(output) 
}


