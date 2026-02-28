% Load the trained model, make predictions & display the predictions
load('trained_model_knn_1.mat');
[yfit,scores] = trainedModelKNN1.predictFcn(T);
prediction_label = 'Prediction by ML:';
disp([prediction_label,yfit]);