import Pkg
Pkg.add("Plots")
using Plots

s = 0.1
h = 0.2
pdata = []
data = []
x_max = 100

for i = 1:x_max
    p = i/100
    push!(pdata, p)
    q = 1-p
    delta_p = (p*q*s * (p*h + q*(1-h))) / (1 - p*q*h*s - q*2*s)
    push!(data, delta_p)
end

x = pdata
y = data
display(plot(x, y))

readline()