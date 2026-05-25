rankall <- function(outcome, num = "best") {
   ## Read outcome data
   data <- read.csv("outcome-of-care-measures.csv", 
                    na.strings = "Not Available", 
                    colClasses = "character")
   
   ## Check outcome are valid
   valid_outcome <- c("heart attack", "heart failure", "pneumonia")
   outcome_cols <- c(
      "heart attack"  = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
      "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
      "pneumonia"     = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
   )
   
   if(!outcome %in% valid_outcome){
      stop("invalid outcome")
   }
   
   ## data preparation
   outcome_col <- outcome_cols[outcome]
   sub_data <- data[, c("State", "Hospital.Name", outcome_col)]  # Note: "State" not "state"
   colnames(sub_data) <- c("state", "hospital", "outcome")
   sub_data$outcome <- as.numeric(sub_data$outcome)
   sub_data <- sub_data[!is.na(sub_data$outcome), ]
   
   ## Define helper function before using it
   get_hospital <- function(state_data, num){
      # Order by outcome rate, then hospital name
      state_data <- state_data[order(state_data$outcome, 
                                     state_data$hospital), ]
      n <- nrow(state_data)
      
      # Handle different num values
      if (num == "best") {
         idx <- 1
      } else if (num == "worst") {
         idx <- n  # Fixed typo
      } else if (is.numeric(num) && num >= 1 && num <= n) {
         idx <- as.integer(num)
      } else if (is.numeric(num)) {
         return(NA)  # num is numeric but out of range
      } else {
         stop("invalid num argument")  # num is not "best", "worst", or numeric
      }
      
      return(state_data$hospital[idx])  # Use idx, not num
   }
   
   ## sort the abbreviated state name
   states <- sort(unique(sub_data$state))
   result <- data.frame(hospital = character(length(states)),
                        state = states,
                        stringsAsFactors = FALSE)
   
   ## Use helper function to get final result
   for(i in seq_along(states)){
      state_data <- sub_data[sub_data$state == states[i], ]
      if(nrow(state_data) == 0){
         result$hospital[i] <- NA  # Use index i
      } else {
         result$hospital[i] <- get_hospital(state_data, num)  # Use index i
      }
   }
   
   ## Return a data frame with the hospital names and 
   ## the (abbreviated) state name
   return(result)
}