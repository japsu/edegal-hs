module Web.Edegal.Server.StorageBackends.Base where

import Data.ByteString (ByteString)

import Web.Edegal.Models.Media (Media, MediaSpec)
import Web.Edegal.Models.Path (Path)
import Web.Edegal.Models.Picture (Picture)


class StorageBackend a where
  getMediaSrc :: a -> Path -> MediaSpec -> String
  mediaExists :: a -> Media -> IO Bool
  putFile     :: a -> Path -> MediaSpec -> ByteString -> IO Media