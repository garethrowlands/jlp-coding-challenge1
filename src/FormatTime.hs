module FormatTime
where

import Data.List (find, unfoldr)

type Period = String

timePeriods :: [(Integer, Period)]
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

findBiggestPeriod :: Integer -> Maybe ((Integer,Period),Integer)
findBiggestPeriod seconds = do
    (n,period) <- find (\(n,_)->seconds>=n) timePeriods
    let (periodCount,remainder) = seconds `divMod` n
    return ((periodCount,period), seconds-n*periodCount)

listify :: [String]->String
listify [] = []
listify [a] = a
listify [a,b] = a ++ " and " ++ b
listify (a:as) = a ++ ", " ++ listify as

pluralise :: (Integer,String)->String
pluralise (n,word)
    | n==1       = show n ++ " " ++ word
    | otherwise  = show n ++ " " ++ word ++ "s"
