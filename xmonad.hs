import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Layout.NoBorders   ( noBorders, smartBorders )
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , terminal   = "urxvt"
        , focusFollowsMouse = False
        , normalBorderColor = "#657b83"
        , focusedBorderColor = "#cb4b16"
        , layoutHook = avoidStruts (
                    smartBorders $ Tall 1 (3/100) (1/2) |||
                    noBorders Full |||
                    Mirror (Tall 1 (3/100) (1/2)))
        }

       `additionalKeys`
        [ ((mod1Mask, xK_Escape), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((mod1Mask, xK_d), kill)
        ]

