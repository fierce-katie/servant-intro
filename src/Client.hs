{-# LANGUAGE RecordWildCards #-}
module Client where

import Data.Proxy
import Control.Monad.Trans.Either
import Servant
import Servant.Client

import API
import Book

type ServantResponse a = EitherT ServantError IO a

-- Make client given server's base URL.
mkAPIClient :: BaseUrl -> Client BooksAPI
mkAPIClient = client (Proxy :: Proxy BooksAPI)

-- Client functions according to BooksAPI.
data BooksClient = BooksClient
  { listBooks :: ServantResponse [(BookId, Book)]
  , addBook :: Book -> ServantResponse BookId
  , getBook :: BookId -> ServantResponse Book
  , deleteBook :: BookId -> ServantResponse ()
  , updateBook :: BookId -> Maybe String -> Maybe String -> Maybe Int -> Maybe Int -> ServantResponse Book
  }

-- Make bookshop client.
mkBookshopCLient :: BaseUrl -> BooksClient
mkBookshopCLient url = BooksClient{..}
  where
    booksClient = mkAPIClient url

    (listBooks
      :<|> addBook
      :<|> getBook
      :<|> deleteBook
      :<|> updateBook) = booksClient

