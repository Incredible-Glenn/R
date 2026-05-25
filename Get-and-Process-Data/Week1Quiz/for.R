# Read all lines
lines <- readLines("wksst8110.for")

# Extract column names from first two rows
regions <- strsplit(trimws(lines[1]), "\\s+")[[1]]  # "Nino1+2", "Nino3", "Nino34", "Nino4"
measure_types <- strsplit(trimws(lines[2]), "\\s+")[[1]]  # "Week", "SST", "SSTA", "SST", "SSTA", "SST", "SSTA", "SST", "SSTA"

# Create proper column names
col_names <- c()
for(i in 1:length(measure_types)) {
      if(i == 1) {
            col_names[i] <- "Week"
      } else {
            region_idx <- ceiling((i-1)/2)  # Each region has SST and SSTA
            measure_idx <- ifelse((i-1) %% 2 == 0, "SST", "SSTA")
            col_names[i] <- paste0(regions[region_idx], "_", measure_idx)
      }
}

# Read data starting from row 3
data <- read.table("wksst8110.for", 
                   skip = 2,           # Skip both header rows
                   col.names = col_names,
                   header = FALSE,
                   fill = TRUE)

# Parse the Week column as Date
data$Week <- as.Date(data$Week, format = "%d%b%Y")

# View result
head(data)