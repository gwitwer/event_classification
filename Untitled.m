c = 0.5062;
x = 0:1:100;
z = 0:0.01:1;

% y = 0.25(z) + 0.45(x / 300) + c

% if y = 0.8
plot(((0.45 * (x / 300)) - 0.3238) / -0.25);
xlabel("Exam 3 score out of 100");
ylabel("Final score between 0 and 1");
title("What I need to get on final to get an 83 in the class");