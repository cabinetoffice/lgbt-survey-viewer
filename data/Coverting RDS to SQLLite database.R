# This script will create an SQLITE database from the AllAppData RDS file that the app will run off.
# Please note that the final SQLITE file will be around 7 GB. 

library(dplyr)
library(RSQLite)

## Creating Database

# Replace with location to set up SQLLITE file (will overwrite files)
data <- setwd("~/LGBTSurvey2017")

db <- dbConnect(RSQLite::SQLite(), dbname = "SQLDB.sqlite")

# Read in RDS data - replace with location of AllAppData.rds
data <- readRDS("~/AllAppData - Cleaned")

# Create table in SQLLITE for data
copy_to(db, data, "allsqldata",
        temporary = FALSE, overwrite = TRUE,
        indexes = list(c("Theme","Sub-theme","Question","Category of respondents","Filter1","Filter1Options","Filter2","Filter2Options","Filter3","Filter3Options"))
)

# Read in Data from SQLLITE file
data <- tbl(db, "allsqldata")

# Create a lookup directory of data
tables <- data %>% 
  select(Theme,`Sub-theme`,Question,`Category of respondents`,Filter1,Filter1Options,Filter2,Filter2Options,Filter3,Filter3Options) %>% 
  distinct()

# Copy lookup to SQLLITE
copy_to(db, tables, "tables",
        temporary = FALSE)

dbDisconnect(db)



