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

(hs.hotkey.bind [:cmd :alt] "r" (fn [] (hs.reload)))
(hs.hotkey.bind [:cmd :alt] :left (fn [] (ww:moveAndResize "halfleft")))
(hs.hotkey.bind [:cmd :alt] :right (fn [] (ww:moveAndResize "halfright")))


(hs.alert.show "loaded...")

;; (fn moveOrThrow [option]
;;   (let [window (hs.window.focusedWindow)
;;         frame (: win frame)
;;         fudge 5]
;;     (=
;;     ))
;;
;; (fn half-left-rect (screen)
;;   (let [sr (screen:frame)]
;;     (hs.geometry.new sr.x sr.y (// sr.w 2) sr.h)))
