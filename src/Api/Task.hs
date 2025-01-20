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
  "v1"
    :> "tasks"
    :> ( GetTasksApi
           :<|> GetTaskApi
       )

taskServer :: (MonadIO m) => ServerT TaskApi (AppT m)
taskServer = allTasks :<|> taskById

allTasks :: (MonadIO m) => (AppT m) [Task]
allTasks = return [Task (TaskId 1) (UserId 1) "Write documentation" False, Task (TaskId 2) (UserId 1) "Refactor codebase" True]

taskById :: (MonadIO m) => TaskId -> (AppT m) (Maybe Task)
taskById (TaskId 1) = return $ Just (Task (TaskId 1) (UserId 1) "Write documentation" True)
taskById (TaskId 2) = return $ Just (Task (TaskId 2) (UserId 1) "Refactor codebase" True)
taskById _ = return Nothing
