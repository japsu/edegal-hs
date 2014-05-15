{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Breadcrumb where

import GHC.Generics

import Data.Aeson

import qualified Web.Edegal.Models.Path as P

data Breadcrumb = Breadcrumb
  { path :: P.Path
  , title :: String
  } deriving (Show, Generic)

instance ToJSON Breadcrumb