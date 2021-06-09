# This script was created to copy files from USF's CIRCE directly to Box.
# In addition, this is a command line based R script that will take a DIR
# as an input and use that to create a new DIR in box, set working directory in R,
# and upload everything in the DIR. 

# Here's an example on how to use this script in CIRCE. Enter the following in cmd:
## module load apps/R/4.0.2-el7-gcc-openblas
## Rscript <script_path> <DIR_to_upload>

library("dplyr")
library("boxr")

## Script dependencies ##
args <- commandArgs(trailingOnly = FALSE)
fileNames_all <- args[6] #grab arguement from cmd line
fileLocation <- fileNames_all # something weird happens but this fixes the issue
## End Script dependencies ##

## Box Auth ##
boxr::box_auth(client_id = "XXXXXXXXXXXXX", # used to auth script -- create box dev account.
               client_secret = "XXXXXXXXXX")
## End Box Auth ##


## Create CIRCE to box function ##
circe_to_box <- function(dir_name, working_dir){ # function to upload all files in DIR
  box_dir <- as.character(dir_name)
  box.d <- boxr::box_dir_create(dir_name = box_dir, parent_dir_id = "XXXXXXXXX") # parent_dir is the id in URL
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
## End Create CIRCE to box function ##


## Function dependencies ##
put_dir <- fileLocation
put_name <- substr(x = fileLocation, # strip only date 'last 6 chars from str'
                   start = nchar(fileLocation) - 6,
                   stop = nchar(fileLocation))
## End Function dependencies ##


## RUN FUNCTION ##
circe_to_box(dir_name = put_name,
             working_dir = put_dir)


