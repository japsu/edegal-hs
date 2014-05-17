module Web.Edegal.Server.StorageBackends.Base where

import Web.Edegal.Models.Media (Media, MediaSpec)
import Web.Edegal.Models.Picture (Picture)


class StorageBackend a where
  getMediaSrc :: a -> Picture -> MediaSpec -> String
  mediaExists :: a -> Media -> IO Bool