module Rx.Notification where

import Control.Monad.Eff.Exception (Error())

data Notification a = OnError Error | OnNext a | OnCompleted
