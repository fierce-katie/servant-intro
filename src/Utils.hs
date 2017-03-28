module Utils where

import Data.Char (toUpper, toLower)
import Data.List.Split (wordsBy)

-- Drop the given prefix length and convert the rest of the string to @CamelCase@,
-- leaving the first letter in lowercase.
camelCaseName :: String -> (String -> String)
camelCaseName prefix = headToLower . toCamelCase . drop (length prefix)
  where
    headToLower [] = []
    headToLower (x : xs) = toLower x : xs

-- Convert @snake_case@ to @CamelCase@.
toCamelCase :: String -> String
toCamelCase = concatMap capitalize . wordsBy (== '_')
  where
    capitalize [] = []
    capitalize (c:cs) = (toUpper c : cs)
