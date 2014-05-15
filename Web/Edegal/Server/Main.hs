{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.Trans (liftIO)

import Data.Text (unpack)
import Web.Scotty (scotty, get, regex, param, json)

import qualified Web.Edegal.Models.Album as Album
import Web.Edegal.Server.MetadataBackends.Base (getAlbum, putAlbum)
import Web.Edegal.Server.MetadataBackends.TransactionalMemory (mkTransactionalMemoryMetadataBackend)


setupTestData backend = do
  -- XXX
  let (root, child) = Album.newChild Album.emptyRoot "foo"
  putAlbum backend root
  putAlbum backend child
  return ()


main = do
  backend <- mkTransactionalMemoryMetadataBackend

  -- XXX
  setupTestData backend

  scotty 3000 $ do
    get (regex "^/api/v3(/[a-zA-Z0-9/-]*)$") $ do
      path <- param "1"
      maybeAlbum <- liftIO $ getAlbum backend $ unpack path
      json maybeAlbum