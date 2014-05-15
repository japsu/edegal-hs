{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Subalbum where

import GHC.Generics

import Data.Aeson

import qualified Web.Edegal.Models.Path as P

data Subalbum = Subalbum
  { path :: P.Path
  , title :: String
  --, thumbnail :: Maybe Media
  } deriving (Show, Generic)

instance ToJSON Subalbum