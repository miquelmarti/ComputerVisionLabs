function DY = deltayyy()
% Returns a mask for approximation third partial derivative in
% y-axis

DY=conv2(deltay,deltayy,'same');