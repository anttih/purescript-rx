## Module Rx.Notification

#### `Notification`

``` purescript
data Notification a
  = OnError Error
  | OnNext a
  | OnCompleted
```

##### Instances
``` purescript
instance showNotification :: (Show a) => Show (Notification a)
```


