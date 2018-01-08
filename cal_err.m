function [ err ] = cal_err(examples,answers,weight_in2hid,weight_hid2out )
%Calculate the erro for exemple set
err=0.0;
    for i=1:size(examples,2)  %for each exemple
    example=examples(:,i);
    [output,~]=cal_output(example,weight_in2hid,weight_hid2out);
    err=err+sum((answers(:,i)-output).^2);
    end
err=double(err)/(2*size(examples,2));
end

