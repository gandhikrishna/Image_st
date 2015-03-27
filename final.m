clc;
clear all;
%m = 1/sqrt(2.*pi);   % max. value for normal function
[I3 map1] = imread('test1.png');

 %figure(),imshow(I3);
 %I2 = rgb2gray(I3);
 I4 = imresize(I3,[400,400]);
 figure(),imshow(I4);
 I2=I3(:,:,2);
 I2 = imresize(I2 ,[400 400]);
% I2 = imresize(wq ,[240 320]);
figure(),imshow(I2);
 I2 = im2double(I2);
 %figure(),imshow(I2);
 
vid= mmreader('video1.avi');    %%%%%%%%%  240 320
 numFrames = vid.NumberOfFrames
 n=numFrames;
 video = vid.read();

 pin=0.1;
 for i = 1:510:n
%   figure();
   %image(video(:,:,:,i));
    pl=zeros(1,3);
    hello(:,:,:) = video(:,:,:,i);
    hello=imresize(hello,[400 400]);
    %hello=rgb2gray(hello);
    figure(),imshow(hello);
    pl(1)=entropy(hello(:,:,1))
    pl(2)=entropy(hello(:,:,2))
    pl(3)=entropy(hello(:,:,3))
    if(pl(1)>pl(2) && pl(1)>pl(2))
       ind=1;
    else if (pl(2)>pl(1) && pl(2)>pl(3))
            ind=2;
        else
            ind=3;
        end
    end
%     hellon = imresize(hello,[500,500]);
    I = hello(:,:,ind);
    %figure(),imshow(I);
    
%     I = imresize(I ,[400 400]);
    s= size(I);
    s1 = size(I2);
    ans(s1(1),s1(2))=0;
%    sqr1 = 1/sqrt(sq1);
%    sqr2 = 1/sqrt(sq2);
 % figure(),imshow(I);
    dct_smp2 = dct2(I2);
    dct_smp1 = dct2(I);       %take dft of each frame
  %   dct_smp2 = dct_smp1 +dct_smp1.*I2.*pin;
  
    for (e=1:s(1))
       for(f = 1:s(2))
          if((f+e) > 400)
             dct_smp1(e,f) = 0;
             dct_smp2(e,f) = 0; 
          end
       end
    end
%     dct_smp1;
%       for (e=1:s1(1))
%         for(f = 1:s1(2))
%            if((f+e) > 400)
%               dct_smp2(e,f) = 0; 
%            end
%         end
%       end
%       
      for(e=1:s1(1))
         for(f = 1:s1(2))
            ans(401-e,401-f) = dct_smp2(e,f);
         end
      end
      dct_smp1 = dct_smp1 + ans ;
%     dct_smp2tr = transpose(dct_smp2);
   %  dct_smp3 = dct_smp1; % (dct_smp2tr)/100;
     smpl_m = (idct2(dct_smp1));%get watermarked frame by inverse fft
     figure(),imshow(smpl_m,[0 255]); %hello
     hello(:,:,ind) = smpl_m;
     figure(),imshow(hello);
     
     
     
     dct_f = dct2(smpl_m);
     s2=size(dct_f);
     ans1(s2(1),s2(2))=0;
     rec(s2(1),s2(2))=0;
     rec = dct_f;
     for(e=1:s2(1))
        for(f=1:s2(2))
           ans1(e,f)=dct_f(401-e,401-f); 
        end
     end
     for(e=1:s2(1))
        for(f=1:s2(2))
            if(e+f > 400)
                ans1(e,f) =0;
                rec(e,f)=0;
            end
        end
     end
     fin_t=(idct2(ans1));
     fin_o=(idct2(rec));
    % figure(),imshow(fin_o); %helllo
     fin_o=uint8(fin_o);
    % e1=entropy(I)
%      e2=wentropy(fin_t,'shannon')
     [wq qw]=imhist(I);
     qw=qw*255;
     %plot(qw,wq);
     wq=wq/160000;
     sum=0;
     for i=1:256
         if(wq(i)~=0)
             sum=sum + wq(i)*log2(wq(i));
         end
     end
     sum=sum*-1;
     sum
     hello(:,:,ind)=fin_o;
     
%    M(i)=im2frame(fin_o);
    figure(),imshow(fin_t); %hello
    figure(),imshow(hello);    %hello
 end
% figure(),imshow(fin_t ,map1);
%figure(),imshow(fin_o,[0 255]);
%movie(M);