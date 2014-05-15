{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Picture where

import GHC.Generics

import Data.Aeson

import qualified Web.Edegal.Models.Path as P


data Picture = Picture
  { path :: P.Path
  , title :: String
  --, media :: [Media]
  --, thumbnail :: Maybe Media
  --, tags :: [Tag]
  } deriving (Show, Generic)


instance ToJSON Picture