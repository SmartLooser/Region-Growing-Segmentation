%Region growing segmentation

clear
clc

img = imread('Coronal_04.jpg');
img = rgb2gray(img);
img = im2double(img);

figure
imshow(img)
title('Complete photo')

img = img(150:250,160:250);

figure
imshow(img)
title('Cropped')

[r,c]=size(img);

res = 0*img;
a = 0*img;

[x,y] = find(img==0.9686);

res(x,y) = 1;
a(x,y) = img(x,y);

thresh=25;

for iter=1:50
   for i=1:r-1                      
      temp=img(i,:).*res(i+1,:);
      m=mean(a,'all');
      temp=abs(m-temp);
      b=find(temp<thresh);
      temp(b)=0;
      a(i,:) = temp;
      f=find(temp>=thresh);
      temp(f)=1;
      res(i,:)=temp|res(i,:);
   end
   
   for i=r:-1:2
      temp=img(i,:).*res(i-1,:);
      m=mean(a,'all');
      temp=abs(m-temp);
      b=find(temp<thresh);
      temp(b)=0;
      a(i,:) = temp;
      f=find(temp>=thresh);
      temp(f)=1;
      res(i,:)=temp|res(i,:);
   end
         
   for i=1:c-1
      temp=img(:,i).*res(:,i+1);
      m=mean(a,'all');
      temp=abs(m-temp);
      b=find(temp<thresh);
      temp(b)=0;
      a(:,i) = temp;
      f=find(temp>=thresh);
      temp(f)=1;
      res(:,i)=temp|res(:,i);
   end
    
   for i=c:-1:2
      temp=img(:,i).*res(:,i-1);
      m=mean(a,'all');
      temp=abs(m-temp);
      b=find(temp<thresh);
      temp(b)=0;
      a(:,i) = temp;
      f=find(temp>=thresh);
      temp(f)=1;
      res(:,i)=temp|res(:,i);
   end
end

figure, imshow(a)
figure, imshow(res)