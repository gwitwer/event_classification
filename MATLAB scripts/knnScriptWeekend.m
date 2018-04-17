clear;
clc;

Wend = load("weekendUniqueSorted.csv");
Wday = load("weekdayUniqueSorted.csv");
% Wend has 118 data points
%   52 with Unique values
%   66 without Unique values
%   Note: the data has been sorted in Excel, so the first 52 data points
%   are those that have Unique values
WendTrain = Wend(1:52, 2:4);
WendTest = Wend(53:118, 2:4); % excluding weekend? column (1/0)

% Wday has 99 data points
%   35 with Unique values
%   64 without Unique values
%   Note: the data has been sorted in Excel, so the first 35 data points
%   are those that have Unique values
WdayTrain = Wday(1:35, 2:4);
WdayTest = Wday(36:99, 2:4); % excluding weekend? column (1/0)

% Wend and Wday each have 3 columns:
%   1: Unique
%   2: Attending
%   3: Interested


K = 6; % K-value for KNN



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KNN weekend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% separate unique values from attending and interested
wendTrainUnique = WendTrain(:, 1);
wendTrainAttInt = WendTrain(:, 2:3); % AttInt -> Attending and Interested

wendTestUnique = WendTest(:, 1); % will hold estimations here
%   just copying WendTest's column of Unique values because they are 
%   all zeros at the moment
wendTestAttInt = WendTest(:, 2:3);

% KNN estimations
for i = 1 : size(wendTestUnique, 1)
    estimation = knnUniqueEstimation(i, wendTestAttInt, wendTrainAttInt, wendTrainUnique, K);
    wendTestUnique(i) = estimation;
    
end
  
A1 = [wendTestUnique(1:52, :) wendTestAttInt(1:52, :)];
% excluding last 14 test data points so dimensions match train data points
Z1 = zeros(52, 1); % column of zeros to separate A1 and B1
B1 = [wendTrainUnique wendTrainAttInt];

% Entering the following in the command window is helpful to see the
% estimations:
% [A1 Z1 B1]


% Notes: 46/66 Unique estimations are larger than their 
% corresponding Interested values.  Whereas 23/52 of the training data 
% points' Unique values are larger than their corresponding Interested
% values.  I believe the initial estimates (made before dichotomizing the
% data by weekend/weekday) were more accurate, which would make sense
% because the training data set was larger.  Nonetheless, I still think
% these new estimates are usable.  Facebook data does not encompass all
% concert goers (some do not use Facebook and others may not respond to the
% post).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mean Absolute Error weekend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% going to run our KNN Unique value estimator on the training data
% using those estimates, will calculate the Mean Absolute Error

wendTrainEst = zeros(size(wendTrainUnique)); % will hold estimations here

% run KNN
for i = 1 : size(wendTrainEst, 1)
    estimation = knnUniqueEstimationTrainingData(i, wendTrainAttInt, wendTrainUnique, K);
    wendTrainEst(i) = estimation;
    
end


% Now ready to calculate MAE
wendMAE = MAE(wendTrainUnique, wendTrainEst);

% I believe MAE is a more fair error metric for our task.  Please let me
% know if you feel strongly otherwise.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KNN weekday
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% separate unique values from attending and interested
wdayTrainUnique = WdayTrain(:, 1);
wdayTrainAttInt = WdayTrain(:, 2:3); % AttInt -> Attending and Interested

wdayTestUnique = WdayTest(:, 1);
wdayTestAttInt = WdayTest(:, 2:3);
 
% KNN estimations
for i = 1 : size(wdayTestUnique, 1)
    estimation = knnUniqueEstimation(i, wdayTestAttInt, wdayTrainAttInt, wdayTrainUnique, K);
    wdayTestUnique(i) = estimation;
    
end

A2 = [wdayTestUnique(1:35, :) wdayTestAttInt(1:35, :)];
% again excluding test data points just so dimensions match
Z2 = zeros(35, 1); % column of zeros to separate A1 and B1
B2 = [wdayTrainUnique wdayTrainAttInt];

% in command window, enter:
% [A2 Z2 B2]

% Weekday Unique value estimations do not vary as much from their
% corresponding Interested values.  I think this has to do with there being
% more weekday data points and the Facebook data does not vary as much.
% On average, the Attending and Interested values are less for weekday
% events than for weekend events, which is expected.  Less of a range leads
% to more uniform estimations.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mean Absolute Error weekday
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

wdayTrainEst = zeros(size(wdayTrainUnique));

% run KNN
for i = 1 : size(wdayTrainEst, 1)
    estimation = knnUniqueEstimationTrainingData(i, wdayTrainAttInt, wdayTrainUnique, K);
    wdayTrainEst(i) = estimation;
    
end


% Now ready to calculate MAE
wdayMAE = MAE(wdayTrainUnique, wdayTrainEst);

% figure;
% 
% % A1, B1
% subplot(3,2,1);
% plot(fitlm(A1(:,3), A1(:,1)));
% title("Weekend Test Unique vs Interested")
% ylabel("Unique");
% xlabel("Interested");
% subplot(3,2,2);
% plot(fitlm(B1(:,3), B1(:,1)));
% title("Weekend Train Unique vs Interested")
% ylabel("Unique");
% xlabel("Interested");
% 
% % A2, B2
% subplot(3,2,3);
% plot(fitlm(A2(:,3), A2(:,1)));
% title("Weekday Test Unique vs Interested")
% ylabel("Unique");
% xlabel("Interested");
% subplot(3,2,4);
% plot(fitlm(B2(:,3), B2(:,1)));
% title("Weekday Train Unique vs Interested")
% ylabel("Unique");
% xlabel("Interested");

% COMBINED 

combinedTrain = [Wend(1:52, 2:4); Wday(1:35, 2:4)];
combinedTest = [Wend(53:118, 2:4); Wday(36:99, 2:4)];

% separate unique values from attending and interested
combinedTrainUnique = combinedTrain(:, 1);
combinedTrainAttInt = combinedTrain(:, 2:3); % AttInt -> Attending and Interested

combinedTestUnique = combinedTest(:, 1); % will hold estimations here
%   just copying WendTest's column of Unique values because they are 
%   all zeros at the moment
combinedTestAttInt = combinedTest(:, 2:3);

% KNN estimations
for i = 1 : size(combinedTestUnique, 1)
    estimation = knnUniqueEstimation(i, combinedTestAttInt, combinedTrainAttInt, combinedTrainUnique, K);
    combinedTestUnique(i) = estimation;
    
end
  
A3 = [combinedTestUnique(1:52, :) combinedTestAttInt(1:52, :)];
% excluding last 14 test data points so dimensions match train data points
Z3 = zeros(52, 1); % column of zeros to separate A1 and B1
B3 = [combinedTrainUnique combinedTrainAttInt];

figure;
subplot(1,2,1);
plot(fitlm(A3(:,3), A3(:,1)));
title("Combined Train Unique vs Interested")
ylabel("Unique");
xlabel("Interested");

subplot(1,2,2);
plot(fitlm(B3(:,3), B3(:,1)));
title("Combined Train Unique vs Interested")
ylabel("Unique");
xlabel("Interested");

