pollutantmean <- function(directory, pollutant, id = 1:332){
      filenames <- paste0(sprintf("%03d", id), ".csv")
      files <- file.path(directory, filenames)
      total_sum <- 0
      total_count <- 0
      for (f in files) {
            raw_data <- read.csv(f)[[pollutant]]
            valid_data <- raw_data[!is.na(raw_data)]
            sum_data <- sum(valid_data)
            total_sum <- total_sum + sum_data
            total_count <- total_count + length(valid_data)
      }
      total_sum / total_count
}