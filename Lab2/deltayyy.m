function DY = deltayyy()
% Returns a mask for approximation third partial derivative in
% y-axis

DY=filter2(deltay,deltayy,'same');