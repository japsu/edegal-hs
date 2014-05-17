module Web.Edegal.Server.StorageBackends.LocalFilesystem (LocalFilesystemStorageBackend (..)) where

import Web.Edegal.Server.StorageBackends.Base (StorageBackend(..))


data LocalFilesystemStorageBackend = LocalFilesystemStorageBackend {
  baseDir :: String,
  baseURL :: String
}


instance StorageBackend LocalFilesystemStorageBackend where
  getMediaSrc = undefined
  mediaExists = undefined
  putFile     = undefined