{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module API where

import Data.Proxy
import Data.Swagger

import Servant.API
import Servant.Swagger

import Book

-- RESTful API for books.
-- /books (GET | POST)
-- /books/:book_id (GET | DELETE | PUT)
type BooksAPI
     = Get '[JSON] [(BookId, Book)]
  :<|> ReqBody '[JSON] Book      :> Post '[JSON] BookId
  :<|> Capture "book_id" BookId  :> Get '[JSON] Book
  :<|> Capture "book_id" BookId  :> Delete '[JSON] ()
  :<|> Capture "book_id" BookId  :> QueryParam "author" String :>
       QueryParam "title" String :> QueryParam "year" Int      :>
       QueryParam "in_stock" Int :> Put '[JSON] Book

-- | BooksAPI Swagger specification.
booksSwagger :: Swagger
booksSwagger = toSwagger (Proxy :: Proxy BooksAPI)
