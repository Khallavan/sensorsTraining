#' @name load_datasets
#' @title Datasets Loader
#' @param name_dataset: character type data set name.
#' charges a data set saved in the ./datasets folder
#' @return sensors dataset as dataFrame with string as factor
#' @example
#' load_datsets("your_dataset.csv")
#'

load_datasets <- function(name_dataset) {
    if(!require(tidyverse))
        install.packages("tidyverse")
    library(tidyverse)

    folder <- dirname(rstudioapi::getSourceEditorContext()$path)
    parentFolder <- dirname(folder)
    sensors <- read.csv2(paste0(parentFolder,"/datasets/",name_dataset))
    return (sensors)
}
