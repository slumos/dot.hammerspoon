(set hs.logger.defaultLoggerLevel "info")
(set hs.window.animationDuration 0.0)
(set hs.window.highlight.ui.flashDuration 0.3)

(var buckeys [:ctrl :cmd])

(global logger (hs.logger.new "init" "info"))

(local win (require :windows))

(fn current-screen []
  (: (hs.window.focusedWindow) :screen))

(fn dump []
  (local focused-window (hs.window.focusedWindow))
  (local focused-screen (focused-window:screen))
  (print "Dump:")
  (print "Focused window:" focused-window)
  (print "  Frame:" (focused-window:frame))
  (print "Screen:" focused-screen)
  (print "  Half-left:" (half-left-frame focused-screen))
  (print "  Half-right:" (half-right-frame focused-screen)))

(hs.hotkey.bind buckeys :left #(win.send-window-left (hs.window.focusedWindow)))
(hs.hotkey.bind buckeys :right #(win.send-window-right (hs.window.focusedWindow)))
(hs.hotkey.bind buckeys :up #(win.toggle-window-big (hs.window.focusedWindow)))

(hs.hotkey.bind buckeys "r" #(hs.reload))
(hs.hotkey.bind buckeys "d" #(dump))
