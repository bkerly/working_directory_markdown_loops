# The purpose of this demonstration is to show two things:
# First, how to use the "here" package to control your working directory.
# Second, how to efficiently use loops within Rmarkdown to generate cool reports
library(tidyverse)
library(here)

File.Mover <- function(from, to) {
  todir <- dirname(to)
  if (!isTRUE(file.info(todir)$isdir)) dir.create(todir, recursive=TRUE)
  file.rename(from = from,  to = to)
}


# Working Directory Shenanigans -------------------------------------------

getwd()

# The here package creates paths relative to the top-level directory. The package displays the top-level of the current project on load or any time you call here():
here::here()

setwd("C:/Users/berly")

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# If you think your directory is messed up, you can use:
getwd() # to see it, but even better is to use
here::dr_here() 
# ...to find out what is going on with your working directory.

here::here()

pseudoWD <- dirname(rstudioapi::getActiveDocumentContext()$path) # Sets the working directory to whereever "COPHS Master Controller.r" is. 

# This function just turns any relative path (in the pseudoWD directory) into an absolute path.
file.Dir <- function(path){
  paste0(pseudoWD,"/",path)
}

# This function does the same thing as file.Dir, but for scripts.
source.Script <- function(path){
  source(paste0(pseudoWD,"/",path))
}


# Using the functions to load data or run scripts -------------------------

cars <- read_csv(
  file.Dir(
    path = "data/cars.csv"
  )
)

source.Script(
  "load_data.r"
)


# Part 2: Fancy with Markdown Loops ---------------------------------------------

render_report = function(doc_title,data_set){
  OutputFilename = paste0(doc_title," - ",Sys.Date(),".pdf")
  
  rmarkdown::render(
    file.Dir("Markdown Loop Demo.rmd"), 
    params = list(
      data_set = data_set,
      doc_title = doc_title
    ),
    output_file = file.Dir(OutputFilename)
    
  )
  
   File.Mover(from = file.Dir(OutputFilename),
              to = file.Dir(
                paste0("reports/",
                          OutputFilename))
   )
  
}

render_report(doc_title = "Super Cool Cars Report Of Horsepower by Displacement and Cylanders",
              data_set = "cars")

render_report(doc_title = "Fantastic Flower Analysis",
              data_set = "iris")
