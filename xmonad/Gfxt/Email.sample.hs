module Gfxt.Email (email) where

email :: String -> String
email t | t == "private" = "private@example.com"
        | t == "service" = "service@example.com"
        | t == "public" = "public@example.com"
