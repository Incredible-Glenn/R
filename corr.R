corr <- function(directory, threshold = 0){
       all.files <- list.files(directory, full.names = TRUE)
       correlations <- numeric()
       
       for(file in all.files){
             data <- read.csv(file)
             complete_cases <- complete.cases(data)
             num_complete <- sum(complete_cases)
             if(num_complete > threshold){
                  cor_values <- cor(data$sulfate[complete_cases],
                                    data$nitrate[complete_cases])
                  correlations <- c(correlations, cor_values)
             } 
       }
       correlations
}