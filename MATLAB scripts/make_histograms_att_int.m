D = csvread("allUniqueSorted.csv");
X1 = D(:,3);
X2 = D(:,4);

mag = 2;
figure;

% ORIGINAL
v = round(X1 / mag) * mag;
subplot(2,2,1);
hist(v(:,1))
xlabel("Attending");
ylabel("Frequency");
title("Original histogram of attending");

hold on;
subplot(2,2,2);
v = round(X2 / mag) * mag;
hist(v(:,1))
xlabel("Interested");
ylabel("Frequency");
title("Original histogram of interested");

D = csvread("wes_classified_fixed.csv");
X1 = D(:,4);
X2 = D(:,5);

mag = 2;

v = round(X1 / mag) * mag;
subplot(2,2,3);
hist(v(:,1))
xlabel("Attending");
ylabel("Frequency");
title("Post-generation histogram of attending");

subplot(2,2,4);
v = round(X2 / mag) * mag;
hist(v(:,1))
xlabel("Interested");
ylabel("Frequency");
title("Post-generation histogram of interested");