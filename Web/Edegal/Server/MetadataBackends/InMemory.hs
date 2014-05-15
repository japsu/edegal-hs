module Web.Edegal.Server.MetadataBackends.InMemory (InMemoryMetadataBackend, mkInMemoryMetadataBackend) where

import Data.Map (Map)
import qualified Data.Map as Map
import Data.IORef (IORef, newIORef, readIORef, modifyIORef)

import Web.Edegal.Models.Album (Album)
import qualified Web.Edegal.Models.Album as Album
import Web.Edegal.Models.Path (Path)
import Web.Edegal.Server.MetadataBackends.Base


data InMemoryMetadataBackend = InMemoryMetadataBackend
  { albums :: IORef (Map Path Album) }


instance MetadataBackend InMemoryMetadataBackend where
  putAlbum backend album = modifyIORef (albums backend) $ \currentAlbums ->
    Map.insert (Album.path album) album currentAlbums

  getAlbum backend path = do
    currentAlbums <- readIORef $ albums backend
    return $ Map.lookup path currentAlbums


mkInMemoryMetadataBackend :: IO InMemoryMetadataBackend
mkInMemoryMetadataBackend = do
  emptyAlbums <- newIORef Map.empty
  return $ InMemoryMetadataBackend emptyAlbums
