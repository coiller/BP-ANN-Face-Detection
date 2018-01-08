function [ output,out_hid ] = cal_output( example,weight_in2hid,weight_hid2out )
%Calculate output for each layer
example=[example
    1];%add threshold
%hidden layer output
out_hid=sigmoid(weight_in2hid*example);
%final output
hid=[out_hid
    1];%add threshold
output=sigmoid(weight_hid2out*hid);

end

