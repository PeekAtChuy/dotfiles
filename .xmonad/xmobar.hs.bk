Config { font = "xft:Mononoki Nerd Font:pixelsize=20:antialias=true:hinting=true"
       , additionalFonts = []
       , borderColor = "#1d2021"
       , border = TopB
       , bgColor = "#11042d"
       , fgColor = "#ebdbb2"
       , alpha = 0
       , position = TopP 5 5
       , textOffset = -1
       , iconOffset = -1
       , lowerOnStart = True
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run DynNetwork ["--", "--devices", "wlo1,eno1"] 50
                    , Run Cpu ["-L","3","-H","50",
                               "--high","#fb4934"
                               , "-t", "<total>%"] 20
                    , Run Date "%b %d %Y %H:%M" "date" 300
                    -- battery monitor
                    , Run Battery        [ "--template" , "<acstatus>"
                                , "--Low"      , "10"        -- units: %
                                , "--High"     , "95"        -- units: %
                                , "--low"      , "#fb4934"
                                , "--high"     , "#b8bb26"

                                -- send message when low
                                , "-a", "notify-send -u critical battery"
                                --, "-A", "5"
                                , "--" -- battery specific options
                                -- discharging status
                                , "-o"  , " <left>% <timeleft>"
                                -- AC "on" status
                                , "-O"    , "<left>% <fc=#fabd2f> Charging</fc>"
                                -- charged status
                                , "-i"  , "<fc=#1794CC> Charged</fc>"
                            ] 150
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <fc=#2B7CC3></fc> | %battery% | %StdinReader% | }\
                    \{ | <fc=#83a598>  %cpu%</fc> | <fc=#1F9FBC>  %dynnetwork%</fc> | <fc=#BDCC17>  %date%</fc> "
       }
       --         
