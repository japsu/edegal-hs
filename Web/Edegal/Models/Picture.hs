{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Picture (Picture (..), getOriginalMedia, mkTitle) where

import Data.Text (Text)
import Data.List (find)
import GHC.Generics (Generic)

import Data.Aeson (ToJSON)

import Web.Edegal.Models.Path (Path)
import Web.Edegal.Models.Media (Media)
import qualified Web.Edegal.Models.Media as Media
import qualified Web.Edegal.Models.Media as MediaSpec


data Picture = Picture
  { path :: Path
  , title :: Text
  , media :: [Media]
  --, thumbnail :: Maybe Media
  --, tags :: [Tag]
  } deriving (Show, Generic)


instance ToJSON Picture


getOriginalMedia :: Picture -> Maybe Media
getOriginalMedia = find (MediaSpec.original . Media.spec) . media


mkTitle :: String -> Text
mkTitle originalFileName = undefined