lambda = 10;
n = 10^4;
X = zeros(1, n);
X(1) = 0;

pi = @(x) (lambda^x * exp(-lambda)) / factorial(x);
q = @(x, y) (x >= 1 && (y == x+1 || y == x-1)) * 0.5 + ...
            (x == 0 && (y == 0 || y == 1)) * 0.5;

for i = 2:n
    if X(i-1) == 0
        proposal = randsample([0, 1], 1, true, [0.5, 0.5]);
    else
        proposal = randsample([X(i-1)-1, X(i-1)+1], 1, true, [0.5, 0.5]);
    end
    r = (pi(proposal) * q(proposal, X(i-1))) / (pi(X(i-1)) * q(X(i-1), proposal));
    r = min(r, 1);
    if rand <= r
        X(i) = proposal;
    else
        X(i) = X(i-1);
    end
end

figure;
subplot(2, 2, 1);
histogram(X(25:50), 'Normalization', 'probability');
title('Histogram of X_{25} to X_{50}');
xlabel('State');
ylabel('Probability');

subplot(2, 2, 2);
histogram(X(50:100), 'Normalization', 'probability');
title('Histogram of X_{50} to X_{100}');
xlabel('State');
ylabel('Probability');

subplot(2, 2, 3);
histogram(X(500:1000), 'Normalization', 'probability');
title('Histogram of X_{500} to X_{1000}');
xlabel('State');
ylabel('Probability');

subplot(2, 2, 4);
histogram(X(5000:10000), 'Normalization', 'probability');
title('Histogram of X_{5000} to X_{10000}');
xlabel('State');
ylabel('Probability');
