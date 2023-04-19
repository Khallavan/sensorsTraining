train_model_distance <- function(){
    # @TODO: Train model function to predict distance of sensors.
    if(!require(tidyverse))
        install.packages("tidyverse")
    library(tidyverse)
    if(!require(caret))
        install.packages("caret")
    library(caret)

    distance_df <- load_datasets("/distance_data.csv")

}
