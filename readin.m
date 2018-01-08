function [train_list,validation_list,test_list,miss_count] = readin(quality)

%Generate the information list of all image
%Detiles of the image database
%<userid> is the user id of the person in the image, and this field has 20 values
userid={'an2i'; 'at33'; 'boland'; 'bpm'; 'ch4f'; 'cheyer'; 'choon'; 'danieln';
    'glickman'; 'karyadi'; 'kawamura'; 'kk49'; 'megak'; 'mitchell'; 'night'; 'phoebe'; 'saavik';
    'steffi'; 'sz24';'tammo'};
%<pose> is the head position of the person, and this field has 4 values
pose={'straight'; 'left'; 'right'; 'up'};
%<expression> is the facial expression of the person, and this field has 4 values
expression={'neutral'; 'happy'; 'sad'; 'angry'};
%<eyes> is the eye state of the person, and this field has 2 values
eyes={'open';'sunglasses'};
% <scale> is the scale of the image, and this field has 3
% values: 1, 2, and 4.  1 indicates a full-resolution image ($128$ columns
% $\times$ $120$ rows); 2 indicates a half-resolution image ($64 \times 60$);
% 4 indicates a quarter-resolution image ($32 \times 30$).  For this
% assignment, you will be using the quarter-resolution images for experiments,
% to keep training time to a manageable level.
miss_count=0;
train_count=0;
validation_count=0;
test_count=0;
if quality==1
    quality='';
else
    quality=strcat('_',num2str(quality));
end
for i=1:length(userid)
    for j=1:length(pose)
        for k=1:length(expression)
            for l=1:length(eyes)
                %generate the file path
                path=strcat('E:\study\MachineLearning\course\faces\faces\',userid(i),'\',...
                    userid(i),'_',pose(j),'_',expression(k),'_',eyes(l),quality,'.pgm');
                try
                    imread(path{1});
                catch
                    miss_count=miss_count+1;  %jump missing images
                    continue;
                end
                %coding the result of the image
                pose_code=[0.1,0.1,0.1,0.1];
                expression_code=[0.1,0.1,0.1,0.1];
                eyes_code=[0.1,0.1];
                pose_code(j)=0.9;
                expression_code(k)=0.9;
                eyes_code(l)=0.9;
                r=randi(4);%generate a random int number between 1~5
                if r<=2
                    train_count=train_count+1;
                    train_list{train_count}={path{1},pose_code,expression_code,eyes_code};%train set
                elseif r==3
                    validation_count=validation_count+1;
                    validation_list{validation_count}={path{1},pose_code,expression_code,eyes_code};%validation set
                else
                    test_count=test_count+1;
                    test_list{test_count}={path{1},pose_code,expression_code,eyes_code};%test set
                end
            end
        end
    end
end
end

