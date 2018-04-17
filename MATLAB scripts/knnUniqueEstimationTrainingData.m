function estimation = knnUniqueEstimationTrainingData( index, trainAI, trainUniqueValues, K )

distances = zeros(1, size(trainAI, 1));
for i = 1 : size(trainAI, 1)
    dist = euclideanDist(trainAI(index, :), trainAI(i, :));
    distances(i) = dist; % add dist to distances
end

[a, b] = sort(distances); % a -> sorted distances ; b -> indices (of data points)


neighborsUniqueValues = zeros(1, K);
for i = 2 : (K+1) % exclude distance to itself (distance of 0)
    neighborsUniqueValues(i-1) = trainUniqueValues(b(i));
end


s = sum(neighborsUniqueValues);
estimation = s / K;

return



