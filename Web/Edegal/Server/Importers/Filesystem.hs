module Web.Edegal.Server.Importers.Filesystem where

import qualified Data.Bytestring
import Data.Text (Text)

import Web.Edegal.Models.Album (Album)


importFile :: FilePath -> IO Picture
importFile filePath = undefined


importDirectory :: Path -> Text -> FilePath -> IO Album
importDirectory parent title dirPath = undefined