{-# LANGUAGE DisambiguateRecordFields #-}

module Main where

import Web.Scotty (scotty)

import qualified Web.Edegal.Models.Album as Album
import Web.Edegal.Server.Api (api)
import Web.Edegal.Server.MetadataBackends.Base (putAlbum)
import Web.Edegal.Server.MetadataBackends.TransactionalMemory (mkTransactionalMemoryMetadataBackend)
import Web.Edegal.Server.StorageBackends.LocalFilesystem (LocalFilesystemStorageBackend (LocalFilesystemStorageBackend))
import qualified Web.Edegal.Server.StorageBackends.LocalFilesystem as LocalFilesystemStorageBackend
import Web.Edegal.Server.MediaManager (importPicture)


setupTestData metadataBackend = do
  -- XXX
  let (root, child) = Album.newChild Album.emptyRoot "foo"
  putAlbum metadataBackend root
  putAlbum metadataBackend child
  return ()


main = do
  metadataBackend <- mkTransactionalMemoryMetadataBackend
  let storageBackend = LocalFilesystemStorageBackend {
    baseDir = "./public/pictures",
    baseURL = "/pictures"
  }

  -- XXX
  setupTestData metadataBackend

  scotty 3000 $ api metadataBackend