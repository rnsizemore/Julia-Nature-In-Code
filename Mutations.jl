module genes
sequence_count = 100
sequence_length = 20
sequences = Array{Array{String}}(undef, sequence_count)
original_sequence = Array{String}(undef, sequence_length)
gens = 100
mutation_rate = 0.0001 # 1 / 10000 chance for mutation
BASES = ["A", "G", "C", "T"]
end

function random_base(current_base)
    # generate random num 1-4 (index starts at 1 ewww) and uses corresponding base
    index = floor(Int, rand(Float64) * 4)+1
    new_Base = genes.BASES[index]
    # if mutating, run until a new base is generated
    while new_Base == current_base
        index = floor(rand((1,4)))
        new_Base = genes.BASES[index]
    end
    return new_Base
end
function generate_original_sequence()
    #fills original sequence with random bases
    for i = 1:genes.sequence_length
        genes.original_sequence[i] = random_base("")
    end
end
function generate_first_generation()
    generate_original_sequence()
    # sets all sequences to original
    for i = 1:genes.sequence_count
        genes.sequences[i] = copy(genes.original_sequence)
    end
end
function print_sequences(title)
    # loops through each sequence and does print_sequence on it
    print(title)
    for i = 1:genes.sequence_count
        print_sequence(genes.sequences[i])
        print(' ')
    end
end
function print_sequence(sequence)
    # loops through each base in sequence and prints it
    sequence_string = ""
    for i = 1:genes.sequence_length
        sequence_string = sequence_string * sequence[i]
    end
    print(sequence_string * "\n")
end

function run_generations()
    #for every generation
    for i = 1:genes.gens
        # for each sequence
        for j = 1:genes.sequence_count
            # for each base in the sequences
            for k = 1:genes.sequence_length
                # if it is randomly chosen to mutate on that base then pick a random new base
                mutation_rand = rand(Float64)
                if mutation_rand < genes.mutation_rate
                    genes.sequences[j][k] = random_base(genes.sequences[j][k])
                end
            end
        end
    end
end

generate_first_generation()
print_sequences("Generation 0: ")
run_generations()
print_sequences("\n After 100 generations: ")
