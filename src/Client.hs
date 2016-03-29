{-# LANGUAGE RecordWildCards #-}
module Client where

import Data.Proxy
import Control.Monad.Trans.Except
import Network.HTTP.Client hiding (Proxy)
import Servant
import Servant.Client

import API
import Book

type ServantResponse a = ExceptT ServantError IO a

-- BaseUrl for localhost:8800.
localhost8800 :: BaseUrl
localhost8800 = BaseUrl Http "localhost" 8800 "/books"

-- Make client given server's base URL.
mkAPIClient :: BaseUrl -> Manager -> Client BooksAPI
mkAPIClient = client (Proxy :: Proxy BooksAPI)

-- Client functions according to BooksAPI.
data BooksClient = BooksClient
  { listBooks :: ServantResponse [(BookId, Book)]
  , addBook :: Book -> ServantResponse BookId
  , getBook :: BookId -> ServantResponse Book
  , deleteBook :: BookId -> ServantResponse ()
  , updateBook :: BookId -> Maybe String -> Maybe String -> Maybe Int -> Maybe Int -> ServantResponse Book
  }

-- Make bookshop client with manager.
mkClientWithManager :: IO BooksClient
mkClientWithManager = do
  manager <- newManager defaultManagerSettings
  mkBookshopClient manager

-- Make bookshop client.
mkBookshopClient :: Manager -> IO BooksClient
mkBookshopClient manager = return BooksClient{..}
  where
    booksClient = mkAPIClient localhost8800 manager

    (listBooks
      :<|> addBook
      :<|> getBook
      :<|> deleteBook
      :<|> updateBook) = booksClient

