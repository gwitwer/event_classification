genres = ["hiphop", "electronic", "rock", "other"];

figure;
for i = 1:length(genres)
    D = csvread("attending_interested" + genres(i) + ".csv");

    subplot(2,2,i);
    scatter(D(:,1), D(:,2))
    title("Attending / Interested for " + genres(i));
end
