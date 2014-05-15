module Main where

import qualified Web.Edegal.Models.Album as A
import Web.Edegal.Server.MetadataBackends.Base
import Web.Edegal.Server.MetadataBackends.InMemory

main = do
  backend <- mkInMemoryMetadataBackend
  putAlbum backend A.emptyRoot
  maybeAlbum <- getAlbum backend "/"
  print maybeAlbum