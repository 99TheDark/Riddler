homeWinRate = 0.6
homeLoseRate = 1 - homeWinRate

cur = [homeWinRate, homeWinRate, homeLoseRate, homeLoseRate, homeWinRate, homeLoseRate, homeWinRate]
pre = [homeWinRate, homeWinRate, homeLoseRate, homeLoseRate, homeLoseRate, homeWinRate, homeWinRate]

function play(game::Vector{Float64}, step::Int64=1, chance::Float64=1.0)
    if step <= length(game)
        return chance * [play(game, step + 1, game[step]), play(game, step + 1, 1 - game[step])]
    else
        return [chance]
    end
end

function won(game::Vector{Float64}, step::Int64=1, wins::Int64=0)
    if step <= length(game)
        return [won(game, step + 1, wins + 1), won(game, step + 1, wins)]
    else
        return [wins]
    end
end

function flatten(vec::Vector)
    arr = []
    for val in vec
        if val isa Vector
            for flat in flatten(val)
                push!(arr, flat)
            end
        else
            push!(arr, val)
        end
    end
    return arr
end

function playAll(chances::Vector{Float64})::Float64
    probabilities = Vector{Float64}(flatten(play(chances)))
    wins = Vector{Int64}(flatten(won(chances)))
    winChance = 0
    for (prob, win) in zip(probabilities, wins)
        if 2win > length(chances)
            winChance += prob
        end
    end
    return winChance
end

function compareSeries()::Float64
    return abs(playAll(cur) - playAll(pre))
end

println(compareSeries())