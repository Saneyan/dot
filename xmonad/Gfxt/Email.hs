module Gfxt.Email (email) where

email :: String -> String
email t | t == "private" = "saneyan@gfunction.com"
        | t == "service" = "saneyan@gfunction.com"
        | t == "public" = "saneyan@gfunction.com"
