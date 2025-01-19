{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Models.User
  ( User (..),
    UserId (..),
  )
where

import Data.Aeson (FromJSON, ToJSON)
import Data.Text (Text)
import GHC.Generics (Generic)
import Servant.API (FromHttpApiData)

newtype UserId = UserId Int
  deriving (Show, Eq, Ord, Generic, FromJSON, ToJSON, FromHttpApiData)

data User = User
  { id :: UserId,
    name :: Text
  }
  deriving (Show, Generic)

instance ToJSON User

instance FromJSON User
