Config {
  font = "xft:M+ 1p:size=9:bold:antialias=true"
, bgColor = "black"
, fgColor = "gray"
, alpha = 160
, lowerOnStart = False
, position = TopSize L 100 25
, commands = [
    Run Battery        [ "--template" , "<acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "darkorange"
                             , "--high"     , "#34A853"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o" , "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O" , "<fc=#dAA520>Charging</fc>"
                                       -- charged status
                                       , "-i" , "<fc=#34A853>Charged</fc>"
                             ] 50
  , Run Network "enp0s25" ["-t", "<icon=.xmonad/icons/net.xbm/> <rx>KB | <tx>KB", "-L", "0", "-H", "32", "--normal", "#34A853", "--high", "#EA4335"] 10
  , Run Network "wlp3s0" ["-t", "<icon=.xmonad/icons/net.xbm/> <rx>KB | <tx>KB", "-L", "0", "-H", "32", "--normal", "#34A853", "--high", "#EA4335"] 10
  , Run Cpu ["-t", "<icon=.xmonad/icons/cpu.xbm/> <total>%", "-L", "3", "-H", "30", "--normal", "#34A853", "--high", "#EA4335"] 10
  , Run Memory ["-t", "<icon=.xmonad/icons/mem.xbm/> <usedratio>%"] 10
  , Run Swap ["-t", "<icon=.xmonad/icons/swap.xbm/> <usedratio>%"] 10
  , Run Date "%Y/%m/%d %a %k:%M" "date" 10
  , Run DiskIO [("sda2", "<icon=.xmonad/icons/disk.xbm/> <total>")] [] 10
  , Run StdinReader
  ]
, sepChar = "%"
, alignSep = "}{"
, template = "   g() %StdinReader% }{ %cpu%  %memory%  %swap%  %diskio%  %enp0s25%  %wlp3s0%  %battery% : %date%  " }
