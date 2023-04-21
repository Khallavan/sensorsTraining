#' @name train_model_classificator
#' @title Classificator model training
#' This takes a sensor shapes dataset to training a model to
#' classify the shape of a wall taken the data given by ultrasonic
#' and laser sensors.

#library(sensorsTraining)
train_model_classificator <- function() {
    if(!require(tidyverse))
        install.packages("tidyverse")
    library(tidyverse)
    if(!require(caret))
        install.packages("caret")
    library(caret)

    shape_df <- load_datasets("sensors_shapes_dataset.csv")
    shape_df$Shape <- as.factor(shape_df$Shape)

    data.train.idx <- createDataPartition(shape_df$Shape, p = 0.7, list = FALSE)

    train.data = shape_df[data.train.idx,]
    test.data = shape_df[-data.train.idx,]

    ctrl <- trainControl(method="LGOCV", p = 0.3)
    shape.model.classificator <- train(
        Shape ~ ultrasonic + laser,
        data = train.data,
        method = "knn",
        tuneGrid = data.frame(k = 3),
        trControl = ctrl,
    )
    predictions <- predict(shape.model.classificator, test.data)
    confusionMatrix(predictions, test.data$Shape)
    confusionMatrix(predictions, test.data$Shape)$overall["Accuracy"]
}
