import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , terminal   = "urxvt"
        , focusFollowsMouse = False
        , normalBorderColor = "#657b83"
        , focusedBorderColor = "#cb4b16"
        } `additionalKeys`
        [ ((mod1Mask, xK_Escape), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod1Mask, xK_d), kill)
        ]

