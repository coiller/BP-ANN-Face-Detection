%show off
sample=randi(length(test_list));
[output,~ ] = cal_output( test_matrix(:,sample),best_in2hid,best_hid2out);
figure(2);
imshow(test_list{sample}{1});
fprintf(['Choose one image from test set.\nThe output is:',num2str(output'),'\nThe answer is:',num2str(test_answer(:,sample)'),'\n']);
