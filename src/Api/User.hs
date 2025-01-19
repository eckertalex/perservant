{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}

module Api.User
  ( UserApi,
    userServer,
  )
where

import Config (AppT)
import Control.Monad.IO.Class (MonadIO)
import Models.User (User (..), UserId (..))
import Servant

type GetUsersApi =
  Get '[JSON] [User]

type GetUserApi =
  Capture "id" UserId
    :> Get '[JSON] (Maybe User)

type UserApi =
  "api"
    :> "v1"
    :> "users"
    :> ( GetUsersApi
           :<|> GetUserApi
       )

userServer :: (MonadIO m) => ServerT UserApi (AppT m)
userServer = allUsers :<|> userById

allUsers :: (MonadIO m) => AppT m [User]
allUsers = return [User (UserId 1) "lex"]

userById :: (MonadIO m) => UserId -> AppT m (Maybe User)
userById (UserId 1) = return $ Just (User (UserId 1) "lex")
userById _ = return Nothing
