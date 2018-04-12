genres = ["hiphop", "electronic", "rock", "other"];

figure;
for i = 1:length(genres)
    D = csvread("attending_interested_" + genres(i) + ".csv");
    X = D(:,2);
    Y = D(:,1);
    num_to_gen = length(X); % double the number of points
    chart_title = "Interested and Attending for " + genres(i);
    xPred = zeros(num_to_gen,1);
    yPred = zeros(num_to_gen,1);
    linreg = fitlm(X, Y);
    RMSE = linreg.RMSE; % Root of mean squared error
    mu = mean(X);
    sigma = std(X);
    
    for j = 1:num_to_gen
        while xPred(j) <= 0
            % fix for negative random values
            xPred(j) = normrnd(mean(X), std(X));
        end
        
        % find prediction using the model
        yPred(j) = predict(linreg, xPred(j));
        
        % Add noise to the prediction
        yPred(j) = yPred(j) + (rand() * 2 * RMSE) - RMSE;
        while yPred(j) <= 0
            % fix for negative random values
            yPred(j) = yPred(j) + (rand() * 2 * RMSE) - RMSE;
        end
    end
    
    % convert predictions to integers
    xPred = round(xPred);
    yPred = round(yPred);
    
    % plot
    subplot(2,2,i);
    plot(linreg);
    hold on;
    scatter(xPred, yPred, 25, 'MarkerEdgeColor',[0 .5 .5]);
    hold off;
    xlabel('Interested')
    ylabel('Attending')
    title(chart_title);
    % NOTE: reversed order of X and Y here to get back to "attending, interested"
    % pattern for the CSV!
    csvwrite("ALL " + chart_title + ".csv",[[Y;yPred],[X;xPred]]);
    csvwrite("ONLY PREDICTED " + chart_title + ".csv",[yPred,xPred]);
end
