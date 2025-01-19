module App
  ( startApp,
  )
where

import Api (app)
import Config (Config (..))
import Network.Wai.Handler.Warp (run)
import Servant

startApp :: IO ()
startApp = do
  withConfig $ \config -> do
    cfg <- initialize config
    run (configPort config) cfg

-- let config = Config "development" 3000
-- putStrLn $ "Starting server on port " ++ show (port config) ++ " in " ++ show (env config) ++ " mode."
-- run (configPort config) config

initialize :: Config -> IO Application
initialize = pure . app

withConfig :: (Config -> IO a) -> IO a
withConfig action = do
  action
    Config
      { configPort = 3000
      }
