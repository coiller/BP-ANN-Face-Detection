%%
%Face Detection
%Author Sunyue

%%
clear all
close all
clc

%Hints
hints='**For image quality:\n\t 1 indicates a full-resolution image (128 columns * 120 rows)\n\t 2 indicates a half-resolution image (64 * 60)\n\t 4 indicates a quarter-resolution image (32 * 30).\n**For Catalogs:\n\t 2-pose,3-expression,4-glasses.\n ';
fprintf(hints);

%Get settings
str='Please input settings in this standard [image_quality,catalog,learn_rate,epoch,erro_limit,n_hidden]:\n';
settings=input(str);

%Read in images
[ train_list,validation_list,test_list,miss_count]=readin(settings(1));
fprintf(num2str(length(test_list)));
%Train a BP ANN
[train_err,val_err,best_in2hid,best_hid2out,step] = ...
    ann( train_list,settings(3),settings(6),validation_list,settings(4),settings(5),settings(2));
fprintf('Training is finished in %d epoch with training erro(%f) and validation erro(%f)!\n',step-1,train_err,val_err);

%test the BP ANN on test set
test_matrix=img2matrix(test_list);
test_answer=get_answer(test_list,settings(2));
test_err=cal_err(test_matrix,test_answer,best_in2hid,best_hid2out);
fprintf('Test is finished with erro(%f)!\n',test_err);


