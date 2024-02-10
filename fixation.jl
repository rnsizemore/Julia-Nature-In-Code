module gen
generations = 100
generation = 0
N = 100
p = 1 / (2 * N)
pvals = Array{Float64}(undef,generations)
population_sizes = Array{Int32}(undef,generations)
simulations = 100000
mutants = 0
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
end

function run_until_fixation()
    gens_success = []
    for i = 1:gen.simulations
        gen.p = 1 / (2*gen.N)
        while gen.p > 0
            generation()
            if gen.p == 1
                gen.mutants += 1
                push!(gens_success, gen.generation)
                break
            end
        end
        if i % 100 == 0
            print("Ran simulation ", i, "\n")
        end
        gen.generation = 0
    end
    print("Mutation took ", mean(gens_success), " generations on average to fixate\n")
    print("Mutation fixated ", gen.mutants, " times in ", gen.simulations, " simulations\n")
end
using Statistics
run_until_fixation()