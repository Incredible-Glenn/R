complete <- function(directory, id = 1:332){
      filenames <- paste0(sprintf("%03d", id), ".csv")
      files <- file.path(directory, filenames)
      nobs <- integer(length(id))
      for (i in seq_along(files)) {
            raw_data <- read.csv(files[i])
            sum_cases <- sum(complete.cases(raw_data))
            nobs[i] <- sum_cases
      }
      data.frame(id, nobs)
}