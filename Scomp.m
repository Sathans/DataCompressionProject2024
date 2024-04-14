function distance = Scomp(pos_test, neg_test,A, X)
%SCOMP Summary of this function goes here

% Positive and negative tests
pos_size = size(pos_test);
neg_size = size(neg_test);


% SCOMP
% Initialize 
x = zeros(100,1);
x_temp = ones(size(x))*0.1; % set all to uncertain

% Set negatives to 0
for i=1:neg_size
    j = neg_test(i);
    x_temp(A(j,:)>0)=0;
end

% If there is only 1 uncertain in pos, set to 1
for i=1:pos_size
    j = pos_test(i);
    if (A(j,:)*x_temp==0.1)    % only 1 uncertain in test
        idx = and(x_temp, A(j,:)');
        x_temp(idx==1)=1;
        x(idx==1)=1;     % set to def_pos
    end
end

% Create list of uncertain tests
unc_test=[];
for i=1:pos_size
    j = pos_test(i);
    if (A(j,:)*x==0)    % no def_pos in test
        unc_test(end+1)=j;
    end
end


unexplained = zeros(size(x));
unexplained(x_temp==0.1) = 0.1;
% Search for most common x in unexplained tests
while sum(unc_test)>0
    for i=1:size(unc_test,2)
        j=unc_test(i);
        unexplained = unexplained + ...
            and(unexplained, A(j,:)')/10;
    end
    % Add most common to def_pos
    [~,idx] = max(unexplained);
    x(idx)=1;
    unexplained(idx) = 0;
    unexplained(unexplained>0) = 0.1;

    % Check for explained tests
    for i=size(unc_test,2):-1:1
        j = unc_test(i);
        if (A(j,:)*x > 0)    % def_pos in test
            unc_test(unc_test==j)=[];
        end
    end

end

% positives = sum(x);
distance = sum((x-X).^2);


end

