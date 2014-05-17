 module Web.Edegal.Server.MediaManager where

import Control.Monad (mapM)
import Data.Function (on)
import Data.List (nub, sortBy, (\\))
import Data.Ord (compare)

import Web.Edegal.Models.Media (Media (Media), MediaSpec (MediaSpec))
import qualified Web.Edegal.Models.Media as Media
import qualified Web.Edegal.Models.Media as MediaSpec
import Web.Edegal.Models.Picture (Picture (Picture))
import qualified Web.Edegal.Models.Picture as Picture
import Web.Edegal.Server.StorageBackends.Base (StorageBackend)
import qualified Web.Edegal.Server.StorageBackends.Base as StorageBackend


createMedia :: StorageBackend a => a -> Picture -> MediaSpec -> IO Media
createMedia backend picture spec = do
  let newSrc = StorageBackend.getMediaSrc backend picture spec

  original <- case Picture.getOriginalMedia picture of
    Just original -> return original
    Nothing       -> fail "original media missing"

  return original
    { Media.src = newSrc
    , Media.spec = spec
    , Media.offset = Nothing
    , Media.original = False
    }


importPicture :: StorageBackend a => a -> [MediaSpec] -> Picture -> IO Picture
importPicture backend requiredSpecs picture = do
  let currentMedia = Picture.media picture
      currentSpecs = map Media.spec currentMedia
      missingSpecs = requiredSpecs \\ missingSpecs

  newMedia <- mapM (createMedia backend picture) missingSpecs

  let updatedMedia = nub $ sortBy (compare `on` Media.spec) $ currentMedia ++ newMedia

  return picture { Picture.media = updatedMedia }