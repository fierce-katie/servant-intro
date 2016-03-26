{-# LANGUAGE DeriveGeneric #-}
module Book where

import Data.Aeson
import GHC.Generics (Generic)

-- Just an assoc. list of some books.
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

-- Book ID.
type BookId = Int

-- Book representation.
data Book = Book
  { bookAuthor  :: String
  , bookTitle   :: String
  , bookYear    :: Int
  , bookInStock :: Int
  } deriving (Show, Generic)

-- Instances to convert Book to JSON.
instance ToJSON Book
instance FromJSON Book

