data {
  int<lower=1> n;
  vector[n] y;
}
parameters {
  # 確率的レベル
  vector[n] mu;
  # 確定的傾き
  real v;
  # レベル撹乱項
  real<lower=0> sigma_level;
  # 観測撹乱項
  real<lower=0> sigma_irreg;
}
transformed parameters {
  vector[n] yhat;
  for(t in 1:n) {
    yhat[t] <- mu[t];
  }
}
model {
  # 式 3.3
  for(t in 2:n)
    mu[t] ~ normal(mu[t-1] + v, sigma_level);
  for(t in 1:n)
    y[t] ~ normal(yhat[t], sigma_irreg);
}
