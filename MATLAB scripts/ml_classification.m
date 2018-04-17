filenames = ["hiphop", "electronic", "rock", "other", "all"];

figure;
for i = 1:length(filenames)
    fn = filenames(i);
    if fn == "rock" % special case for rock -- does better when using all.
        fn = "all";
    end
    D = csvread("attending_interested_" + fn + ".csv");
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
    
    from_h0 = mvnpdf(X, mean(H0), cov(H0));
    from_h1 = mvnpdf(X, mean(H1), cov(H1));
    
    h_diffs = (from_h1 - from_h0) > 0;
    ["Accuracy of " + filenames(i); sum(h_diffs == Y) / length(Y)]
    
%     % This is for creating a histogram *WITHOUT* predicted values
%     subplot(2,3,i);
%     v = round(X / 10) * 10;
%     hist3(v);
%     xlabel('Attending');
%     ylabel('Interested');
%     zlabel('Frequency');
%     title("Actualy frequency (rounded to nearest 10) for " + filenames(i) + " events");

%     % This is for creating 2-D histograms 
%     types = ["Attending", "Interested"];
%     t = 2;
%     subplot(2,3,i);
%     v = round(X / 10) * 10;
%     hist(v(:,t))
%     xlabel(types(t));
%     ylabel("Frequency");
%     title("Histogram of actual " + filenames(i) + " events (" + types(t) + ")");
%     
    if (filenames(i) ~= "all")
        P_D = csvread("predicted_attending_interested_" + filenames(i) + ".csv");
        P_X = P_D(:,1:2);
        
        from_h0 = mvnpdf(P_X, mean(H0), cov(H0));
        from_h1 = mvnpdf(P_X, mean(H1), cov(H1));

        pred_h_diffs = (from_h1 - from_h0) > 0;
        
        % Use this to create a histogram *WITH* predicted values
        combined_X = [X;P_X];
        subplot(2,2,i);
        v = round(combined_X / 10) * 10;
        hist3(v);
        xlabel('Attending');
        ylabel('Interested');
        zlabel('Frequency');
        title("Actual + predicted frequency (rounded to nearest 10) for " + filenames(i) + " events");


%         % write new values
%         csvwrite("predicted_attending_interested_" + filenames(i) + ".csv", [P_X, pred_h_diffs]);
    end
    
end