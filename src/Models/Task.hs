{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Models.Task
  ( Task (..),
    TaskId (..),
  )
where

import Data.Aeson (FromJSON, ToJSON)
import Data.Text (Text)
import GHC.Generics (Generic)
import Models.User (UserId)
import Servant.API (FromHttpApiData)

newtype TaskId = TaskId Int
  deriving (Show, Eq, Ord, Generic, FromJSON, ToJSON, FromHttpApiData)

data Task = Task
  { id :: TaskId,
    userId :: UserId,
    title :: Text,
    completed :: Bool
  }
  deriving (Show, Generic)

instance ToJSON Task

instance FromJSON Task
