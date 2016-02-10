%%ALP Basic API, Written by Nakul Bende%%

%%%%api_load%%%%

% Send an image to the mirrors, and display it. Careful about the lags, if using this in a loop. This should always be performaed in following to _Reset_ > _Clear_ command.

% INPUTS:
    % _dll_name_ = Loaded control library 
    % _hdevice_ = device handle generated by allocate function 
    % _image_ = image matrix should be in 0/1. Dimensions 768X1024 (rowsXcolumns). Note that C style structures are transpose equivalant of the MATLAB counterparts.
    % _first_row_ = first row to be loaded (0) 
    % _last_row_ = last row to be loaded (767)
    
% OUTPUT:
    % _return_load_ = Return for success/ error reporting

function [return_load] = api_load(dll_name, hdevice, image, first_row, last_row)

first_row = int32(first_row);
last_row = int32(last_row);
image = uint8(image); %Convert to unsigned 8 bit integer

%% prepare the image to follow 8 bit format, MSB should be 0/1
if max(max(image)) == 1
    image = image.*255;
elseif max(max(image)) == 255
    image = image;
else disp('Please check, Image is not in the right format')
end
    
%% Prepare the Inpointer
imageptr = libpointer('uint8Ptr', image');

[return_load, image] = calllib(dll_name, 'AlpbDevLoadRows', hdevice, imageptr, first_row, last_row);