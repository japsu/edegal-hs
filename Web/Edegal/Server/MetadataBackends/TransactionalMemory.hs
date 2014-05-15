module Web.Edegal.Server.MetadataBackends.TransactionalMemory where

import qualified Data.Map as Map
import Control.Concurrent.STM (atomically)
import Control.Concurrent.STM.TVar (TVar, newTVar, readTVar, modifyTVar')

import Web.Edegal.Models.Album as A
import Web.Edegal.Models.Path as Pa
import Web.Edegal.Server.MetadataBackends.Base


data TransactionalMemoryMetadataBackend = TransactionalMemoryMetadataBackend
  { albums :: TVar (Map.Map Pa.Path A.Album) }


instance MetadataBackend TransactionalMemoryMetadataBackend where
  putAlbum backend album = atomically $ modifyTVar' (albums backend) $ \currentAlbums ->
    Map.insert (path album) album currentAlbums

  getAlbum backend path = atomically $ do
    currentAlbums <- readTVar $ albums backend
    return $ Map.lookup path currentAlbums


mkTransactionalMemoryMetadataBackend :: IO TransactionalMemoryMetadataBackend
mkTransactionalMemoryMetadataBackend = atomically $ do
  emptyAlbums <- newTVar Map.empty
  return $ TransactionalMemoryMetadataBackend emptyAlbums
