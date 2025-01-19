{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}

module Api.Task
  ( TaskApi,
    taskServer,
  )
where

import Config (AppT)
import Control.Monad.IO.Class (MonadIO)
import Models.Task (Task (..), TaskId (..))
import Models.User (UserId (..))
import Servant

type GetTasksApi =
  Get '[JSON] [Task]

type GetTaskApi =
  Capture "task_id" TaskId
    :> Get '[JSON] (Maybe Task)

type TaskApi =
  "api"
    :> "v1"
    :> "tasks"
    :> ( GetTasksApi
           :<|> GetTaskApi
       )

taskServer :: (MonadIO m) => ServerT TaskApi (AppT m)
taskServer = tasksGet :<|> taskGet

tasksGet :: (MonadIO m) => (AppT m) [Task]
tasksGet = return [Task (TaskId 1) (UserId 1) "Write documentation" False, Task (TaskId 2) (UserId 1) "Refactor codebase" True]

taskGet :: (MonadIO m) => TaskId -> (AppT m) (Maybe Task)
taskGet (TaskId 1) = return $ Just (Task (TaskId 1) (UserId 1) "Write documentation" True)
taskGet (TaskId 2) = return $ Just (Task (TaskId 2) (UserId 1) "Refactor codebase" True)
taskGet _ = return Nothing
