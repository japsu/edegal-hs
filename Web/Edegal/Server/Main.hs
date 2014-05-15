module Main where

import Web.Edegal.Server.MetadataBackends.Base
import Web.Edegal.Server.MetadataBackends.InMemory

main = do
  backend <- mkInMemoryMetadataBackend
  maybeAlbum <- getAlbum backend "/"
  print maybeAlbum