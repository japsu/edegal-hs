module Web.Edegal.Server.MetadataBackends.Base where

import qualified Web.Edegal.Models.Album as A
import qualified Web.Edegal.Models.Path as Pa


class MetadataBackend a where
  getAlbum :: a -> Pa.Path -> IO (Maybe A.Album)