genres = ["hiphop", "electronic", "rock", "other"];

figure;
for i = 1:length(genres)
    D = csvread("attending_interested_" + genres(i) + ".csv");
    X = D(:,1);
    Y = D(:,2);
    Z = [X, Y];
    num_to_gen = length(X); % double the number of points
    chart_title = "Interested and Attending for " + genres(i);
    linreg = fitlm(X, Y);
    mu = mean(X);
    sigma = std(X);
    
    zPred = zeros(num_to_gen, 2);
    for j=1:length(zPred)
        while zPred(j,1) <= 0 || zPred(j,2) <= 0
            zPred(j,:) = mvnrnd(mean(Z), cov(Z));
        end
    end
    
    % convert predictions to integers
    zPred = round(zPred);
    
    % plot
    subplot(2,2,i);
    plot(linreg);
    hold on;
    scatter(zPred(:,1), zPred(:,2), 25, 'MarkerEdgeColor',[0 .5 .5]);
    hold off;
    xlabel('Attending');
    ylabel('Interested');
    title(chart_title);
    
    % Write CSV
%     csvwrite("ALL " + chart_title + ".csv",[Z;zPred]);
%     csvwrite("predicted_attending_interested_" + genres(i) + ".csv", zPred);
end
