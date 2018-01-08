function [ matrix ] = img2matrix( list )
%Transform images to matrix
image=imread(list{1}{1});
n_in=length(image(:));
matrix=ones(n_in,length(list));
for i=1:length(list)
    image=imread(list{i}{1});
    image_unified=double(image)/255.0;    %Unified the image matrix
    matrix(:,i)=image_unified(:);      %construct the training matrix, every vector is one train_example
end
end

