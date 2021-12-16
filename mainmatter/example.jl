import Plots
f(x) = log(x)
derivative(f, x, δ) = (f(x + δ) - f(x))/δ
δs = 10 .^(-collect(BigFloat(0.):BigFloat(20.)))
dfdx = [derivative(f, 1, δ) for δ in δs]
Plots.plot(δs, dfdx)


δs = 10 .^(-collect(0.:20.))
