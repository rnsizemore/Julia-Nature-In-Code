import Pkg
Pkg.add("Plots")
using Plots
module vars
s = 0.1
h = 0.2
p = 0.01
pdata = []
end

for i = 1:400
    q = 1-vars.p
    delta_p = (vars.p*q*vars.s * (vars.p*vars.h + q*(1-vars.h))) / (1 - vars.p*q*vars.h*vars.s - q*2*vars.s)
    vars.p = vars.p + delta_p
    push!(vars.pdata, vars.p)
end

x = 1:400
y = vars.pdata
display(plot(x, y))
readline()