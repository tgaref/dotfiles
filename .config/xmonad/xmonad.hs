import XMonad hiding ((|||), float)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks (manageDocks, avoidStruts, docksEventHook, docks)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys,additionalKeysP,removeKeys)
import System.IO
import System.Exit
import XMonad.Actions.CycleWS (nextWS, prevWS, moveTo, shiftToNext, shiftToPrev, Direction1D (Next, Prev), WSType (WSIs))
import XMonad.Actions.Navigation2D (windowGo, windowSwap, switchLayer, withNavigation2DConfig, Direction2D ( D,U,L,R ))
import XMonad.Layout.LayoutCombinators ((|||))
import XMonad.Actions.CycleSelectedLayouts 
import XMonad.StackSet (tag, focusDown, RationalRect (..), sink, float, floating, shift)
import XMonad.Layout.ResizableTile (MirrorResize (MirrorShrink, MirrorExpand), ResizableTall (..)) 
import XMonad.ManageHook
import XMonad.Util.NamedScratchpad (namedScratchpadManageHook, customFloating,
                                    namedScratchpadAction, NamedScratchpad ( NS ))
import Graphics.X11.ExtraTypes.XF86               
import qualified Data.Map as M
import qualified XMonad.DBus as D
import qualified DBus.Client as DC
import qualified Codec.Binary.UTF8.String as UTF8

myModMask = mod4Mask      -- Rebind Mod to the Windows key
altMask = mod1Mask
myTerminal = "alacritty  --config-file /home/tgaref/.config/alacritty/alacritty.yml --class term"
myNormalBorderColor = "#FF8A00"
myFocusedBorderColor = "#0011FF"
myBGcolor = "#2f343f"

-- Colours
fg        = "#ebdbb2"
bg        = "#282828"
gray      = "#a89984"
grey      = "#7F7F7F"
bg1       = "#3c3836"
bg2       = "#505050"
bg3       = "#665c54"
bg4       = "#7c6f64"

green     = "#b8bb26"
darkgreen = "#98971a"
red       = "#fb4934"
darkred   = "#cc241d"
yellow    = "#fabd2f"
blue      = "#83a598"
purple    = "#d3869b"
aqua      = "#8ec07c"
white     = "#eeeeee"

pur2      = "#5b51c9"
blue2     = "#2266d0"


main = do
  dbus <- D.connect
   -- Request access (needed when sending messages)
  D.requestAccess dbus
  xmonad $ ewmh $ docks $ withNavigation2DConfig def $ myConfig dbus

