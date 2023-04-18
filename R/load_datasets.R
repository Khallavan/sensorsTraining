load_datasets <- function(name) {
    # @TODO: Implement a function to load the datasets for training the sensors model
    # predictor
    if(!require(tidyverse))
        install.packages("tidyverse")
    library(tidyverse)

    forder <- dirname(rstudioapi::getSourceEditorContext()$path)
    return (sensors <- read.csv(paste0(folder,name)))
}
