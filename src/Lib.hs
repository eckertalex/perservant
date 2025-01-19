{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Lib (exec) where

import qualified Network.Wai.Handler.Warp as W
import Servant

type FullApi = "hello" :> Get '[JSON] String

fullApi :: Proxy FullApi
fullApi = Proxy

server :: Server FullApi
server = return "Hello, world!"

app :: Application
app = serve fullApi server

exec :: IO ()
exec = do
  putStrLn "Starting server on :3000"
  W.run 3000 app
