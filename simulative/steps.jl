homeWinRate = 0.6
homeLoseRate = 1 - homeWinRate

cur = [homeWinRate, homeWinRate, homeLoseRate, homeLoseRate, homeWinRate, homeLoseRate, homeWinRate]
pre = [homeWinRate, homeWinRate, homeLoseRate, homeLoseRate, homeLoseRate, homeWinRate, homeWinRate]

function play(arr)
    home = 0
    away = 0
    for chance in arr
        if rand() < chance
            home += 1
        else
            away += 1
        end

        if home >= 4
            return true
        elseif away >= 4
            return false
        end
    end
end

function simulate(simulations)
    curwins = 0
    prewins = 0

    for i in 1:simulations
        curgame = play(cur)
        pregame = play(pre)

        if curgame
            curwins += 1
        end

        if pregame
            prewins += 1
        end
    end

    println(prewins / simulations * 100)
    println(curwins / simulations * 100)

    return abs(curwins - prewins) / simulations
end

@time println(simulate(100000000))