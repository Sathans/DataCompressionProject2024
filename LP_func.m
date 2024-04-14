function distance = LP_func(pos_test, neg_test,A, X)
%LP Summary of this function goes here
%   Detailed explanation goes here


% Positive and negative tests
pos_size = size(pos_test);
neg_size = size(neg_test);

cvx_begin quiet
    variable z(100,1)
    minimize( norm(z,1))
    subject to
    for i=1:pos_size
        j = pos_test(i);
         A(j,:)*z >= 1;
    end

    for i=1:neg_size
        j = neg_test(i);
         A(j,:)*z == 0;
    end
    for i=1:100
        % z(i)<=1;
        z(i)>=0;
    end
cvx_end

z = round(z);

% if A*z == y
%     outcome = "Satisfying set";
% else
%     outcome = "No Satisfying set";
% end

% positives = sum(z);
distance = sum((z-X).^2);


end

