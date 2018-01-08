module Gfxt.Hooks where

import XMonad
import XMonad.Config
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.DragPane
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Actions.SpawnOn (spawnOn, manageSpawn)
import XMonad.Util.Run
import Gfxt.Workspace
import Gfxt.Aliases

-- Layout hook --
myLayoutHook = avoidStruts $ myLayout

myLayout = (spacing 16 $ ResizableTall 1 (3/100) (3/5) [])
  ||| (spacing 2 $ (dragPane Horizontal (1/10) (1/2)))
  ||| (dragPane Vertical    (1/10) (1/2))

-- Manage hook --
myManageHook = composeAll
  [ className =? "XTerm"          --> doShift (myWorkspaces!!0)
  , className =? "URxvt"          --> doCenterFloat
  , className =? "Firefox"        --> doShift (myWorkspaces!!1)
  , className =? "Chromium"       --> doShift (myWorkspaces!!1)
  , title =? "Google Chrome" --> doShift (myWorkspaces!!1)
  , className =? "Thunderbird"    --> doShift (myWorkspaces!!2)
  , className =? "Keepassx"       --> doShift (myWorkspaces!!3)
  , className =? "IntelliJ"       --> doShift (myWorkspaces!!4)
  , className =? "Inkscape"       --> doShift (myWorkspaces!!5)
  , className =? "Gimp"           --> doShift (myWorkspaces!!5)
  , className =? "Vlc"            --> doShift (myWorkspaces!!6)
  , title     =? "Excel Online"   --> doShift (myWorkspaces!!8)
  , title     =? "Word Online"    --> doShift (myWorkspaces!!8)
  , title     =? "PowerPoint Online" --> doShift (myWorkspaces!!8)
  , title     =? "Onenote Online" --> doShift (myWorkspaces!!8)
  , className =? "Slack"          --> doShift (myWorkspaces!!9)
  , manageSpawn
  , manageDocks
  , manageHook def ]

colorBlue      = "#857da9"
colorGreen     = "#34A853"
colorGray      = "#676767"
colorWhite     = "#d3d7cf"
colorGrayAlt   = "#313131"
colorNormalbg  = "#1a1e1b"

  -- Log hook --
myLogHook h = logHook def <+> dynamicLogWithPP xmobarPP
  { ppOutput          = hPutStrLn h
  , ppCurrent         = xmobarColor colorGreen colorNormalbg
  , ppUrgent          = xmobarColor colorWhite colorNormalbg
  , ppVisible         = xmobarColor colorWhite colorNormalbg
  , ppHidden          = xmobarColor colorWhite colorNormalbg
  , ppHiddenNoWindows = xmobarColor colorGray colorNormalbg
  , ppOrder           = \(ws:l:t:_) -> [ws,t]
  , ppWsSep           = ""
  , ppSep             = " : "
  , ppTitle           = xmobarColor colorGreen "" . shorten 30 }

-- Startup hook --
myStartupHook :: X ()
myStartupHook = do
  setWMName "LG3D"
  spawnOn (myWorkspaces!!0) myTerm
  spawnOn (myWorkspaces!!1) myWebBrowser
  spawnOn (myWorkspaces!!2) myMailer
  spawnOn (myWorkspaces!!9) mySlack
