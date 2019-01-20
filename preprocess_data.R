preprocess.gtd.data <- function() {
  if (!file.exists("gtd_processed.rds")) {
    if (!file.exists("gtd.zip")) {
      stop("Please download the Global Terrorism Database from https://www.kaggle.com/START-UMD/gtd")
    }
    if (!file.exists("globalterrorismdb_0718dist.csv")) {
      unzip("gtd.zip")
    }
    colClasses <- c(
      "numeric",
      rep("numeric", 3),
      rep("NULL", 4),
      "factor",
      "NULL",
      "factor",
      "NULL",
      "NULL", # city
      "numeric", #lat
      "numeric", #long
      rep("NULL", 3),
      "character",
      rep("NULL", 10),
      "factor", #attacktype1_txt
      "NULL",
      "factor", #attacktype2_txt
      "NULL",
      "factor", #attacktype3_txt
      "NULL",
      "factor", #targtype1_txt
      "NULL",
      "factor", #targsubtype1_txt
      rep("NULL", 4),
      "NULL",
      "factor", #targtype2_txt
      "NULL",
      "factor", #targsubtype2_txt
      rep("NULL", 4),
      "NULL",
      "factor", #targtype3_txt
      "NULL",
      "factor", #targsubtype3_txt
      rep("NULL", 4),
      "factor",
      "NULL",
      "factor",
      "NULL",
      "factor", #gname3
      "NULL",
      rep("NULL", 5),
      "numeric",
      rep("NULL", 28),
      "numeric", #nkill
      "NULL",
      "numeric", #nkillter
      "numeric", #nwound
      "NULL",
      "numeric", #nwoundte
      "numeric",
      "NULL",
      "factor",
      "numeric",
      "character",
      rep("NULL", 26)
    )
    glob_ter_df <- read.csv("globalterrorismdb_0718dist.csv", colClasses = colClasses)
    
    glob_ter_df[glob_ter_df$iday == 0, ]$iday <- 1
    glob_ter_df <- glob_ter_df[glob_ter_df$imonth != 0, ]
    
    glob_ter_df$date <- as.POSIXct(paste(glob_ter_df$iyear, glob_ter_df$month, glob_ter_df$iday, sep = "-"), tz = "GMT", "%Y-%m-%d")
    saveRDS(glob_ter_df, file="gtd_processed.rds")
  }
  readRDS("gtd_processed.rds")
}
