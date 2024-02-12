module gen
generations = 1000
generation = 0
N = 100
p = 0.5
pvals = Array{Float64}(undef,generations)
end

function generation()
    draws = 2 * gen.N
    a1 = 0
    a2 = 0
    for i = 1:draws
        if rand(Float64) < gen.p
            a1 += 1
        else
            a2 += 1
        end
    end
    gen.p = a1 / draws
    gen.generation += 1
    gen.pvals[gen.generation] = gen.p
end

function calc_alleles()
    
    arr = Array{Int32}(undef,gen.generations)
    for i = 1:gen.generations
            arr[i] = i
    end
    
    x = arr;
    y = gen.pvals;
    p = plot(x, y, ylims = (0, 1), legend=false)

    for i = 1:10
        for i = 1:gen.generations
            generation()
            print("generation ", i, ": p = ", gen.p, " q = ", 1 - gen.p, "\n")
        end
        y = gen.pvals;
        gen.pvals = Array{Float64}(undef,gen.generations)
        gen.generation = 0
        gen.p = 0.5
        plot!(p, x, y)
    end

    display(plot(p))

    readline()
end

import Pkg
Pkg.add("Plots")
using Plots
gr()
calc_alleles()
