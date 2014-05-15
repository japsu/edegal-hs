module Web.Edegal.Server.MetadataBackends.TransactionalMemory (TransactionalMemoryMetadataBackend, mkTransactionalMemoryMetadataBackend) where

import Data.Map (Map)
import qualified Data.Map as Map
import Control.Concurrent.STM (atomically)
import Control.Concurrent.STM.TVar (TVar, newTVar, readTVar, modifyTVar')

import Web.Edegal.Models.Album (Album)
import qualified Web.Edegal.Models.Album as Album
import Web.Edegal.Models.Path (Path)
import Web.Edegal.Server.MetadataBackends.Base


data TransactionalMemoryMetadataBackend = TransactionalMemoryMetadataBackend
  { albums :: TVar (Map Path Album) }


instance MetadataBackend TransactionalMemoryMetadataBackend where
  putAlbum backend album = atomically $ modifyTVar' (albums backend) $ \currentAlbums ->
    Map.insert (Album.path album) album currentAlbums

  getAlbum backend path = atomically $ do
    currentAlbums <- readTVar $ albums backend
    return $ Map.lookup path currentAlbums


mkTransactionalMemoryMetadataBackend :: IO TransactionalMemoryMetadataBackend
mkTransactionalMemoryMetadataBackend = atomically $ do
  emptyAlbums <- newTVar Map.empty
  return $ TransactionalMemoryMetadataBackend emptyAlbums
