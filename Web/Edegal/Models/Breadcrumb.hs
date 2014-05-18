{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Breadcrumb (Breadcrumb (..)) where

import Data.Text (Text)
import GHC.Generics (Generic)

import Data.Aeson (ToJSON)

import Web.Edegal.Models.Path (Path)


data Breadcrumb = Breadcrumb
  { path :: Path
  , title :: Text
  } deriving (Show, Generic)


instance ToJSON Breadcrumb