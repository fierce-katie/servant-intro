module Main where

import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as BL8
import Data.Proxy
import Servant.Swagger
import Test.Hspec

import API

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "Swagger spec for BooksAPI" $ do
    context "ToJSON matches ToSchema" $
      validateEveryToJSON (Proxy :: Proxy BooksAPI)
    it "swagger.json is up-to-date" $ do
      swag <- eitherDecode <$> BL8.readFile "swagger.json"
      swag `shouldBe` Right booksSwagger
