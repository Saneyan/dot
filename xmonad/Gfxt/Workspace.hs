module Gfxt.Workspace where

import XMonad

-- It should be like "ABC > DEF > GHI > ..."
appendIcon :: [WorkspaceId] -> [WorkspaceId]
appendIcon ws = map (++ " ") (map (" " ++) ws)
  
masterWSGroup :: [WorkspaceId]
masterWSGroup = appendIcon ["term", "browser", "mailer", "psmgr", "idea", "paint", "player", "strage", "office"]

slaveWSGroup :: [WorkspaceId]
slaveWSGroup = appendIcon ["slack"]

myWorkspaces :: [WorkspaceId]
myWorkspaces = masterWSGroup ++ slaveWSGroup
