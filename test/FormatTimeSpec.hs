module FormatTimeSpec
where

import Test.Hspec
import Test.QuickCheck
import Control.Monad

import FormatTime

examples = [
        (1, "1 second"),
        (62, "1 minute and 2 seconds"),
        (3662, "1 hour, 1 minute and 2 seconds"),
        (3*365*24*60*60 + 24*60, "3 years and 24 minutes"),
        (3*24*60*60 + 4*60*60 + 60, "3 days, 4 hours and 1 minute")
    ]

spec :: Spec
spec = do
    describe "listify - convert to english list" $ do
        it "listify ['a'] => 'a'" $
            listify ["a"] `shouldBe` "a"
        it "listify ['a,b'] => 'a and b'" $
            listify ["a","b"] `shouldBe` "a and b"
        it "listify ['a,b,c'] => 'a, b and c'" $
            listify ["a","b","c"] `shouldBe` "a, b and c"
    describe "pluralise - convert to english plural" $ do
        it "adds s to plurals" $
            pluralise (2, "second") `shouldBe` "2 seconds"
        it "leaves singular alone" $
            pluralise (1, "day") `shouldBe` "1 day"
    describe "findBiggestPeriod - find period, count and remainder" $ do
        it "finds seconds" $
            findBiggestPeriod 59 `shouldBe` Just ((59,"second"),0)
        it "finds minutes and remaining seconds" $
            findBiggestPeriod 62 `shouldBe` Just ((1,"minute"),2)
        it "finds hours (multiple)" $
            findBiggestPeriod 7201 `shouldBe` Just ((2,"hour"),1)
        it "finds days" $
            findBiggestPeriod (60*60*24) `shouldBe` Just ((1,"day"),0)
        it "finds years" $
            findBiggestPeriod (60*60*24*365) `shouldBe` Just ((1,"year"),0)
    describe "formatTime - convert period in seconds to english" $
        forM_ examples $ \(n,s)->
        it (show n ++ " => " ++ s) $
            formatTime n `shouldBe` s
