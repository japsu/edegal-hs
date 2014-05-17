{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Media (Offset (..), MediaSpec (..), Media (..)) where

import GHC.Generics (Generic)

import Data.Aeson (ToJSON)


data Offset = Offset
  { top :: Int
  , left :: Int
  } deriving (Show, Generic, Eq)


data MediaSpec = MediaSpec
  { width :: Int
  , height :: Int
  , quality :: Int
  } deriving (Show, Generic, Eq, Ord)


data Media = Media
  { src :: String
  , spec :: MediaSpec
  , offset :: Maybe Offset
  , original :: Bool
  } deriving (Show, Generic, Eq)


instance ToJSON Offset
instance ToJSON MediaSpec
instance ToJSON Media
