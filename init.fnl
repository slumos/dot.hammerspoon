(var buckeys [:ctrl :cmd])
(set hs.window.animationDuration 0.0)

(global ww spoon.WinWin)

;; toggle hs.console with Ctrl+Cmd+~
(hs.hotkey.bind
 [:alt :cmd] "`" nil
 (fn []
   (let [console (hs.console.hswindow)]
     (when console
       (if (= console (hs.window.focusedWindow))
           (-> console (: :application) (: :hide))
           (-> console (: :raise) (: :focus)))))))

(hs.hotkey.bind buckeys "r" (fn [] (hs.reload)))
;;(hs.hotkey.bind buckeys :left (fn [] (ww:moveAndResize "halfleft")))

(hs.hotkey.bind buckeys :right (fn [] (ww:moveAndResize "halfright")))

(hs.alert.show "loaded...")

(fn current-screen []
  (: (hs.window.focusedWindow) :screen))

(fn highlight-active-window []
  (let [rect (hs.drawing.rectangle (: (hs.window.focusedWindow) :frame))]
    (: rect :setStrokeColor {:red 1 :blue 0 :green 1 :alpha 1})
    (: rect :setStrokeWidth 5)
    (: rect :setFill false)
    (: rect :show)
    (hs.timer.doAfter .3 (fn [] (: rect :delete)))))

(fn half-left-frame [screen]
  (let [screen-frame (screen:frame)]
    (hs.geometry.new
     screen-frame.x
     screen-frame.y
     (// screen-frame.w 2)
     screen-frame.h)))

(fn make-window-half-left [window]
  (window:setFrame (half-left-frame (window:screen))))

(fn window-half-left? [window]
  (let [window-frame (window:frame)]
    (. window-frame :equal (half-left-frame (window:screen)))))

(hs.hotkey.bind buckeys :left (fn []
                                (let [window (hs.window.focusedWindow)]
                                  (make-window-half-left window))))

(window-half-left? (hs.window.focusedWindow))
