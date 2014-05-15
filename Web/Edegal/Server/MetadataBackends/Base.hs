module Web.Edegal.Server.MetadataBackends.Base (MetadataBackend (..)) where

import Web.Edegal.Models.Album (Album)
import Web.Edegal.Models.Path (Path)


class MetadataBackend a where
  getAlbum :: a -> Path -> IO (Maybe Album)
  putAlbum :: a -> Album -> IO ()
