%Intrinsische Kameraparameter
%Ermittelt aus der Installationssoftware der Kamera über Windwows-Shell
%Beschreibung der Daten: https://dev.intelrealsense.com/docs/projection-in-intel-realsense-sdk-20

% Intrinsic of "Color" / 1280x720 / {YUYV/RGB8/BGR8/RGBA8/BGRA8/Y16}
%   Width:      	1280
%   Height:     	720
%   PPX:        	641.857604980469
%   PPY:        	362.713409423828
%   Fx:         	905.031433105469
%   Fy:         	903.536376953125
%   Distortion: 	Inverse Brown Conrady
%   Coeffs:     	0  	0  	0  	0  	0  
%   FOV (deg):  	70.53 x 43.45


focalLength = [905.031433105469 903.536376953125];          %Fokuslänge in Pixel
principalPoint = [641.857604980469 362.713409423828];       %Bildmittelpunkt in Pixel
imageSize = [1280 720];                                    
intrinsicsColor = cameraIntrinsics(focalLength,principalPoint,imageSize);





  
images = imageDatastore(fullfile(toolboxdir("vision"),"visiondata", "calibration","slr"));

[imagePoints,boardSize] = detectCheckerboardPoints(images.Files);

squareSize = 29;
worldPoints = generateCheckerboardPoints(boardSize,squareSize);

I = readimage(images,1); 
imageSize = [size(I,1) size(I,2)];
cameraParams = estimateCameraParameters(imagePoints,worldPoints, ...
    ImageSize=imageSize);
%intrinsics = cameraParams.Intrinsics;
intrinsics = intrinsicsColor;

imOrig = readimage(images,9); 
figure 
imshow(imOrig)
title("Input Image")

[im,newOrigin] = undistortImage(imOrig,intrinsics,OutputView="full");

[imagePoints,boardSize] = detectCheckerboardPoints(im);

imagePoints = imagePoints+newOrigin;

camExtrinsics = estimateExtrinsics(imagePoints,worldPoints,intrinsics);

camPose = extr2pose(camExtrinsics);
figure
plotCamera(AbsolutePose=camPose,Size=20);
hold on
pcshow([worldPoints,zeros(size(worldPoints,1),1)], ...
  VerticalAxisDir="down",MarkerSize=40);
hold off
