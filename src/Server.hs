{-# LANGUAGE RecordWildCards #-}
module Server where

import Servant
import Control.Monad.Trans.Either
import Control.Monad.Except
import Data.Maybe

import API
import Book

type ServantResponse a = EitherT ServantErr IO a

-- Server for BookshopAPI
server :: Server BookshopAPI
server = serveBooks

-- Server for BooksAPI
serveBooks :: Server BooksAPI
serveBooks = listBooks :<|> addBook :<|> getBook :<|> deleteBook :<|> updateBook

-- /books (GET)
listBooks :: ServantResponse [(BookId, Book)]
listBooks = return bookStore

-- /books (POST)
addBook :: Book -> ServantResponse BookId
addBook _ = throwError err501

-- /book/:book_id (GET)
getBook :: BookId -> ServantResponse Book
getBook bid = do
  let mbook = lookup bid bookStore
  case mbook of
    Just book -> return book
    Nothing -> throwError err404

-- /book/:book_id (DELETE)
deleteBook :: BookId -> ServantResponse ()
deleteBook _ = throwError err501

-- /book/:book_id (PUT)
updateBook :: BookId -> Maybe String -> Maybe String -> Maybe Int -> Maybe Int -> ServantResponse Book
updateBook _ Nothing Nothing Nothing Nothing = throwError err400
updateBook bid mname mtitle myear mn = do
  let mbook = lookup bid bookStore
  case mbook of
    Just book -> return (maybeUpdate book)
    Nothing -> throwError err404
  where
    maybeUpdate book@Book{..} = book
      { bookAuthor  = fromMaybe bookAuthor mname
      , bookTitle   = fromMaybe bookTitle mtitle
      , bookYear    = fromMaybe bookYear myear
      , bookInStock = fromMaybe bookInStock mn
      }

