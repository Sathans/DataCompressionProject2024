function distance = Comp(neg_test,A, X)
%COMP Summary of this function goes here

% Negative tests
neg_size = size(neg_test);

x = ones(100,1);
for i=1:neg_size
    j = neg_test(i);
    x(A(j,:)>0)=0;
end
% positives = sum(x);
distance = sum((x-X).^2);


end


