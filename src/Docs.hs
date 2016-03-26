{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE DataKinds #-}
module Docs where

import Data.Proxy
import Servant.Docs
import Servant.API

import API
import Book

-- Generate documentation for given API.
apiDocs :: API
apiDocs = docs (Proxy :: Proxy BooksAPI)

-- Save generated documentation to docs.md.
saveDocs :: IO ()
saveDocs = writeFile "docs.md" (markdown apiDocs)

-- Instances that give explanations for query params, request bodies, etc.
instance ToCapture (Capture "book_id" BookId) where
  toCapture _ =
    DocCapture "book_id" "Book ID"

instance ToParam (QueryParam "author" String) where
  toParam _ =
    DocQueryParam "author"
                  ["John Doe", "..."]
                  "Author name"
                  Normal

instance ToParam (QueryParam "title" String) where
  toParam _ =
    DocQueryParam "title"
                  ["A book I wrote", "..."]
                  "Book title"
                  Normal

instance ToParam (QueryParam "year" Int) where
  toParam _ =
    DocQueryParam "year"
                  ["1990", "1735"]
                  "Year published"
                  Normal

instance ToParam (QueryParam "in_stock" Int) where
  toParam _ =
    DocQueryParam "in_stock"
                  ["256", "31"]
                  "Number of books in stock"
                  Normal

instance ToSample Int where
  toSamples _ = noSamples

instance ToSample Book where
  toSamples _ = noSamples

