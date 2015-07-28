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

;; (install-packages-pack/install-packs '(helm-spotify spotify))
(global-set-key (kbd "s-<down>") #'spotify-playpause)
(global-set-key (kbd "s-<right>") #'spotify-next)
(global-set-key (kbd "s-<up>") #'helm-spotify)

                                        ;On a system supporting freedesktop.org's D-Bus you can enable song notifications in the minibuffer.

;; God dman it matt, remember to add the proper lines to xinitrc, so minimal WM's have access to dbus
(spotify-enable-song-notifications)

;; themes
(add-to-list 'default-frame-alist '( font . "DejaVu Sans Mono"))

(defun buffer-face-mode-fixed ()
  "Sets a fixed width (monospace) font in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "DejaVu Sans Mono" :height 110 :weight medium))
  (buffer-face-mode))

(buffer-face-mode-fixed)

(defun buffer-face-mode-variable ()
"Set font to a variable width (proportional) fonts in current buffer"
(interactive)
(setq buffer-face-mode-face '(:family "DejaVu Serif" :height 110 :width medium :weight medium))
(buffer-face-mode))

;; ABCDEFGHIJKLM
;; NOPQRSTUVWXYZ

(add-hook 'erc-mode-hook 'buffer-face-mode-variable)
;1; Set default font faces for Info and ERC modes
(add-hook 'Info-mode-hook 'buffer-face-mode-variable)

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


(setq mfc-home-file "~/Dropbox/org/journal.org")
(defun set-mfc-home ()
  (interactive)
  (setq mfc-home-file buffer-file-name))

(defun switch-to-mfc-home ()
  (interactive)
  (switch-to-buffer (find-file mfc-home-file)))

(defun switch-to-todo ()
  (interactive)
  (switch-to-buffer (find-file "~/Dropbox/org/gtd/gtd.org")))

(defun check-messages ()
  (interactive)
  (if (string-equal (buffer-name) "*Messages*")
      (switch-to-buffer (other-buffer))
    (switch-to-buffer "*Messages*")))

;; (install-packages-pack/install-packs '(writeroom-mode centered-window-mode))
(global-set-key [C-f6] 'centered-window-mode)
(global-set-key [C-f11] 'switch-to-mfc-home)
(global-set-key [C-f12] 'switch-to-todo)

(global-set-key (kbd "C-x m")
                'check-messages)
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





(defun local-set-tab-width (n)
  (set-variable 'tab-width n t))

(add-hook 'jade-mode-hook (lambda ()
                            (setq indent-tabs-mode t)
                            (push 'jade-mode live-ignore-whitespace-modes)
                            (local-set-tab-width 2))) (remove-hook 'before-save-hook 'delete-trailing-whitespace)

                                        ;  moved delete trailing whitespace into live-cleanup-whitespace
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'less-css-mode-hook 'skewer-less-mode)

(add-hook 'html-mode-hook 'skewer-html-mode)


(add-hook 'less-css-mode-hook '(lambda () (local-set-tab-width 2)))

(require 'skewer-mode)

(defun my-run-skewer ()
  (interactive)
  (httpd-stop)
  (setq httpd-port 8081)
  (httpd-start)
  (skewer-repl))


;; (add-hook 'less-css-mode '(lambda () (add-hook 'before-save-hook (lambda () (replace-string "    " "  ")) t t)))

;; emacs-development work



(--each  (f-directories "~/.emacs.d/dev/")
  (add-to-list 'load-path it))







;;; finally

(if (not  (server-running-p))
    (server-start))
