module Main where

import Network.Wai (Application)
import Network.Wai.Handler.Warp (run)
import Data.Proxy
import Servant
import Servant.Server
import Servant.Swagger.UI

import Server
import API

main :: IO ()
main = run 8800 app

app :: Application
app = serve (Proxy :: Proxy API) server
  where
    server = pure booksSwagger :<|> swaggerSchemaUIServer booksSwagger :<|> serveBooks

