module Server where

import API
import Book
import Servant
import Control.Monad.Trans.Either

type ServantResponse a = EitherT ServantErr IO a

server :: Server BooksAPI
server = listBooks :<|> addBook :<|> getBook :<|> deleteBook :<|> updateBook

listBooks :: ServantResponse [Book]
listBooks = undefined

addBook :: Book -> ServantResponse BookId
addBook = undefined

getBook :: BookId -> ServantResponse Book
getBook = undefined

deleteBook :: BookId -> ServantResponse ()
deleteBook = undefined

updateBook :: BookId -> Maybe String -> Maybe String -> Maybe Int -> Maybe Int -> ServantResponse Book
updateBook = undefined

