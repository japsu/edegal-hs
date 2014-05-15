{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Picture (Picture (..)) where

import GHC.Generics

import Data.Aeson

import Web.Edegal.Models.Path (Path)


data Picture = Picture
  { path :: Path
  , title :: String
  --, media :: [Media]
  --, thumbnail :: Maybe Media
  --, tags :: [Tag]
  } deriving (Show, Generic)


instance ToJSON Picture