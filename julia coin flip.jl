function coin_test()
    heads = 0
    tails = 0
    coins = 10
    for i = 1:coins
        if rand(Float64) > 0.5
            heads += 1
        else
            tails += 1
        end
    end
    if heads == 8
        return true
    else
        return false
    end
end

function calc_prob()
    repeats = 10000
    count = 0
    prob = 0
    for i = 1:repeats
        if coin_test()
            count += 1
        end
    end
    prob = count / repeats
    print("Chance for 8 heads and 2 tails: ", prob * 100, "%")
end

calc_prob()