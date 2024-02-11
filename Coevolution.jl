import Pkg
Pkg.add("Plots")
using Plots

module vars
data = []
generations = 400

host_frequencies = [0.0, 0.0]
parasite_frequencies = [0.0, 0.0]
sum_host_frequencies = 0
sum_parasite_frequencies = 0

sh = 0.2
sp = 0.5
end

function initialize_frequencies()
    vars.host_frequencies[1] = rand(Float64)
    vars.host_frequencies[2] = 1 - vars.host_frequencies[1]
    vars.parasite_frequencies[1] = rand(Float64)
    vars.parasite_frequencies[2] = 1 - vars.parasite_frequencies[1]
    push!(vars.data, [vars.host_frequencies[1]])
    push!(vars.data, [vars.host_frequencies[2]])
    push!(vars.data, [vars.parasite_frequencies[1]])
    push!(vars.data, [vars.parasite_frequencies[2]])
end

function host_selection()
    vars.sum_host_frequencies = 0
    for i = 1:length(vars.host_frequencies)
        host_fitness = 0
        for j = 1:length(vars.parasite_frequencies)
            host_fitness = host_fitness + get_host_w_f(i, j)
        end
        vars.host_frequencies[i] = vars.host_frequencies[i] * host_fitness
        vars.sum_host_frequencies = vars.sum_host_frequencies + vars.host_frequencies[i]
    end
    for i = 1:length(vars.host_frequencies)
        vars.host_frequencies[i] = vars.host_frequencies[i] / vars.sum_host_frequencies
    end
end

function get_host_w_f(i, j)
    return (i == j ? 1-vars.sh : 1) * vars.parasite_frequencies[j]
end

function parasite_selection()
    vars.sum_parasite_frequencies = 0
    for i = 1:length(vars.parasite_frequencies)
        parasite_fitness = 0
        for j = 1:length(vars.host_frequencies)
            parasite_fitness = parasite_fitness + get_parasite_w_f(i, j)
        end
        vars.parasite_frequencies[i] = vars.parasite_frequencies[i] * parasite_fitness
        vars.sum_parasite_frequencies = vars.sum_parasite_frequencies + vars.parasite_frequencies[i]
    end
    for i = 1:length(vars.parasite_frequencies)
        vars.parasite_frequencies[i] = vars.parasite_frequencies[i] / vars.sum_parasite_frequencies
    end
end

function get_parasite_w_f(i, j)
    return (i == j ? 1 : 1-vars.sp) * vars.host_frequencies[j]
end

initialize_frequencies()
for i = 1:vars.generations
    host_selection()
    parasite_selection()
    push!(vars.data[1], vars.host_frequencies[1])
    push!(vars.data[2], vars.host_frequencies[2])
    push!(vars.data[3], vars.parasite_frequencies[1])
    push!(vars.data[4], vars.parasite_frequencies[2])
end

x = 1:1:401
y = vars.data[1]

p = plot(x, y, legend=false)
plot!(x, vars.data[2])
plot!(x, vars.data[3])
plot!(x, vars.data[4])
display(p)
readline()