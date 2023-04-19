train_model_classificator <- function() {
    # @TODO: function to train the model classify shape of walls
    if(!require(tidyverse))
        install.packages("tidyverse")
    library(tidyverse)
    if(!require(caret))
        install.packages("caret")
    library(caret)

    shape_df <- load_datasets("/distance_data.csv")
}
