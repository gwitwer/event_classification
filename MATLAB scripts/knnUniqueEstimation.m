function estimation = knnUniqueEstimation( index, testAI, trainAI, trainUniqueValues, k )
%knnUniqueEstimation returns estimations for the undocumented 
%   values for the Unique attribute

%   the estimated value is assigned via average of the 
%   k nearest neighbors' values for the Unique attribute

%   the distance metric is euclidean distance between the test and train
%   data points Attending and Interested values.  The k closest distances
%   determine the k nearest neighbors


distances = zeros(1, size(trainAI, 1)); % will have distances to all training data points

for i = 1 : size(trainAI, 1)
    dist = euclideanDist(testAI(index, :), trainAI(i, :));
    distances(i) = dist; % add dist to distances
end

[a, b] = sort(distances); % a -> sorted distances; b -> indices (of data points)


neighborsUniqueValues = zeros(1, k);

for i = 1 : k % closest k neighbors
    neighborsUniqueValues(i) = trainUniqueValues(b(i));
end


s = sum(neighborsUniqueValues);
estimation = s / k;

return

