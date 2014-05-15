module Main where

import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as BS

import qualified Web.Edegal.Models.Album as A
import Web.Edegal.Server.MetadataBackends.Base
import Web.Edegal.Server.MetadataBackends.TransactionalMemory

main = do
  backend <- mkTransactionalMemoryMetadataBackend
  putAlbum backend A.emptyRoot
  maybeAlbum <- getAlbum backend "/"
  BS.putStrLn $ encode maybeAlbum