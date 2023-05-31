homeWinRate = 0.6
homeLoseRate = 1 - homeWinRate

cur = [homeWinRate, homeWinRate, homeLoseRate, homeLoseRate, homeWinRate, homeLoseRate, homeWinRate]
pre = [homeWinRate, homeWinRate, homeLoseRate, homeLoseRate, homeLoseRate, homeWinRate, homeWinRate]

function playGame(chances::Vector{Float64}, options::Vector{UInt8})::Float64
    chance = 1
    wins = 0
    for i in 1:length(options)
        rate = chances[i]
        if options[i] == 1
            chance *= rate
            wins += 1
        else
            chance *= 1 - rate
        end
    end
    return chance * (2wins > length(options) ? 1 : -1)
end

function playAll(chances::Vector{Float64}, count::Int64)::Float64
    winChance = 0
    total = 2^count - 1
    for i in 0:total
        binary = chop(head=(64 - count), tail=0, bitstring(i))
        vals = [parse(Int64, x) for x in binary]
        game = playGame(chances, Vector{UInt8}(vals))
        if game >= 0
            winChance += game
        end
    end
    return winChance
end

function compareSeries(gamesInSeries::Int64)::Float64
    return abs(playAll(cur, gamesInSeries) - playAll(pre, gamesInSeries))
end

@time println(compareSeries(7))