module Main where

import Data.Aeson (encode)
import qualified Data.ByteString.Lazy.Char8 as BS

import qualified Web.Edegal.Models.Album as A
import Web.Edegal.Server.MetadataBackends.Base (getAlbum, putAlbum)
import Web.Edegal.Server.MetadataBackends.TransactionalMemory (mkTransactionalMemoryMetadataBackend)


main = do
  backend <- mkTransactionalMemoryMetadataBackend
  putAlbum backend A.emptyRoot
  maybeAlbum <- getAlbum backend "/"
  BS.putStrLn $ encode maybeAlbum