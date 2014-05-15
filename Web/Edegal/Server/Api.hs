{-# LANGUAGE OverloadedStrings #-}

module Web.Edegal.Server.Api (api) where

import Control.Monad.Trans (liftIO)

import Data.Text (unpack)
import Web.Scotty (ScottyM, get, regex, param, json)

import Web.Edegal.Server.MetadataBackends.Base (MetadataBackend, getAlbum)


api :: MetadataBackend a => a -> ScottyM ()
api backend = do
  get (regex "^/api/v3(/[a-zA-Z0-9/-]*)$") $ do
    path <- param "1"
    maybeAlbum <- liftIO $ getAlbum backend $ unpack path
    json maybeAlbum