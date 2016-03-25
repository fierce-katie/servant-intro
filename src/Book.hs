{-# LANGUAGE DeriveGeneric #-}
module Book where

import Data.Aeson
import GHC.Generics (Generic)

type BookId = Int

data Book = Book
  { bookAuthor  :: String
  , bookTitle   :: String
  , bookYear    :: Int
  , bookInStock :: Int
  } deriving Generic

instance ToJSON Book
instance FromJSON Book

