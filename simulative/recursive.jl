homeWinRate = 0.6
homeLoseRate = 1 - homeWinRate

cur = [homeWinRate, homeWinRate, homeLoseRate, homeLoseRate, homeWinRate, homeLoseRate, homeWinRate]
pre = [homeWinRate, homeWinRate, homeLoseRate, homeLoseRate, homeLoseRate, homeWinRate, homeWinRate]

function play(chances::Vector{Float64}, homeWins::Int64=0, homeLosses::Int64=0)::Bool
    numTurns = homeWins + homeLosses + 1

    if rand() < chances[numTurns]
        homeWins += 1
    else
        homeLosses += 1
    end

    if homeWins >= 4
        return true
    elseif homeLosses >= 4
        return false
    end

    return play(chances, homeWins, homeLosses)
end

function simulate(count::Int64)::Float64
    curwins = 0
    prewins = 0

    for _ in 1:count
        if play(cur)
            curwins += 1
        end

        if play(pre)
            prewins += 1
        end
    end

    println(prewins / count * 100)
    println(curwins / count * 100)

    return abs(curwins - prewins) / count
end

@time println(simulate(100000000))