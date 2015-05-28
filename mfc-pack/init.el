;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
 (add-hook 'clojure-mode-hook (lambda ()
                              (clj-refactor-mode 1)
;;                              ;; inset keybidning set up here
;;
                              (cljr-add-keybindings-with-prefix "C-q")
                              (paredit-mode 0)
                              (lispy-mode)))

(add-hook 'cider-repl-mode-hook
          (lambda()
            (lispy-mode)
            (local-set-key (kbd "M-RET") 'cider-repl-return)))


; disable damn insert key
(global-unset-key (kbd "<insert>"))

(global-auto-revert-mode t)

(install-packages-pack/install-packs '(helm-spotify spotify))
(global-set-key (kbd "s-<pause>") #'spotify-playpause)
(global-set-key (kbd "s-M-<pause>") #'spotify-next)

;On a system supporting freedesktop.org's D-Bus you can enable song notifications in the minibuffer.

(spotify-enable-song-notifications)

;; themes
 (add-to-list 'default-frame-alist '( font . "inconsolata"))
(set-face-attribute 'default nil :height 110 :width 'condensed )




 (defun buffer-face-mode-fixed ()
"Sets a fixed width (monospace) font in current buffer"
(interactive)
(setq buffer-face-mode-face '(:family "Inconsolata" :height 120 :weight medium))
(buffer-face-mode))

(defun buffer-face-mode-variable ()
"Set font to a variable width (proportional) fonts in current buffer"
(interactive)
(setq buffer-face-mode-face '(:family "DejaVu Serif" :height 120 :width semi-expanded :weight medium))
(buffer-face-mode))

(add-hook 'erc-mode-hook 'my-buffer-face-mode-variable)
;1; Set default font faces for Info and ERC modes
(add-hook 'Info-mode-hook 'my-buffer-face-mode-variable)

(defun toggle-buffer-face ()
   (interactive)
   (if (or (not (boundp 'buffer-face-mode-face)) (not (member :width buffer-face-mode-face)))
     (buffer-face-mode-variable)
     (buffer-face-mode-fixed)))


;(add-hook 'after-make-frame-functions 'toggle-buffer-face)

(global-set-key (kbd "<C-f1>") 'toggle-buffer-face)

;; end of line for gnuplot-mode
;;--------------------------------------------------------------------
;; for GDB/debugging in general
(global-set-key (kbd "<f10>") 'gud-cont)
(global-set-key (kbd "<f9>") 'gud-step);; equiv matlab step in
(global-set-key (kbd "<f8>") 'gud-next) ;; equiv matlab step 1
(global-set-key (kbd "<f7>") 'gud-finish) ;; equiv matlab step out


(setq inferior-julia-program-name "julia")

(defun unix-newline () (set-buffer-file-coding-system 'undecided-unix))
(add-hook 'before-save-hook 'unix-newline)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


(setq mfc-home-file "~/Dropbox/org/researchjournal.org" )
(defun set-mfc-home ()
  (interactive)
  (setq mfc-home-file buffer-file-name))


(defun switch-to-mfc-home ()
  (interactive)
  (switch-to-buffer (find-file mfc-home-file)))



(global-set-key [f6] 'centered-window-mode)
(global-set-key [f11] 'switch-to-mfc-home)
(global-set-key [f12] 'switch-to-todo)



;(require 'cider-inspect)

;(setq nrepl-hide-special-buffers t)
;;  ;(setq nrepl-popup-stacktraces-in-repl t)
;;  (setq nrepl-history-file "~/.emacs.d/nrepl-history")
;;  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;;  (setq nrepl-log-messages t)
;;
;;  (add-hook 'nrepl-connected-hook
;;  (defun pnh-clojure-mode-eldoc-hook ()
;;  (add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
;;  ;(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
;;  ;(nrepl-enable-on-existing-clojure-buffers)))
;;
;;  ;; Repl mode hook
;;  (add-hook 'nrepl-mode-hook 'subword-mode)
;;
;;  ;; Auto completion for NREPL
;;  (require 'ac-nrepl)
;;  (eval-after-load "auto-complete"
;;  '(add-to-list 'ac-modes 'nrepl-mode))
;;  (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
