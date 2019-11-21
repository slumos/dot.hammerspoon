(set hs.logger.defaultLoggerLevel "info")
(set hs.window.animationDuration 0.0)
(set hs.window.highlight.ui.flashDuration 0.3)

(var buckeys [:ctrl :cmd])

(global ww spoon.WinWin)
(global logger (hs.logger.new "init" "info"))

(fn /2 [n] (// n 2))

(fn current-screen []
  (: (hs.window.focusedWindow) :screen))

(fn flash-window [window]
  (let [canvas (hs.canvas.new (window:frame))
        rectangle {"type" "rectangle"
                   "fillColor" {"red" 1 "green" 1 "blue" 0.65}}]
    (canvas:appendElements rectangle)
    (canvas:show)
    (canvas:delete 0.5)))

(fn highlight-active-window []
  (let [window (hs.window.focusedWindow)]
    (flash-window window)))

(fn half-left-frame [screen]
  (let [sframe (screen:frame)]
    (hs.geometry.new
     sframe.x
     sframe.y
     (/2 sframe.w)
     sframe.h)))

(fn half-right-frame [screen]
  (let [sframe (screen:frame)]
    (hs.geometry.new
     (+ sframe.x (/2 sframe.w))
     sframe.y
     (/2 sframe.w)
     sframe.h)))

(fn un-fullscreen-window [window]
  (if (window:isFullScreen) (window:setFullScreen false)))

(fn make-window-half-left [window]
  (un-fullscreen-window window)
  (window:moveToUnit hs.layout.left50)
  (flash-window window))

(fn make-window-half-right [window]
  (un-fullscreen-window window)
  (window:moveToUnit hs.layout.right50)
  (flash-window window))

(fn center-window [window]
  (window:centerOnScreen (window:screen))
  (flash-window window))

(fn is-half-left? [window]
  (local window-frame (window:frame))
  (local screen (window:screen))
  (: window-frame :equals (half-left-frame screen)))

(fn is-half-right? [window]
  (: (window:frame) :equals (half-right-frame (window:screen))))

(fn is-maximized? [window]
  (: (window:frame) :equals hs.layout.maximized))

(fn multiple-screens? []
  (let [screens (hs.screen.allScreens)]
    (> (length screens) 1)))

(fn make-window-big [window]
  "If there is only 1 screen, then full-screen window, else maximize it."
  (let [screens (hs.screen.allScreens)]
    (if (> (length screens) 1)
        (window:maximize)
        (window:setFullScreen true))))

(fn toggle-window-big [window]
  (if (window:isFullScreen) (window:setFullScreen false)
      (is-maximized? window) (center-window window)
      (make-window-big window)))

(fn move-window-to-screen [window direction]
  (local current-screen (window:screen))
  (local target-screen (: current-screen direction))
  (window:moveToScreen target-screen))

(fn send-window-left [window]
  (if (multiple-screens?)
      (if (is-half-left? window) (do (move-window-to-screen :previous)
                                   (make-window-half-right window))
          (make-window-half-left window))
      (make-window-half-left window)))

(fn send-window-right [window]
  (if (multiple-screens?)
      (if (is-half-right? window)
          (do
            (move-window-to-screen :next)
            (make-window-half-left window))
          (make-window-half-right window))
      (make-window-half-right window)))

(hs.hotkey.bind buckeys :left #(send-window-left (hs.window.focusedWindow)))
(hs.hotkey.bind buckeys :right #(send-window-right (hs.window.focusedWindow)))
(hs.hotkey.bind buckeys :up #(toggle-window-big (hs.window.focusedWindow)))

(hs.hotkey.bind buckeys "r" #(hs.reload))
