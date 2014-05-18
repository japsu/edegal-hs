{-# LANGUAGE DisambiguateRecordFields #-}

module Web.Edegal.Server.StorageBackends.LocalFilesystem (LocalFilesystemStorageBackend (..)) where

import qualified Data.ByteString as ByteString
import System.IO (FilePath, writeFile)

import Web.Edegal.Server.StorageBackends.Base (StorageBackend(..))
import qualified Web.Edegal.Models.Media as MediaSpec


data LocalFilesystemStorageBackend = LocalFilesystemStorageBackend {
  baseDir :: FilePath,
  baseURL :: String
}


instance StorageBackend LocalFilesystemStorageBackend where
  getMediaSrc backend path spec = baseDir backend ++ path ++ specSuffix ++ ".jpg" where
    specSuffix = if MediaSpec.original spec
      then ""
      else concat
              [ "/"
              , show $ MediaSpec.width spec
              , "x" 
              , show $ MediaSpec.height spec
              , "q"
              , show $ MediaSpec.quality spec
              ]
  
  mediaExists = undefined
  
  putFile backend path spec imageData = do
    let filePath = getMediaSrc backend path spec
    -- TODO mkdirp
    ByteString.writeFile filePath imageData
    return filePath