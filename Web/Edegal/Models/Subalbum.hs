{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Subalbum (Subalbum (..)) where

import GHC.Generics (Generic)

import Data.Aeson (ToJSON)

import Web.Edegal.Models.Path (Path)


data Subalbum = Subalbum
  { path :: Path
  , title :: String
  --, thumbnail :: Maybe Media
  } deriving (Show, Generic)


instance ToJSON Subalbum