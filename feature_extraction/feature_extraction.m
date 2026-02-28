clear all;
% Connect MATLAB serial port to Arduino
s = serialport('COM4', 115200);
configureTerminator(s, "LF");
flush(s);
data = [];
tic;
while true
    if toc >= 6
        break;
    end
    if s.NumBytesAvailable > 0
        newData = readline(s);
        newData = str2double(newData);
        data = [data; newData];
        disp(newData);
    end
end

% Close the serial port connection
clear s;

% Calculate the sum of all values in 'data'
totalSum = sum(data);

% Square each value in 'data' and sum them up
sumsq = sum(data.^2);

% Count the number of values in 'data'
count = numel(data);

% Calculate the mean absolute value (MAV)
mav = totalSum / count;

% Calculate the root mean square (RMS)
rms = sqrt(sumsq / count);

% Calculate the median
sortedData = sort(data);
numElements = numel(sortedData);

if rem(numElements, 2) == 1
    median = sortedData((numElements + 1) / 2);
else
    median = (sortedData(numElements / 2) + sortedData(numElements / 2 + 1)) / 2;
end

% Calculate the waveform length (WL)
wl = sum(abs(diff(data)));

% Calculate the variance of the data
vari = var(data);

% Calculate the standard deviation
stdev = sqrt(vari);

% Create a table with six features & display it
T = table(mav, rms, median ,wl, vari, stdev);
disp(T);