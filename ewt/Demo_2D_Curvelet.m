%% Demo 2D Curevlet

close all
clear all
clc

for img=445:446
    

% Read in original RGB image

url=strcat('../glaucoma test/Im',num2str(img),'.jpg');
rgbImage=imread(url);

% Extract color channels.
redChannel = rgbImage(:,:,1); % Red channel
greenChannel = rgbImage(:,:,2); % Green channel
blueChannel = rgbImage(:,:,3); % Blue channel

%% EWT2D decomposition


%% User setup

% Choose the wanted preprocessing (none,plaw,poly,morpho,tophat)
params.globtrend = 'none';
params.degree=5; % degree for the polynomial interpolation

% Choose the wanted regularization (none,gaussian,average,closing)
params.reg = 'none';
params.lengthFilter = 10;
params.sigmaFilter = 1.5;

% Choose the wanted detection method (locmax,locmaxmin,ftc,scalespace)
params.detect = 'locmaxmin';
params.typeDetect='otsu'; %for scalespace:otsu,halfnormal,empiricallaw,mean,kmeans

params.N = 3; % maximum number of band for the locmaxmin method
params.completion = 0;

% Perform the detection on the log spectrum instead the spectrum itself
params.log=0;

% Choose the results you want to display (Show=1, Not Show=0)
Bound=0;   % Display the detected boundaries on the spectrum
Comp=1;    % Display the EWT components
Rec=0;     % Display the reconstructed signal
           

%% We perform the 2D Littlewood-Paley EWT
ncolor={redChannel, greenChannel, blueChannel};
nc=length(ncolor);



for it=1:nc
   
     [tmp,mfb,boundaries]=EWT2D_LittlewoodPaley(cell2mat(ncolor(it)),params);
     %C = repmat(cell2mat( [ tmp{:} ] ),size(tmp)); 
     tmp=cell2mat(tmp);
     [rows,cols]=size(tmp);
     result=zeros(rows/3,cols);
     for i=(2*rows)/3:rows
          for j=1:cols
              result((i-((2*rows)/3))+1,j)=tmp(i,j);
          end
      end
    % imshow(result);
     
     imwrite(result,strcat('./four ewt/Im',num2str(img),'.jpg')); 
     ewtc{it}=tmp;
end
end
% result=ewtc(1,2);
% C = repmat(cell2mat( [ result{:} ] ),size(result));
% imshow(C);
% disp(C);