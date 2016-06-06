module Rx.Notification where

import Prelude
import Control.Monad.Eff.Exception (Error(), message)

data Notification a = OnError Error | OnNext a | OnCompleted

instance showNotification :: (Show a) => Show (Notification a) where
  show (OnNext v) = "(OnNext " <> show v <> ")"
  show (OnError err) = "(OnError " <> message err <> ")"
  show (OnCompleted) = "(OnCompleted)"
