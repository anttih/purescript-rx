module Examples where

import Control.MonadPlus.Partial
import Control.Monad.Error.Class
import Control.Monad.Eff.Exception (message, error)
import Data.Tuple (Tuple(..))
import Data.Maybe
import Debug.Trace

import Rx.Notification
import Rx.Observable
import Rx.Observable.Aff
import Rx.Observable.Cont (liftCont)

main = do
  a <- return $ fromArray [1,2,3]
  b <- return $ fromArray [4,5,6]

  subscribe (a <> b) $ trace <<< show

  subscribe (combineLatest (+) a b) $ trace <<< show

  subscribe (zip (+) a b) (\n -> trace $ "zip: " ++ show n)

  subscribe (reduce (+) 0 (zip (+) a b)) $ trace <<< show

  subscribe (delay 1000 a) $ trace <<< show

  let s = pure "OnNext" <> throwError (error "OnError")
  subscribe' s trace (trace <<< message) (const $ print "OnCompleted")

  -- MonadError
  let err = throwError $ error "This is an error"
  subscribe (catchError err (pure <<< message)) trace
  subscribeOnError err (trace <<< message)

  -- Aff
  v <- liftAff $ pure "hello"
  runObservable $ trace <$> v

  affE <- liftAff $ throwError $ error "This is an Aff error"
  subscribe (catchError affE (pure <<< message)) trace
  
  -- ContT
  
  c <- liftCont $ pure (OnNext "hello from ContT")
  subscribe c trace

  contE <- liftCont $ pure (OnError (error "error from ContT"))
  subscribe (catchError contE (pure <<< message)) trace

  -- Plus
  (Tuple smaller bigger) <- return $ mpartition ((>) 5) (fromArray [2,3,4,5,6,8,9,10,100])

  trace "smaller:"
  subscribe smaller $ trace <<< show

  trace "bigger:"
  subscribe bigger $ trace <<< show

  subscribe (mcatMaybes $ fromArray [Just 1, Just 2, Nothing, Just 4]) $ trace <<< show
