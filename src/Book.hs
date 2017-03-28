{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TemplateHaskell #-}
module Book where

import Data.Aeson
import Data.Aeson.TH
import Data.Aeson.Encode.Pretty
import qualified Data.ByteString.Lazy as BSL
import qualified Data.Text as Text
import Data.Text.Encoding
import GHC.Generics (Generic)

import Utils

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

ppBookJSON :: Book -> IO ()
ppBookJSON = putStrLn . Text.unpack . decodeUtf8 . BSL.toStrict . encodePretty

-- Instances to convert Book to JSON.
deriveJSON defaultOptions { fieldLabelModifier = camelCaseName "Book" } ''Book
