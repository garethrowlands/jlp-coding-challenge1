module FormatTime
where

import Data.List (find, unfoldr)

timePeriods :: [(Integer, String)]
timePeriods = [
        (year, "year"),
        (day, "day"),
        (hour, "hour"),
        (minute, "minute"),
        (second, "second")
    ]
    where
        second = 1
        minute = 60 * second
        hour   = 60 * minute
        day    = 24 * hour
        year   = 365 * day
        

formatTime 0 = "none"
formatTime seconds = listify . map pluralise $ periods
    where periods = unfoldr findBiggestPeriod seconds

findBiggestPeriod seconds = do
    (n,period) <- find (\(n,_)->seconds>=n) timePeriods
    let (periodCount,remainder) = seconds `divMod` n
    return ((periodCount,period), seconds-n*periodCount)

listify [] = []
listify [a] = a
listify [a,b] = a ++ " and " ++ b
listify (a:as) = a ++ ", " ++ listify as

pluralise (n,word)
    | n==1       = show n ++ " " ++ word
    | otherwise  = show n ++ " " ++ word ++ "s"
