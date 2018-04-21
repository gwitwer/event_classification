D = csvread("wes_classified_fixed.csv");

X = D(:,4);
Y = D(:,6);

linreg = fitlm(X,Y);
% Coefficients for the regression line
intercept_coeff = linreg.Coefficients{1,1};
X_coeff = linreg.Coefficients{2,1};
reg_y = intercept_coeff + (X_coeff * X);

% 0 class
X0 = [];
Y0 = [];
count_below_line = 0;
for i=1:length(D)
    if D(i,7) == 0
        X0 = [X0;D(i,4)];
        Y0 = [Y0;D(i,6)];
        
        predicted_y = intercept_coeff + (X_coeff * D(i,4));
        count_below_line = count_below_line + ((D(i,6) - predicted_y) < 0);
    end
end

% 1 class
X1 = [];
Y1 = [];
count_above_line = 0;
for i=1:length(D)
    if D(i,7) == 1
        X1 = [X1;D(i,4)];
        Y1 = [Y1;D(i,6)];
        
        predicted_y = intercept_coeff + (X_coeff * D(i,4));
        count_above_line = count_above_line + ((D(i,6) - predicted_y) > 0);
    end
end

percent_label_2 = num2str(round(100 * count_below_line / length(X0)));

plot(X, reg_y)
hold on;
scatter(X0,Y0,'MarkerFaceColor',[1 0 0],'MarkerEdgeColor',[1 0 0]);
hold on;
scatter(X1,Y1,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 1]);
lgd = legend("Line of best fit", "Classified as 0", "Classified as 1");
lgd.FontSize = 12;
lgd.Location = 'northwest';
title("Facebook Attending vs Actual Attending, Colored by 'Event Success' Class");
xlabel("Facebook Attending")
ylabel("Actual Attending")
text(175,75,'Classified correctly relative to line of best fit:','FontWeight','Bold','FontSize',12)
text(175, 60, 'For class = 1:','FontSize',12);
text(175, 45, 'For class = 0:','FontSize',12);
text(195,60,num2str(round(100 * count_above_line / length(X1))),'FontSize',12);
text(195,45,percent_label_2,'FontSize',12);
text(198,60,'%','FontSize',12);
text(198,45,'%','FontSize',12);