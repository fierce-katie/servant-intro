{-# LANGUAGE DeriveGeneric #-}
module Book where

import Data.Aeson
import GHC.Generics (Generic)

bookStore :: [(BookId, Book)]
bookStore = zip [1..]
  [ Book
      "Richard Dawkins"
      "The God Delusion"
      2006
      666
  , Book
      "Benjamin C. Pierce"
      "Types and Programming Languages"
      2002
      67
  , Book
      "George Orwell"
      "1984"
      1949
      231
  ]

type BookId = Int

data Book = Book
  { bookAuthor  :: String
  , bookTitle   :: String
  , bookYear    :: Int
  , bookInStock :: Int
  } deriving Generic

instance ToJSON Book
instance FromJSON Book

