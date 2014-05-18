{-# LANGUAGE DisambiguateRecordFields, OverloadedStrings #-}

module Web.Edegal.Server.StorageBackends.LocalFilesystem (LocalFilesystemStorageBackend (..)) where

import qualified Data.ByteString as ByteString
import qualified Data.Text as T
import qualified System.Directory as Dir
import System.IO (FilePath, writeFile)

import Web.Edegal.Server.StorageBackends.Base (StorageBackend(..))
import Web.Edegal.Models.Media (MediaSpec)
import qualified Web.Edegal.Models.Media as MediaSpec
import Web.Edegal.Models.Path (Path)


data LocalFilesystemStorageBackend = LocalFilesystemStorageBackend {
  baseDir :: FilePath,
  baseURL :: String
}


getFilePath :: LocalFilesystemStorageBackend -> Path -> MediaSpec -> FilePath
getFilePath backend path spec = baseDir backend ++ path ++ specSuffix spec ++ ".jpg"


specSuffix :: MediaSpec -> String
specSuffix spec =
  if MediaSpec.original spec
    then ""
    else concat
          [ "/"
          , show $ MediaSpec.width spec
          , "x" 
          , show $ MediaSpec.height spec
          , "q"
          , show $ MediaSpec.quality spec
          ]


limitedBasename :: FilePath -> FilePath
limitedBasename = T.unpack . (T.intercalate "/") . init . (T.splitOn "/") . T.pack


instance StorageBackend LocalFilesystemStorageBackend where
  getMediaSrc backend path spec = baseURL backend ++ path ++ specSuffix spec ++ ".jpg"
  
  doesFileExist backend path spec = Dir.doesFileExist $ getFilePath backend path spec
  
  putFile backend path spec imageData = do
    let filePath = getFilePath backend path spec
        dirPath  = limitedBasename filePath

    Dir.createDirectoryIfMissing True dirPath
    ByteString.writeFile filePath imageData
    return filePath