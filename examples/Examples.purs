module Examples where

import Prelude
import Control.Monad.Error.Class (catchError, throwError)
import Control.Monad.Eff.Exception (message, error)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow)

import Rx.Notification (Notification(OnError, OnNext))
import Rx.Observable (fromArray, subscribe, runObservable, subscribeOnError,
                     materialize, dematerialize, subscribe', delay, zip,
                     reduce, combineLatest)
import Rx.Observable.Aff (liftAff)
import Rx.Observable.Cont (liftCont)

main :: Eff (console :: CONSOLE) Unit
main = do
  a <- pure $ fromArray [1,2,3]
  b <- pure $ fromArray [4,5,6]

  subscribe (a <> b) $ logShow

  subscribe (combineLatest (+) a b) $ logShow

  subscribe (zip (+) a b) (\n -> logShow $ "zip: " <> show n)

  subscribe (reduce (+) 0 (zip (+) a b)) $ logShow

  subscribe (delay 1000 a) $ logShow

  let s = pure "OnNext" <> throwError (error "OnError")
  subscribe' s logShow (logShow <<< message) (const $ logShow "OnCompleted")

  let s' = pure (OnNext "OK") <> (pure $ OnError $ error "An error")
  subscribe' (dematerialize $ s') logShow (logShow <<< message) (const $ logShow "OnCompleted")

  subscribe (materialize $ pure "materialized" <> throwError (error "err")) logShow

  -- MonadError
  let err = throwError $ error "This is an error"
  subscribe (catchError err (pure <<< message)) logShow
  subscribeOnError err (logShow <<< message)

  -- Aff
  v <- liftAff $ pure "hello"
  runObservable $ logShow <$> v

  affE <- liftAff $ throwError $ error "This is an Aff error"
  subscribe (catchError affE (pure <<< message)) logShow
  
  -- ContT
  
  c <- liftCont $ pure (OnNext "hello from ContT")
  subscribe c logShow

  contE <- liftCont $ pure (OnError (error "error from ContT"))
  subscribe (catchError contE (pure <<< message)) logShow
