import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout
import XMonad.Layout.NoBorders   ( noBorders, smartBorders )
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do


    spawn $ "conky | " ++ "dzen2 -w 650 -ta l -e '' -h '12'"
    d <- spawnPipe "dzen2 -w 716 -x 650 -h '12' -fn 'Inconsolata-8' -p -ta r -e ''"

    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
        { 
	  manageHook = manageDocks <+> manageHook defaultConfig
        , terminal   = "urxvtc"
        , focusFollowsMouse = False
        , normalBorderColor = "#657b83"
        , focusedBorderColor = "#cb4b16"
	, logHook = myLogHook d
        , layoutHook = avoidStruts (
                    smartBorders $ Tall 1 (3/100) (1/2) |||
                    noBorders Full |||
                    Mirror (Tall 1 (3/100) (1/2)))
        }

       `additionalKeys`
        [ ((mod1Mask, xK_Escape), spawn "xscreensaver-command -lock")
        , ((0, xK_Print), spawn "scrot")
        , ((mod1Mask, xK_d), kill)
        , ((mod1Mask, xK_u), sendMessage (IncMasterN 1))
        , ((mod1Mask, xK_i), sendMessage (IncMasterN (-1)))    
        ]
myLogHook h = dynamicLogWithPP $ defaultPP

    -- display current workspace as darkgrey on light grey (opposite of 
    -- default colors)
    { ppCurrent         = dzenColor "#303030" "#909090" . pad 

    -- display other workspaces which contain windows as a brighter grey
    , ppHidden          = dzenColor "#909090" "" . pad 

    -- display other workspaces with no windows as a normal grey
    , ppHiddenNoWindows = const "" 

    -- display the current layout as a brighter grey
    , ppLayout          = const ""

    -- if a window on a hidden workspace needs my attention, color it so
    , ppUrgent          = dzenColor "#ff0000" "" . pad . dzenStrip

    -- shorten if it goes over 100 characters
    , ppTitle           = shorten 100  

    -- no separator between workspaces
    , ppWsSep           = ""

    -- put a few spaces between each object
    , ppSep             = "  "

    , ppOrder		= reverse

    -- output to the handle we were given as an argument
    , ppOutput          = hPutStrLn h

    }
