{-# LANGUAGE DeriveGeneric #-}

module Web.Edegal.Models.Album where

import GHC.Generics

import Data.Aeson

import qualified Web.Edegal.Models.Breadcrumb as BC
import qualified Web.Edegal.Models.Path as Pa
import qualified Web.Edegal.Models.Picture as Pi
import qualified Web.Edegal.Models.Subalbum as SA


data Album = Album
  { path :: Pa.Path
  , title :: String
  , description :: String
  , breadcrumbs :: [BC.Breadcrumb]
  , subalbums :: [SA.Subalbum]
  , pictures :: [Pi.Picture]
  --, thumbnail :: Maybe Media
  } deriving (Show, Generic)


instance ToJSON Album


mkBreadcrumb :: Album -> BC.Breadcrumb
mkBreadcrumb album = BC.Breadcrumb (path album) (title album)


mkSubalbum :: Album -> SA.Subalbum
mkSubalbum album = SA.Subalbum (path album) (title album)


addChild :: Album -> Album -> (Album, Album)
addChild parent child = (parent', child') where
  parent' = parent { subalbums   = mkSubalbum child : subalbums parent }
  child'  = child  { breadcrumbs = mkBreadcrumb parent : breadcrumbs parent }


newChild :: Album -> Pa.Slug -> (Album, Album)
newChild parent childSlug = addChild parent child where
  child = Album
    { path = Pa.append (path parent) childSlug
    , title = ""
    , description = ""
    , subalbums = []
    , breadcrumbs = []
    , pictures = []
    }


emptyRoot :: Album
emptyRoot = Album "/" "Empty Gallery" "An empty photo gallery" [] [] []