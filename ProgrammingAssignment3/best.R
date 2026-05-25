best <- function(state, outcome) {
  
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

  if(!outcome %in% valid_outcomes){
     stop("invalid outcome")
  }
  if(!state %in% data$State){
     stop("invalid state")
  }
  
  ## Return hospital name in that state with lowest 30-day death rate
  outcome_col <- outcome_cols[outcome]
  sub_data <- data[data$State == state, ]
  sub_data <- sub_data[!is.na(sub_data[[outcome_col]]), ]
  sub_data[[outcome_col]] <- as.numeric(sub_data[[outcome_col]])
  sub_data <- sub_data[order(sub_data[[outcome_col]], 
                       sub_data$Hospital.Name), ]
  sub_data$Hospital.Name[1]
}