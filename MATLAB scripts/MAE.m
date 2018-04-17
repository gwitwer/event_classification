function mae = MAE( y_t, y_p )
%MAE returns the Mean Absolute Error, given the true values (y_t) and the
%   predicted values (y_p)

ae = abs(y_t - y_p); % absolute error

n = size(ae, 1); %n -> number of data points (y_t & y_p are column vectors)

mae = sum(ae) / n; % mean absolute error


return

