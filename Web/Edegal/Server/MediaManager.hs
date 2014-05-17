{-# LANGUAGE DisambiguateRecordFields #-}

 module Web.Edegal.Server.MediaManager (importPicture, createMedia) where

import Control.Monad (mapM)
import Data.ByteString (ByteString)
import Data.Function (on)
import Data.List (nub, sortBy, (\\))

import Data.Ord (compare)

import Graphics.GD (Image, loadJpegByteString, resizeImage, saveJpegByteString, imageSize)

import Web.Edegal.Models.Album (Album)
import qualified Web.Edegal.Models.Album as Album
import Web.Edegal.Models.Media (Media (Media), MediaSpec (MediaSpec))
import qualified Web.Edegal.Models.Media as Media
import qualified Web.Edegal.Models.Media as MediaSpec
import qualified Web.Edegal.Models.Path as Path
import Web.Edegal.Models.Picture (Picture (Picture))
import qualified Web.Edegal.Models.Picture as Picture
import Web.Edegal.Server.StorageBackends.Base (StorageBackend)
import qualified Web.Edegal.Server.StorageBackends.Base as StorageBackend


createMedia :: StorageBackend a => a -> String -> Image -> MediaSpec -> IO Media
createMedia backend path originalImage spec = do
  let newSrc = StorageBackend.getMediaSrc backend path spec

  scaledImage <- resizeImage (MediaSpec.width spec) (MediaSpec.height spec) originalImage
  scaledImageData <- saveJpegByteString (MediaSpec.quality spec) scaledImage

  StorageBackend.putFile backend path spec scaledImageData


importPicture :: StorageBackend a => a -> [MediaSpec] -> Album -> String -> ByteString -> IO Picture
importPicture backend requiredSpecs album originalFileName imageData = do
  let path = Path.append (Album.path album) (Path.mkSlug originalFileName)

  image <- loadJpegByteString imageData
  (originalWidth, originalHeight) <- imageSize image

  let originalSpec = MediaSpec {
    width = originalWidth
    , height = originalHeight
    , quality = 100
    , original = True
    }

  original <- StorageBackend.putFile backend path originalSpec imageData
  newMedia <- mapM (createMedia backend path image) requiredSpecs

  return Picture
    { path = path
    , title = Picture.mkTitle originalFileName
    , media = original : newMedia
    }