myConfig dbus = def
  { manageHook = myManageHook
  , layoutHook = avoidStruts $ myLayout
  , startupHook = myStartupHook
  , logHook = dynamicLogWithPP (myPolybarHook dbus)
  , modMask = myModMask
  , terminal = myTerminal
  , workspaces = fmap show [1..8]
  , normalBorderColor  = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor      
  }
  `removeKeys`
  [ (myModMask              , xK_space)
  , (myModMask .|. shiftMask, xK_q)
  , (myModMask              , xK_j)
  , (myModMask              , xK_k)
  ]          
  `additionalKeys`
  [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
  , ((0          , xK_Print), spawn "scrot")
  , ((0          , xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-")
  , ((0          , xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+")
  , ((0          , xF86XK_AudioMute), spawn "amixer set Master toggle")
  , ((0          , xK_F12), spawn "amixer set Master toggle")
  , ((0          , xK_F3), namedScratchpadAction scratchpads "emacsdrop")
  , ((0          , xK_F2), namedScratchpadAction scratchpads "termdrop")
  , ((0          , xK_F1), spawn "rofi -show drun -no-fixed-num-lines -show-icons -theme launcher")
  , ((altMask    , xK_Tab), spawn "rofi -show window -theme launcher -show-icons -no-fixed-num-lines")
  , ((altMask .|. controlMask  , xK_Left  ), moveTo Prev (WSIs notSP))
  , ((altMask .|. controlMask  , xK_Right ), moveTo Next (WSIs notSP))
  , ((controlMask .|. shiftMask, xK_Right),  shiftToNext)
  , ((controlMask .|. shiftMask, xK_Left),   shiftToPrev)
  ] `additionalKeys`
  [ ((controlMask .|. shiftMask, k), windows $ shift i)
  | (i, k) <- zip (fmap show [1 .. 9]) [xK_1 .. xK_9] --(workspaces conf) workspaceKeys
  ] `additionalKeys`
  [ -- Switch between layouts
    ((myModMask             , xK_l ),    cycleThroughLayouts ["Full", "ResizableTall"])
    -- Directional navigation of windows
  , ((myModMask,                 xK_Right), windowGo R False)
  , ((myModMask,                 xK_Left ), windowGo L False)
  , ((myModMask,                 xK_Up   ), windowGo U False)
  , ((myModMask,                 xK_Down ), windowGo D False)
    -- Swap adjacent windows
  , ((myModMask .|. shiftMask, xK_Right), windowSwap R False)
  , ((myModMask .|. shiftMask, xK_Left ), windowSwap L False)
  , ((myModMask .|. shiftMask, xK_Up   ), windowSwap U False)
  , ((myModMask .|. shiftMask, xK_Down ), windowSwap D False)
  ] `additionalKeysP`
  [ ("M-S-k", sendMessage MirrorShrink)
  , ("M-S-j", sendMessage MirrorExpand)
  , ("M-S-h", sendMessage Shrink)
  , ("M-S-l", sendMessage Expand)
  , ("M-r b", spawn "firefox")
  , ("M-r e", spawn "emacsclient -c")
  , ("M-r u", spawn "urxvtc")
  , ("M-r t", spawn myTerminal)
  , ("M-S-q", spawn "/home/tgaref/local/bin/rofi-system.fish")
  , ("M-f", withFocused toggleFloat)
  ]
  where
    notSP = (return $ ("NSP" /=) . tag) :: X (WindowSpace -> Bool)
    toggleFloat w = windows (\s -> if M.member w (floating s)
                                   then sink w s
                                   else (float w (RationalRect (1/4) (1/4) (1/2) (1/2)) s))


--------------------------------------------------------------------------------
-- LOGHOOK
--------------------------------------------------------------------------------

myPolybarHook :: DC.Client -> PP
myPolybarHook dbus = def
  { ppOutput  = D.send dbus
  , ppCurrent = wrapper yellow
  , ppVisible = wrapper grey
  , ppUrgent  = wrapper red
  , ppHidden  = wrapper grey
  , ppTitle   = shorten 70 . wrapper aqua
  }
  where
    wrapper c s | s /= "NSP" = wrap ("%{F" <> c <> "}") "%{F-}" s
                | otherwise  = mempty

--------------------------------------------------------------------------------
-- LAYOUT                                                                   
--------------------------------------------------------------------------------

myLayout = avoidStruts $ Full ||| ResizableTall nmaster delta ratio []
  where
    nmaster = 1      -- The default number of windows in the master pane
    ratio   = 1/2    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes

--------------------------------------------------------------------------------
-- MANAGEHOOK                                                                   
--------------------------------------------------------------------------------

myManageHook = composeAll $
  [ manageDocks
  , manageNamedScratchPad
  , manageApps
  , manageHook def
  ]

manageApps = composeAll
    [ className =? "firefox"          --> doShift "2"
    , className =? "Google-chrome"    --> doShift "2"
    , className =? "brave-browser"    --> doShift "2"
    , className =? "Gnome-calculator" --> doFloat
    , className =? "skype"            --> doFloat
    , title =? "scratchdrop"          --> doFloat
    , title =? "emacsdrop"            --> doFloat
    , isDialog                        --> doFloat
    , isFullscreen                    --> doFullFloat
    ]

manageNamedScratchPad :: ManageHook
manageNamedScratchPad = namedScratchpadManageHook scratchpads

scratchpads = [ NS "emacsdrop" "emacsclient --alternate-editor='' --no-wait --create-frame --frame-parameters='(quote (name . \"emacsdrop\"))'"
--              , NS "ranger" "alacritty --config-file /home/tgaref/.config/alacritty/alacritty.yml -t ranger -e ranger"
                 (title =? "emacsdrop") (customFloating $ RationalRect (1/10) (1/40) (4/5) (3/4))
--              , NS "tmux" "urxvtc -e tmux" (title =? "tmux")
              , NS "termdrop" "alacritty --config-file /home/tgaref/.config/alacritty/alacritty.yml -t scratchdrop -e tmux"
                (title =? "scratchdrop") (customFloating $ RationalRect (1/10) (1/40) (4/5) (4/5))
              ]

--------------------------------------------------------------------------------
-- STARTUPHOOK                                                                   
--------------------------------------------------------------------------------

myStartupHook :: X ()
myStartupHook = do
  spawn "/home/tgaref/.config/polybar/launch-xmonad.sh"
  spawn "picom"
  spawn "nm-applet"
--  spawn "megasync"
  spawn "dropbox start"
  spawn "xfce4-power-manager"
  spawn "udiskie"
  spawn "setxkbmap -layout \"us,gr\" -option grp:win_space_toggle -option grp_led:scroll :2"
  spawn "xset r rate 200 30"
  spawn "xsetroot -cursor_name left_ptr"
--  spawn "hsetroot -fill /home/tgaref/Pictures/604102-data-science-wallpaper.jpg"
  spawn "hsetroot -fill /home/tgaref/Pictures/nord-wallpaper.jpg"
--  spawn "urxvtd"
  spawn "emacs --daemon"
 
