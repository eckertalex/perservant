module App
  ( startApp,
  )
where

import Api (app)
import Config (Config (..), Environment (Development))
import Network.Wai.Handler.Warp (run)
import Servant
import System.Environment (lookupEnv)

startApp :: IO ()
startApp = do
  config <- loadConfig
  putStrLn $ "Starting server on port " ++ show (configPort config) ++ " in " ++ show (configEnv config) ++ " mode."
  appWithConfig <- createApp config
  run (configPort config) appWithConfig

createApp :: Config -> IO Application
createApp = pure . app

loadConfig :: IO Config
loadConfig = do
  port <- lookupSetting "PORT" 45067
  env <- lookupSetting "ENV" Development
  pure
    Config
      { configEnv = env,
        configPort = port
      }

lookupSetting :: (Read a) => String -> a -> IO a
lookupSetting env def = do
  maybeValue <- lookupEnv env
  case maybeValue of
    Nothing ->
      return def
    Just str ->
      maybe (handleFailedRead str) return (readMaybe str)
  where
    handleFailedRead str =
      error $
        mconcat
          [ "Failed to read [[",
            str,
            "]] for environment variable ",
            env
          ]
    readMaybe :: (Read a) => String -> Maybe a
    readMaybe s = case reads s of
      [(x, "")] -> Just x
      _ -> Nothing
