(require 'package) 
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


; list the packages you want
(setq package-list '(flycheck company company-irony-c-headers company-irony flycheck-irony irony yasnippet magit iedit ample-zen-theme ))


; install the missing packages
;(dolist (package package-list)
;  (unless (package-installed-p package)
;    (package-install package)))



(require 'comint)
(setq comint-prompt-read-only t)
(setq comint-scroll-to-bottom-on-input t)

(load-library "yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;(load-library "magit")
;(require 'magit)

(load-library "irony")
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(load-library "company")
(add-hook 'after-init-hook 'global-company-mode)

(load-library "company-irony")
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(load-library "flycheck")
(add-hook 'after-init-hook #'global-flycheck-mode)

(load-library "flycheck-irony")
(eval-after-load 'flycheck
  '(add-to-list 'flycheck-checkers 'irony))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.2)
 '(company-minimum-prefix-length 2)
 '(custom-safe-themes
   (quote
    ("1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" default))))


(require 'server)
(server-force-delete)
(server-start)


(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

(provide '.emacs)
;;; .emacs ends here


; Add cuda files to C++ mode
(add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh$" . c++-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GENERIC TUNES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq vc-handled-backends nil)


;Get rid of the startup message
(setq inhibit-startup-message t)

;Display colnum and row position
(setq line-number-mode t)
(setq column-number-mode t)

;scroll line by line
(setq scroll-step 1)

; remove bars
(when (display-graphic-p)
  (tool-bar-mode -1)
  (menu-bar-mode -1))

; parenthesis mismatch
(require 'paren)
  (show-paren-mode)
  (setq show-paren-mismatch t)

;set C-d => delete selection
(delete-selection-mode t)

; indent stuff
(setq indent-tabs-mode nil)
(setq show-trailing-whitespace t)

(put 'upcase-region 'disabled nil)


; Previous multiframe window
(global-set-key (kbd "C-x p") 'previous-multiframe-window)


(defun toggle-fullscreen2 ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(toggle-fullscreen2)


(load-theme 'ample-zen)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
