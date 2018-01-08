function [train_err,val_err,best_in2hid,best_hid2out,step] = ...
    ann( train_examples,learn_rate,n_hidden,validation_examples,epoch,aim,catalog )
%Use the train set train an BP ANN
%catalog:2-pose,3-expression,4-glasses

%% Initionation
%initial input&output number
image=imread(train_examples{1}{1});
n_in=length(image(:));
n_out=length(train_examples{1}{catalog});
%inital matrixes
train_matrix=img2matrix(train_examples);
validation_matrix=img2matrix(validation_examples);
train_answer=get_answer(train_examples,catalog);
validation_answer=get_answer(validation_examples,catalog);
%inital the weights in ANN
weight_in2hid=-0.05+0.1.*rand(n_hidden,n_in+1);
weight_hid2out=-0.05+0.1.*rand(n_out,n_hidden+1);
%inital the best result for validation
val_err_min=inf;
%inital train_err
train_err=inf;
%inital the count for inner iteration
count=0;
%inital the current step
step=1;
%inital the momentum
a=0.3;
%inital the adjust weight of last time
hid2out_adj_last=zeros(size(weight_hid2out));
in2hid_adj_last=zeros(size(weight_in2hid));
%inital figure
figure(1);
%subplot(2,1,1);%train_erro
axis([1,epoch,0,inf]);
%title('Training erro of each epoch');
%xlabel('Epoch');
%ylabel('Training Erro');
%subplot(2,1,2);%validation_erro
%axis([1,epoch,0,inf]);
%title('Validation erro of each epoch');
%xlabel('Epoch');
%ylabel('Validation Erro');

%% Trianning
while (step<=epoch&&train_err>aim) %stop when reach the set epoch or aim
    
    %generate sample sequence
    if count==0     %one round is over
        count=size(train_examples,2);
        train_seq=randperm(count);  %generate a new sequence for each round
    end
    
    %calculate outputs
    example=train_matrix(:,train_seq(count));
    [output,out_hid]=cal_output( example,weight_in2hid,weight_hid2out );
    
    %calcualate gradients
    %calculate the gradient of output erro
    e_out=output.*(ones(length(output),1)-output)...
        .*(train_answer(:,train_seq(count))-output);
    %calculate the gradient erro of hidden layer
    e_hid=out_hid.*(ones(length(out_hid),1)-out_hid)...
        .*(weight_hid2out(:,1:n_hidden)'*e_out);
    
    %adjust weights
    %adjust weight_hid2out
    temp=[out_hid',1];
    hid2out_adj=learn_rate.*e_out*temp+a.*hid2out_adj_last;
    hid2out_adj_last=hid2out_adj;   %update log
    weight_hid2out=weight_hid2out+hid2out_adj;
    
    %adjust weight_in2hid
    temp=[example',1];
    in2hid_adj=learn_rate.*e_hid*temp+a.*in2hid_adj_last;
    in2hid_adj_last=in2hid_adj; %update log
    weight_in2hid=weight_in2hid+in2hid_adj;
    
    %calculate the erro on trainning set
    train_err=cal_err(train_matrix,train_answer,weight_in2hid,weight_hid2out);
    
    %plot training erro
    %subplot(2,1,1);
    hold on;
    plot(step,train_err,'r.');
    
    %calculate the erro on validation set
    val_err=cal_err(validation_matrix,validation_answer,weight_in2hid,weight_hid2out);
   % subplot(2,1,2);%plot validation erro
    hold on;
    if double(val_err)<double(val_err_min)
        val_err_min=val_err;    %update the minimum validation err
        plot(step,val_err,'b.')
        %update the best_weight
        best_in2hid=weight_in2hid;
        best_hid2out=weight_hid2out;
    else
        plot(step,val_err,'b.')
        % break;  %get the result
    end
        
    %update counters
    count=count-1;
    step=step+1;
end
end

