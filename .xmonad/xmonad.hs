import XMonad
import System.IO (hPutStrLn)
import Data.Monoid (Endo)
import Data.Time.Clock
import Data.Time.Calendar
import Data.List (isPrefixOf, isInfixOf)
import System.Exit (exitSuccess)

import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Hooks.EwmhDesktops (ewmh)
--import XMonad.Layout.Named
import XMonad.Hooks.ManageDocks (avoidStruts, docks, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarStrip, xmobarColor, shorten, PP(..))
import XMonad.Hooks.SetWMName
import XMonad.Hooks.InsertPosition

import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.Spacing (spacing)
import XMonad.Layout.PerWorkspace (onWorkspaces)
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.ResizableTile
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.SimplestFloat (simplestFloat)
import XMonad.Actions.CycleWS (nextScreen)
import XMonad.Actions.MouseResize (mouseResize)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import XMonad.Prompt.DirExec (dirExecPrompt)

modm :: KeyMask
modm = mod1Mask

myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1..9]

myFont :: String
myFont = "xft:Mononoki:size=14:antialias=true:hinting=true"
--myLayout = named "<icon=/home/thotspot/.config/xmobar/xpm/uzumaki.xpm/>" $ ResizableTall 1 (3/100) (1/2) []
myTerminal :: String
myTerminal = "/usr/bin/alacritty"

myStartupHook :: X ()
myStartupHook = do
    --spawn "/usr/bin/dunst"
    spawn "feh --bg-scale /home/thotspot/.Pokebg.jpg"

tall     = renamed [Replace "tall"]
          $ spacing 1
          $ noBorders
          $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "full"]
        $spacing 1
        $ noBorders
        $ Full
floats = renamed [Replace "flts"]
        $ spacing 1
        $ noBorders
        $ simplestFloat

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $
    mkToggle (NBFULL ?? NOBORDERS ?? EOT) $
    --onWorkspaces [2, 4, 5, 8] monocle $
    myDefaultLayout
    where
    myDefaultLayout =   tall
                    ||| monocle
                    ||| floats

myXPConfig :: XPConfig
myXPConfig = def
      { font                = "xft:Mononoki:size=16"
      , bgColor             = "#b8bb26"
      , fgColor             = "#1d2021"
      , bgHLight            = "#ebdbb2"
      , fgHLight            = "#fabd2f"
      , borderColor         = "#b8bb26"
      , promptBorderWidth   = 0
      , position            = CenteredAt { xpCenterY = 0.2, xpWidth = 0.7 }
      , height              = 50
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 0  -- set Just 100000 for .1 sec
      , showCompletionOnTab = True
      , searchPredicate     = isPrefixOf
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to Just 5 for 5 rows
      }

-- -d: dimensions, -t: title
spawnFloatingTerm :: String -> X ()
spawnFloatingTerm cmd = spawn $ "alacritty " ++ opt ++ " -e" ++ cmd
    where
        opt = col ++ lin ++ posx ++ posy ++ floatDecorator
            where
                col = "-o window.dimensions.columns=200 "   -- 123
                lin = "-o window.dimensions.lines=35 "      -- 34
                posx = "-o window.position.x=60 "           -- 10
                posy = "-o window.position.y=40 "           -- 10
                floatDecorator = "-t \"float\""

replace :: Eq t => t -> t -> [t] -> [t]
replace a b = map (\c -> if c==a then b; else c)


