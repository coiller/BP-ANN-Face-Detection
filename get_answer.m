function [ answer ] = get_answer( list ,cat)
%Get the anwser from list
answer=zeros(length(list{1}{cat}),length(list));
for i=1:length(list)
    answer(:,i)=(list{i}{cat})';
end
end

