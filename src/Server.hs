{-# LANGUAGE RecordWildCards #-}
module Server where

import Servant
import Control.Monad.Trans.Except
import Control.Monad.Except
import Data.Maybe

import API
import Book

-- Server for BooksAPI.
serveBooks :: Server BooksAPI
serveBooks = listBooks :<|> addBook :<|> getBook :<|> deleteBook :<|> updateBook

-- GET /books
listBooks :: Handler [(BookId, Book)]
listBooks = return bookStore

-- POST /books
addBook :: Book -> Handler BookId
addBook _ = throwError err501

-- GET /book/:book_id
getBook :: BookId -> Handler Book
getBook bid = do
  let mbook = lookup bid bookStore
  case mbook of
    Just book -> return book
    Nothing -> throwError err404

-- DELETE /book/:book_id
deleteBook :: BookId -> Handler ()
deleteBook _ = throwError err501

-- PUT /book/:book_id
updateBook :: BookId -> Maybe String -> Maybe String -> Maybe Int -> Maybe Int -> Handler Book
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

