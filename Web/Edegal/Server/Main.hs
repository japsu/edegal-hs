{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.Trans (liftIO)

import Data.Text (unpack)
import Data.Aeson (encode)
import Web.Scotty (scotty, get, regex, param, json)

import qualified Web.Edegal.Models.Album as Album
import Web.Edegal.Server.MetadataBackends.Base (getAlbum, putAlbum)
import Web.Edegal.Server.MetadataBackends.TransactionalMemory (mkTransactionalMemoryMetadataBackend)


main = do
  backend <- mkTransactionalMemoryMetadataBackend

  -- XXX
  putAlbum backend Album.emptyRoot

  scotty 3000 $ do
    get (regex "^/v2(/[a-zA-Z0-9/-]*)$") $ do
      path <- param "1"
      maybeAlbum <- liftIO $ getAlbum backend $ unpack path
      json maybeAlbum