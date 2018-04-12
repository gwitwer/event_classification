filenames = ["hiphop", "electronic", "rock", "other", "all"];

figure;
for i = 1:length(filenames)
    D = csvread("attending_interested_" + filenames(i) + ".csv");
    X = D(:,1:end-1);
    Y = D(:,end);
    H0 = [];
    H1 = [];
    
    for j = 1:length(D)
        if Y(j) == 0
            H0 = [H0; X(j,:)];
        else
            H1 = [H1; X(j,:)];
        end
    end
    
    from_h0 = lognpdf(X, mean(H0), cov(H0));
    from_h1 = lognpdf(X, mean(H1), cov(H1));
    
    h_diffs = (from_h1 - from_h0) > 0;
    ["Accuracy of " + filenames(i); sum(h_diffs == Y) / length(Y)]
    
    subplot(2,3,i);
    v = round(X / 10) * 10;
    histogram(v(:,2));
%     hold on;
%     histogram(v(:,2));
%     hold off;
    xlabel('Attending');
    ylabel('Frequency');
    title(filenames(i));
    
end

% CONSIDERATION: it may have been a bit ass-backwards to exclude day of
% week from initial data generation. On the other hand, this gives us an
% excuse to do ML Classification.

% NOTE: What other sort of classification might be more accurate?

% for i = 1:(length(filenames) - 1) % skip "all"
%     D = csvread("attending_interested_" + filenames(i) + ".csv");
%     X = D(:,1:end-1);
%     Y = D(:,end);
% end