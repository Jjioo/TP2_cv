clear all
close all
clc

%% Initialize video lecter
videoLect = vision.VideoFileReader('robot.avi', 'ImageColorSpace', 'Intensity');

%% model de l'optical flow
%OFmethod = opticalFlowHS;
%OFmethod.Smoothness = 0.1

OFmethod = opticalFlowLK;
OFmethod.NoiseThreshold = 0.0001;


%% visualize
while ~isDone(videoLect)
      nextFrame = step(videoLect);
      
      OF = estimateFlow(OFmethod, nextFrame); 
      OFtoRight = OF.Vx > 1;
      OFtoLeft = OF.Vx < -1;
      
      NpixelRight = nnz(OFtoRight);
      NpixelLeft = nnz(OFtoLeft);
      
      if NpixelRight > NpixelLeft
          msg = 'To Left';
      else
          msg = 'To right';
      end
      
      
      
      
      
      subplot(1,2,2);
      plot(OF, 'DecimationFactor', [10 10], 'ScaleFactor', 50);
      
      subplot(1,2,1);
      imshow(nextFrame);
      title(msg);
      drawnow;
end