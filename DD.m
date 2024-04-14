function distance = DD(pos_test, neg_test, A, X)

% Positive and negative tests
pos_size = size(pos_test);
neg_size = size(neg_test);

% DD
x = ones(100,1)/2;
for i=1:neg_size
    j = neg_test(i);
    x(A(j,:)>0)=0;
end

for i=1:pos_size
    j = pos_test(i);
    if (A(j,:)*x==0.5)
        idx = and(x, A(j,:)');
        x(idx==1)=1;
    end
end

x(x<1)=0;

distance = sum((x-X).^2);


end

