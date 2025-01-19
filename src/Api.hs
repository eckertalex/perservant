{-# LANGUAGE TypeOperators #-}

module Api
  ( app,
  )
where

import Api.Task (TaskApi, taskServer)
import Api.User (UserApi, userServer)
import Config (AppT (..), Config (..))
import Control.Monad.Reader (MonadIO, runReaderT)
import Servant

type AppApi = UserApi :<|> TaskApi

appApi :: Proxy AppApi
appApi = Proxy

appApiServer :: (MonadIO m) => ServerT AppApi (AppT m)
appApiServer = userServer :<|> taskServer

appToServer :: Config -> Server AppApi
appToServer cfg = hoistServer appApi (convertApp cfg) appApiServer

convertApp :: Config -> AppT IO a -> Handler a
convertApp cfg appt = Handler $ runReaderT (runApp appt) cfg

app :: Config -> Application
app cfg = serve appApi (appToServer cfg)