myKeys :: [(String, X ())]
myKeys = [
    -- XMonad
      ("M-r", spawn "xmonad --recompile")       -- Recompiles xmonad
    , ("M-S-r", spawn "xmonad --restart")       -- Restarts xmonad
    , ("M-S-e", io exitSuccess)                 -- Quits xmonad, dvorak 'e' and 'q' are too close
    , ("M-S-q", kill)                           -- kill client
    , ("M-b", sendMessage ToggleStruts)         -- Toggle xmobar
    , ("M-t", withFocused $ windows . W.sink)   -- Tile client again
    , ("M-m", windows W.swapMaster)             -- Set master
    , ("M-n", sendMessage MirrorExpand)         -- expand tile
    , ("M-S-n", sendMessage MirrorShrink)       -- shrink tile

    --, ("M-e", spawn "eww close-all")            -- close all widgets
    , ("M-n", spawn "/usr/bin/firefox")
    , ("M-S-d", sendMessage (IncMasterN 1))     -- one more master
    , ("M-d", sendMessage (IncMasterN (-1)))    -- one master fewer
    ,("M-g", nextScreen)                        -- other screen


    -- Override
    , ("M-<Return>", spawn myTerminal)

    -- Media Keys
    , ("<F6>", spawn "amixer -q sset Master 5%-")
    , ("<F7>", spawn "amixer -q sset Master 5%+")
    , ("<F8>", spawn "amixer -q sset Master toggle")
    , ("<F2>", spawn "doas light -U 5")
    , ("<F3>", spawn "doas light -A 5")
    -- For the Alt Keyboard
    , ("S-<XF86AudioLowerVolume>", spawn "doas light -U 5")
    , ("S-<XF86AudioRaiseVolume>", spawn "doas light -A 5")



     , ("M-p", spawn "scrot screen_%Y-%m-%d-%H-%M-%S.png -d 1 $f ~/screenShots")


    -- Prompt
    , ("M-o", runOrRaisePrompt myXPConfig)
    ]

myRemKeys :: [String]
myRemKeys = [
        "M-S-<Return>"
        , "M-S-q"
    ]

-- IntelliJ fix
(~=?) :: Eq a => Query [a] -> [a] -> Query Bool
q ~=? x = fmap (isInfixOf x) q

manageIdeaCompletionWindow = (className =? "jetbrains-studio") <&&> (title ~=? "win") --> doIgnore

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = insertPosition Below Newer <+> composeAll
    [ -- Firefox
      title =? "Mozilla Firefox"               --> doShift ( myWorkspaces !! 1 )
      ,(className =? "Mozilla Firefox" <&&> resource =? "Dialog") --> doFloat
    -- Teams
    , className =? "Microsoft Teams - Preview" --> doShift ( myWorkspaces !! 3 )
    , title =? "Microsoft Teams-Benachrichtigung"   --> doFloat
    -- Gimp
    , stringProperty "WM_WINDOW_ROLE" =? "gimp-message-dialog" --> doFloat
    -- Generic
    , title =? "float"                              --> doFloat
    ]

main = do
    xmproc0 <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ ewmh $ docks $ def {
        modMask              = modm
        , focusFollowsMouse  = False
        , borderWidth        = 0
        , terminal           = myTerminal
        , focusedBorderColor = "#b8bb26"
        , normalBorderColor  = "#f2e5bc"
        , layoutHook         = myLayoutHook
        , startupHook        = myStartupHook
        , workspaces         = myWorkspaces
        , manageHook         = myManageHook <+> manageIdeaCompletionWindow
        , logHook = dynamicLogWithPP xmobarPP 
                {
                    ppOutput = hPutStrLn xmproc0
                    , ppCurrent = xmobarColor "#b8bb28" ""                -- Current workspace in xmobar
                    , ppVisible = xmobarColor "#fabd2f" ""                -- Visible but not current ws
                    , ppHidden = xmobarColor "#fabd2f" ""                 -- Hidden workspaces in xmobar
                    , ppHiddenNoWindows = xmobarColor "#928374" ""        -- Hidden workspaces (no windows)
                    , ppTitle = xmobarColor "#bdae93" "" . shorten 60     -- Title of active window
                    , ppSep =  " | "                                      -- Separators in xmobar
                    , ppUrgent = xmobarColor "#fb4934" "#50945" . wrap "!" "!"  -- Urgent workspace
                    , ppExtras  = [windowCount]                           -- # of windows current workspace
                    , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                }
    } `removeKeysP` myRemKeys `additionalKeysP` myKeys

