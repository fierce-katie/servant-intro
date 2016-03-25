{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module API where

import Book
import Servant.API

type BooksAPI
     = Get '[JSON] [Book]
  :<|> ReqBody '[JSON] Book      :> Post '[JSON] BookId
  :<|> Capture "book_id" BookId  :> Get '[JSON] Book
  :<|> Capture "book_id" BookId  :> Delete '[JSON] ()
  :<|> Capture "book_id" BookId  :> QueryParam "author" String :>
       QueryParam "title" String :> QueryParam "year" Int      :>
       QueryParam "in_stock" Int :> Post '[JSON] Book

