{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Client where

import Data.Proxy
import Control.Monad.Trans.Except
import Network.HTTP.Client hiding (Proxy)
import Servant
import Servant.Client
import Servant.Client.Generic

import qualified GHC.Generics as GHC
import Generics.SOP

import API
import Book

-- BaseUrl for localhost:8800.
localhost8800 :: BaseUrl
localhost8800 = BaseUrl Http "localhost" 8800 "/books"

-- Client functions according to BooksAPI.
data BooksClient = BooksClient
  { listBooks :: ClientM [(BookId, Book)]
  , addBook :: Book -> ClientM BookId
  , getBook :: BookId -> ClientM Book
  , deleteBook :: BookId -> ClientM ()
  , updateBook :: BookId -> Maybe String -> Maybe String -> Maybe Int -> Maybe Int -> ClientM Book
  } deriving GHC.Generic

instance Generic BooksClient
instance (Client BooksAPI ~ client) => ClientLike client BooksClient
