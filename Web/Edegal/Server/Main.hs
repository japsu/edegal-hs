module Main where

import Web.Scotty (scotty)

import qualified Web.Edegal.Models.Album as Album
import Web.Edegal.Server.Api (api)
import Web.Edegal.Server.MetadataBackends.Base (putAlbum)
import Web.Edegal.Server.MetadataBackends.TransactionalMemory (mkTransactionalMemoryMetadataBackend)


setupTestData backend = do
  -- XXX
  let (root, child) = Album.newChild Album.emptyRoot "foo"
  putAlbum backend root
  putAlbum backend child
  return ()


main = do
  backend <- mkTransactionalMemoryMetadataBackend

  -- XXX
  setupTestData backend

  scotty 3000 $ api backend