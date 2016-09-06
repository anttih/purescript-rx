module Rx.Notification where

import Prelude
import Control.Monad.Eff.Exception (Error(), message)

data Notification a = Error Error | Next a | Complete

instance showNotification :: (Show a) => Show (Notification a) where
  show (Next v) = "(Next " <> show v <> ")"
  show (Error err) = "(Error " <> message err <> ")"
  show (Complete) = "(Complete)"
