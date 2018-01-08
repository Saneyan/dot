
{-# LANGUAGE CPP #-}

module Gfxt.Bindings where

import XMonad
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS (nextWS, prevWS)
import XMonad.Util.Run
import XMonad.Util.Paste (pasteString)
import XMonad.StackSet
import Gfxt.Aliases
import Gfxt.Help (help)
import Gfxt.Email (email)
import Gfxt.Workspace

-- Prefix key --
#ifdef UNIX_US_LAYOUT
myModMask = mod4Mask
mySubModMask = mod1Mask
#else
myModMask = mod1Mask
mySubModMask = mod4Mask
#endif

myMSMask  = myModMask .|. shiftMask

(@+) ks (d, ws) =
  ks ++ [ ((m .|. d, k), windows $ f i)
  | (i, k) <- zip ws [xK_1 .. xK_9]
  , (f, m) <- [(greedyView, 0), (shift, shiftMask)] ]

-- Additional keys --
myAdditionalKeys =
  [ ((myModMask, xK_g)         , goToSelected def)
  , ((myModMask, xK_b)         , spawn myWebBrowser)
  , ((myModMask, xK_p)         , spawn myMenu)
  , ((myModMask, xK_backslash) , spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
  , ((myModMask, xK_F1)        , pasteString $ email "private")
  , ((myModMask, xK_F2)        , pasteString $ email "service")
  , ((myModMask, xK_F3)        , pasteString $ email "public")
  , ((myMSMask, xK_l)          , spawn myLock)
  , ((myMSMask, xK_Return)     , spawn myTerm) ]
  @+ (myModMask, masterWSGroup)
  @+ (mySubModMask, slaveWSGroup)
