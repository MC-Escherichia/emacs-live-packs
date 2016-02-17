;;js2 mode
(require 'js2-mode)


(require 'js2-refactor)
(require 'requirejs)
(require 'tern)
(require 'company-tern)



(add-hook 'js2-mode-hook
          (lambda ()
            (slime-setup '(slime-js))
            (global-set-key [f5] 'slime-js-reload)
            (slime-js-minor-mode 1)
            (js2-refactor-mode 1)
            (requirejs-mode)
            (tern-mode t)
            (flycheck-mode t)))

(provide 'js-pack)
