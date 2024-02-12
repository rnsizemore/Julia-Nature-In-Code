module gen
generations = 100
generation = 0
N = 1000
p = 1 / (2 * N)
pvals = Array{Float64}(undef,generations)
population_sizes = Array{Int32}(undef,generations)
end

function generation()
    if gen.generation % 10 == 9
        gen.N = 10
    else
        gen.N = 1000
    end
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
    gen.population_sizes[gen.generation] = gen.N
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
        print(effective_pop_size())
        y = gen.pvals;
        gen.pvals = Array{Float64}(undef,gen.generations)
        gen.generation = 0
        gen.p = 1 / (2 * gen.N)
        plot!(p, x, y)
    end

    display(plot(p))

    readline()
end

function effective_pop_size()
    denom = 0
    for i = 1:gen.generations
        denom += 1 / gen.population_sizes[i]
    end
    return Int32(round(gen.generations / denom))
end

import Pkg
Pkg.add("Plots")
using Plots
gr()
calc_alleles()
