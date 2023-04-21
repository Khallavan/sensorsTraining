#' @name final_models
#' @title final models
#' takes the models functions and train them with differents
#' seeds each time that calls the training functions. And saves
#' the models in rds files.

#library(sensorsTraining)
final_models <- function() {
    folder <- dirname(rstudioapi::getSourceEditorContext()$path)
    parentFolder <- dirname(folder)

    #train every time the model with a random seed
    train_model_distance()
    # Cross validation from caret package
    print(model.distance.laser)
    print(model.distance.ultrasonic)
    print(model.multi.distance)
    # Test the models with random values from the sensors
    new_df_test <- load_datasets("random_dataset_sensors_A.csv")
    df_test_cleared <- new_df_test %>% select(ultrasonic, laser)
    df_test_ultrasonic <- df_test_cleared %>% select(ultrasonic)
    df_test_laser <- df_test_cleared %>% select(laser)
    predict(model.multi.distance, df_test_cleared)
    predict(model.distance.ultrasonic, df_test_ultrasonic)
    predict(model.distance.laser, df_test_laser)
    # save the models in a folder models
    saveRDS(model.distance.laser, paste0(parentFolder,"/models/model_laser_distance.rds"))
    saveRDS(model.distance.ultrasonic, paste0(parentFolder,"/models/model_ultrasonic.rds"))
    saveRDS(model.multi.distance, paste0(parentFolder,"/models/model_laser_ultrasonic_distance.rds"))

    # Train the shape clasifictor with a random seed each time
    train_model_classificator()

    random_df <- load_datasets("random_shape_dataset.csv")
    random_df <- random_df %>% select("ultrasonic", "laser")
    predict(shape.model.classificator, random_df)
    saveRDS(shape.model.classificator, paste0(parentFolder,"/models/shape_model_classificator.rds"))
}
