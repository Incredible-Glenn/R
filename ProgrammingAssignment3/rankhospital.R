rankhospital <- function(state, outcome, num = "best"){
      
   ## Read outcome data
   data <- read.csv("outcome-of-care-measures.csv",
                     na.strings = "Not Available",
                     colClasses = "character")
   ## Check that state and outcome are valid
   valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
   outcome_cols <- c(
      "heart attack"  = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
      "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
      "pneumonia"     = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
   )
   if(!state %in% data$State){
      stop("invalid state")
   }   
   if(!outcome %in% valid_outcomes){
      stop("invalid outcome")
   }
   
   ## Return hospital name in that state with the given rank 30-day death rate
   outcome_col <- outcome_cols[outcome]
   sub_data <- data[data$State == state, ]
   sub_data <- sub_data[!is.na(sub_data[[outcome_col]]), ]
   sub_data[[outcome_col]] <- as.numeric(sub_data[[outcome_col]])
   
   ## If no hospitals remain, return NA for any rank
   if (nrow(sub_data) == 0) {
      return(NA)
   }
   
   ## Order by outcome rate (lowest first), then by hospital name alphabetically
   sub_data <- sub_data[order(sub_data[[outcome_col]], 
                              sub_data$Hospital.Name), ]
   
   ## Determine the row index based on num argument
   if (num == "best") {
      idx <- 1
   } else if (num == "worst") {
      idx <- nrow(sub_data)
   } else if (is.numeric(num)) {
      if (num > nrow(sub_data)) {
         return(NA)
      }
      idx <- num
   } else {
      stop("invalid num argument")
   }
   
   ## Return the hospital name at the computed index
   return(sub_data$Hospital.Name[idx])
}