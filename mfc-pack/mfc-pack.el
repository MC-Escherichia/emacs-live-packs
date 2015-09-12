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
;; (add-to-list 'default-frame-alist '( font . "DejaVu Sans Mono"))

(global-set-key (kbd "<M-f1>") #'toggle-debug-on-error)
(global-set-key (kbd "<M-f2>") #'toggle-debug-on-quit)

(defun buffer-face-mode-fixed ()
  "Sets a fixed width (monospace) font in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "DejaVu Sans Mono"
                                        :width condensed
                                        :height 110
                                        :weight medium))
  (buffer-face-mode))

(add-hook 'change-major-mode-after-body-hook  (buffer-face-mode-fixed))

(defun buffer-face-mode-variable ()
  "Set font to a variable width (proportional) fonts in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "DejaVu Serif"
                                        :height 110
                                        :weight light))
  (buffer-face-mode))

;; ABCDEFGHIJKLM
;; NOPQRSTUVWXYZ

(add-hook 'erc-mode-hook 'buffer-face-mode-variable)
;; Set default font faces for Info and ERC modes
(add-hook 'Info-mode-hook 'buffer-face-mode-variable)

(defun toggle-buffer-face ()
  (interactive)
  (if (string= (plist-get buffer-face-mode-face :family)
               "DejaVu Sans Mono")
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

(defun switch-to-mfc-pack ()
  (interactive)
  (switch-to-buffer (find-file "~/.emacs-live-packs/mfc-pack/mfc-pack.el")))

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
(global-set-key [C-f10] 'switch-to-mfc-pack)
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
;; moved delete trailing whitespace into live-cleanup-whitespace
;; (add-hook 'js2-mode-hook 'skewer-mode)

;; (add-hook 'css-mode-hook 'skewer-css-mode)
;; (remove-hook 'css-mode-hook 'skewer-css-mode)

(add-hook 'less-css-mode-hook 'skewer-less-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)


(add-hook 'less-css-mode-hook '(lambda () (local-set-tab-width 2)))
(add-hook 'js2-mode-hook '(lambda () (local-set-tab-width 2)))

(require 'skewer-mode)

;; (defun my-run-skewer ()
;;   (interactive)
;;   (httpd-stop)
;;   (setq httpd-port 8081)
;;   (httpd-start)
;;   (skewer-repl))

(setq httpd-port 8081)

;; color theme simplified
;; (require 'zenburn-theme)
(load-theme 'ample-zen t)



;; (add-hook 'less-css-mode '(lambda () (add-hook 'before-save-hook (lambda () (replace-string "    " "  ")) t t)))

;; (add-to-list 'load-path "~/path/to/js-comint")

;; (require 'js-comint)
;; Use node as our repl
;; (setq inferior-js-program-command "node")

;; (setq inferior-js-mode-hook
;;       (lambda ()
;;         ;; We like nice colors
;;         (ansi-color-for-comint-mode-on)
;;         ;; Deal with some prompt nonsense
;;         (add-to-list 'comint-preoutput-filter-functions
;;                      (lambda (output)
;;                        (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
;;                                                  (replace-regexp-in-string ".*1G.*3G" "&gt;" output))))))


;; Avy config

(global-set-key (kbd "C-:") 'iedit-mode)
(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-g g") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)

(avy-setup-default)
;; emacs-development work

(--each  (f-directories "~/.emacs.d/dev/")
  (add-to-list 'load-path it))

(require 'slime)
(setq slime-contribs '(slime-fancy slime-js))
;; swank js
(require 'slime-js)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-mode 1)
            (local-set-key [f5] 'slime-js-reload)
            ;; (setq slime-contribs '())
            (slime-js-minor-mode 1)))



;; (load (expand-file-name "~/.emacs.d/.cask/24.5.1/elpa/slime-20150731.1337/contrib/slime-js"))
                                        ;
(global-company-mode)
(defun local-set-tab-width (n)
  (set-variable 'tab-width n t))
(when  (require 'jade-mode nil t)



  (add-hook 'jade-mode-hook (lambda ()
                              (setq indent-tabs-mode t)
                              (push 'jade-mode live-ignore-whitespace-modes)
                              (local-set-tab-width 2)
                              (remove-hook 'before-save-hook 'delete-trailing-whitespace))))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/conkeror")
;;; finally


(defun run-skewer-ff ()
  (interactive)
  (let ((browse-url-generic-program "/usr/bin/firefox"))
    (run-skewer)))

;; (if (not  (server-running-p))
;;     (server-start))

(provide 'mfc-pack)
