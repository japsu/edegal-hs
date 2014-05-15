{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Subalbum (Subalbum (..)) where

import GHC.Generics

import Data.Aeson

import Web.Edegal.Models.Path (Path)


data Subalbum = Subalbum
  { path :: Path
  , title :: String
  --, thumbnail :: Maybe Media
  } deriving (Show, Generic)


instance ToJSON Subalbum