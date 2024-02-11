import Pkg
Pkg.add("Plots")
using Plots
module vars
s = 0.1
# h < 0 for balancing, h > 1 for disruptive
h = 1.5
pvals = 0.01:0.01:0.99
ptests = Array{Array{Float64}}(undef, 0)
end
function simulation(p)
    plist = []
    for i = 1:300
        q = 1-p
        delta_p = (p*q*vars.s * (p*vars.h + q*(1-vars.h))) / (1 - p*q*vars.h*vars.s - q*2*vars.s)
        p = p + delta_p
        push!(plist, p)
    end
    push!(vars.ptests, copy(plist))
end

for i = 1:length(vars.pvals)
    simulation(vars.pvals[i])
end

x = 1:300
y = vars.ptests[1]
p = plot(x, y, legend=false)

for i = 1:99
    plot!(p, x, vars.ptests[i])
end

display(p)

readline()