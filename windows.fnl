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
  (screen:fromUnitRect hs.layout.left50))

(fn half-right-frame [screen]
  (screen:fromUnitRect hs.layout.right50))

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

(fn window-approximately [window target-frame delta-arg]
  "True if window is approximately the same as frame"
  (let [delta (or delta-arg 100.0)
        window-frame (window:frame)
        d1 (: window-frame.xy :distance target-frame.xy)
        d2 (: window-frame.x2y2 :distance target-frame.x2y2)]
    ;; (logger.d window-frame target-frame delta)
    ;; (logger.d d1 d2)
    ;; (logger.d (and (< d1 delta) (< d2 delta)))
    (and (< d1 delta) (< d2 delta))))

(fn is-half-left? [window]
  (local window-frame (window:frame))
  (local screen (window:screen))
  (window-approximately window (screen:fromUnitRect hs.layout.left50)))

(fn is-half-right? [window]
  (local window-frame (window:frame))
  (local screen (window:screen))
  (window-approximately window (screen:fromUnitRect hs.layout.right50)))

(fn is-maximized? [window]
  (: (window:frame) :equals hs.layout.maximized))

(fn multiple-screens? []
  (let [screens (hs.screen.allScreens)]
    (> (length screens) 1)))

;; (fn make-window-big [window]
;;   "If there is only 1 screen, then full-screen window, else maximize it."
;;   (let [screens (hs.screen.allScreens)]
;;     (if (> (length screens) 1)
;;         (window:maximize)
;;         (window:setFullScreen true))))

(fn make-window-big [window]
  (window:maximize)
  (flash-window window))

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
      (if (is-half-left? window)
          (do
            (move-window-to-screen window :previous)
            (make-window-half-right window))
          (make-window-half-left window))
      (make-window-half-left window)))

(fn send-window-right [window]
  (if (multiple-screens?)
      (if (is-half-right? window)
          (do
            (move-window-to-screen window :next)
            (make-window-half-left window))
          (make-window-half-right window))
      (make-window-half-right window)))

{
 :flash-window            flash-window
 :highlight-active-window highlight-active-window
 :half-left-frame         half-left-frame
 :half-right-frame        half-right-frame
 :un-fullscreen-window    un-fullscreen-window
 :make-window-half-left   make-window-half-left
 :make-window-half-right  make-window-half-right
 :center-window           center-window
 :window-approximately    window-approximately
 :is-half-left?           is-half-left?
 :is-half-right?          is-half-right?
 :is-maximized?           is-maximized?
 :multiple-screens?       multiple-screens?
 :make-window-big         make-window-big
 :toggle-window-big       toggle-window-big
 :move-window-to-screen   move-window-to-screen
 :send-window-left        send-window-left
 :send-window-right       send-window-right
}
