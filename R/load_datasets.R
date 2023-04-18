#' @name load_datasets
#' @title Datasets Loader
#' @param name_dataset: character type data set name.
#' charges a data set saved in the ./datasets folder
#' @return sensors dataset as dataFrame with string as factor
#' @example
#' load_datasts(/your_dataset.csv)
#'

load_datasets <- function(name_dataset) {
    if(!require(tidyverse))
        install.packages("tidyverse")
    library(tidyverse)

    folder <- dirname(rstudioapi::getSourceEditorContext()$path)
    parentFolder <- dirname(folder)
    return (sensors <- read.csv(paste0(parentFolder,"/datasets",name_dataset),
                                stringsAsFactors =  TRUE))
}
