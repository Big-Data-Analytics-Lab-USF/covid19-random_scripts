# This script was created to copy files from USF's CIRCE directly to Box.
# In addition, this is a command line based R script that will take a DIR
# as an input and use that to create a new DIR in box, set working directory in R,
# and upload everything in the DIR. 

# Examples to use this script in CIRCE is the following in terminal enter the following
## module load apps/R/4.0.2-el7-gcc-openblas
## Rscript <script path> <DIR to upload>


library("dplyr")
library("boxr")


args <- commandArgs(trailingOnly = FALSE)
fileNames_all <- args[6] #grab arguement from cmd line
fileLocation <- fileNames_all # something weird happens but this fixes the issue


boxr::box_auth(client_id = "XXXXXXXXXXXXX", # used to auth script -- create box dev account.
               client_secret = "XXXXXXXXXX")

box_to_circe <- function(dir_name, working_dir){ # function to upload all files in DIR
  box_dir <- as.character(dir_name)
  box.d <- boxr::box_dir_create(dir_name = box_dir, parent_dir_id = "XXXXXXXXX") # parent_dir is the id in URL
  #setwd(as.character(working_dir))
  files_in_dir <- list.files(path = working_dir,
                             full.names = T)
  for(i in 1:length(files_in_dir)){
    box_ul(
      dir_id = as.character(box.d[2]) ,
      file = as.character(files_in_dir[i]),
      pb = options()$boxr.progress,
      description = NULL
    )
  }
}

put_dir <- fileLocation
put_name <- substr(x = fileLocation, # strip only date 'last 6 chars from str'
                   start = nchar(fileLocation) - 6,
                   stop = nchar(fileLocation))


## RUN FUNCTION ##
box_to_circe(dir_name = put_name,
             working_dir = put_dir)


