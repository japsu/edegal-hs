{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Album (Album (..), addChild, newChild, emptyRoot) where

import GHC.Generics (Generic)

import Data.Aeson (ToJSON)

import Web.Edegal.Models.Breadcrumb (Breadcrumb (Breadcrumb))
import Web.Edegal.Models.Path (Path, Slug)
import qualified Web.Edegal.Models.Path as Path
import Web.Edegal.Models.Picture (Picture)
import Web.Edegal.Models.Subalbum (Subalbum (Subalbum))


data Album = Album
  { path :: Path
  , title :: String
  , description :: String
  , breadcrumbs :: [Breadcrumb]
  , subalbums :: [Subalbum]
  , pictures :: [Picture]
  --, thumbnail :: Maybe Media
  } deriving (Show, Generic)


instance ToJSON Album


mkBreadcrumb :: Album -> Breadcrumb
mkBreadcrumb album = Breadcrumb (path album) (title album)


mkSubalbum :: Album -> Subalbum
mkSubalbum album = Subalbum (path album) (title album)


addChild :: Album -> Album -> (Album, Album)
addChild parent child = (parent', child') where
  parent' = parent { subalbums   = mkSubalbum child : subalbums parent }
  child'  = child  { breadcrumbs = mkBreadcrumb parent : breadcrumbs parent }


newChild :: Album -> Slug -> (Album, Album)
newChild parent childSlug = addChild parent child where
  child = Album
    { path = Path.append (path parent) childSlug
    , title = ""
    , description = ""
    , subalbums = []
    , breadcrumbs = []
    , pictures = []
    }


emptyRoot :: Album
emptyRoot = Album "/" "Empty Gallery" "An empty photo gallery" [] [] []