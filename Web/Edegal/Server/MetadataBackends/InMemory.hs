module Web.Edegal.Server.MetadataBackends.InMemory where

import qualified Data.Map as Map
import Data.IORef (IORef, newIORef, readIORef)

import Web.Edegal.Models.Album as A
import Web.Edegal.Models.Path as Pa
import Web.Edegal.Server.MetadataBackends.Base


data InMemoryMetadataBackend = InMemoryMetadataBackend
  { albums :: IORef (Map.Map Pa.Path A.Album) }


instance MetadataBackend InMemoryMetadataBackend where
  getAlbum backend path = do
    currentAlbums <- readIORef $ albums backend
    return $ Map.lookup path currentAlbums


mkInMemoryMetadataBackend :: IO InMemoryMetadataBackend
mkInMemoryMetadataBackend = do
  emptyAlbums <- newIORef Map.empty
  return $ InMemoryMetadataBackend emptyAlbums
