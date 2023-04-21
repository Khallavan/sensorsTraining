#' @name train_model_distance
#' @title Training of distance models
#' Takes the dataset previously added in the folder datasets,
#' uses it for training a linear regression model applying the caret
#' package, the training is set to a random seed each time.
#' Takes a 80 % from data in training processes and a 20 % for testing
#'

#library(sensorsTraining)
train_model_distance <- function(){
    # @TODO: Train model function to predict distance of sensors.
    if(!require(tidyverse))
        install.packages("tidyverse")
    library(tidyverse)
    if(!require(caret))
        install.packages("caret")
    library(caret)

    # Prepare the data from each sensor
    sensors.df <- load_datasets("sensors_dataset_A.csv")
    ultrasonic.data <- sensors.df %>% select(ultrasonic, distance)
    laser.data <- sensors.df %>% select(laser, distance)
    multi.data <- sensors.df %>% select(ultrasonic, laser, distance)

    ultrasonic.train.samples <- ultrasonic.data$distance %>%
        createDataPartition(p = 0.8, list = FALSE)
    laser.train.samples <- laser.data$distance %>%
        createDataPartition(p = 0.8, list = FALSE)
    multi.train.samples <- multi.data$distance %>%
        createDataPartition(p = 0.8, list = FALSE)

    ultrasonic.train.data <- ultrasonic.data[ultrasonic.train.samples,
                                        c("ultrasonic", "distance")]
    ultrasonic.test.data <- ultrasonic.data[-ultrasonic.train.samples,
                                       c("ultrasonic", "distance")]
    laser.train.data <- laser.data[laser.train.samples, c("laser", "distance")]
    laser.test.data <- laser.data[-laser.train.samples, c("laser", "distance")]
    multi.train.data <- multi.data[multi.train.samples, c("ultrasonic", "laser", "distance")]
    multi.test.data <- multi.data[-multi.train.samples, c("ultrasonic", "laser", "distance")]

    model.distance.ultrasonic <- train(
        distance ~ ultrasonic,
        data = ultrasonic.train.data,
        method = "lm",
        trControl = trainControl("cv", number = 10)
        )

    model.distance.laser <- train(
        distance ~ laser,
        data = laser.train.data,
        method = "lm",
        trControl = trainControl("cv", number = 10)
    )
    model.multi.distance <- train(
        distance ~ ultrasonic + laser,
        data = multi.train.data,
        method= "lm",
        trControl = trainControl("cv", number = 10)
    )

    predict.ultrasonic <- model.distance.ultrasonic %>%  predict(ultrasonic.test.data)
    predict.laser <- model.distance.laser %>% predict(laser.test.data)
    predict.multi <- model.multi.distance %>% predict(multi.test.data)
    print("Ultrasonic")
    postResample(predict.ultrasonic, ultrasonic.test.data$distance)
    print("Laser")
    postResample(predict.laser, laser.test.data$distance)
    print("Muliple sensor")
    postResample(predict.multi, multi.test.data$distance)
}
