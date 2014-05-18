module Web.Edegal.Server.Importers.Filesystem where

import Data.Text (Text)

import Web.Edegal.Models.Album (Album)


importDirectory :: Path -> Text -> FilePath -> IO Album
importDirectory parent title dirPath = undefined