{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE StrictData #-}

module Config
  ( Config (..),
    AppT (..),
    App,
    Environment (..),
  )
where

import Control.Monad.Except (ExceptT, MonadError)
import Control.Monad.Reader (MonadIO, MonadReader, ReaderT)
import Network.Wai.Handler.Warp (Port)
import Servant (ServerError)

newtype AppT m a
  = AppT
  { runApp :: ReaderT Config (ExceptT ServerError m) a
  }
  deriving
    ( Functor,
      Applicative,
      Monad,
      MonadReader Config,
      MonadError ServerError,
      MonadIO
    )

type App = AppT IO

data Config
  = Config
  { configEnv :: Environment,
    configPort :: Port
  }

data Environment
  = Development
  | Test
  | Production
  deriving (Eq, Show, Read)
