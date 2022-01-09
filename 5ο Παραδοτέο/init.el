;;;;;;;;;;;;;;;;;
;;Miscellaneous;;
;;;;;;;;;;;;;;;;;

;;Making things faster 
(setq gc-cons-threshold 100000000)

;;Do not let custom-set variables dirty the init file
(setq custom-file (concat user-emacs-directory "/custom.el"))


;;;;;;;;;;;;;;;;;;
;;Package System;;
;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa"  . "https://elpa.gnu.org/packages/")
			 ("org"   . "http://orgmode.org/elpa/")))

(package-initialize)
(unless package-archive-contents
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
    (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;Initial UI;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;If GUI, disable this
(if (display-graphic-p)
    (progn
	(tool-bar-mode	 -1)            ; Disable the toolbar
	(tooltip-mode	 -1)            ; Disable tooltips
	(menu-bar-mode	 -1)            ; Disable the menu bar
	(scroll-bar-mode -1)))


;;Visual helpers
(column-number-mode)
(global-display-line-numbers-mode t)
(display-time-mode 1)
(display-battery-mode 1)
(transient-mark-mode 1)

;;Disable line numbers for some modes 
(dolist (mode '(org-mode-hook
		org-agenda-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0))))


;;Set the font
(set-face-attribute 'default nil :font "NovaMono for Powerline" :height 130 :weight 'light)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "NovaMono for Powerline" :height 130 :weight 'light)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "NovaMono for Powerline" :height 130)

;;Splash screen
(use-package page-break-lines)
(use-package dashboard
    :ensure t
    :config
    (dashboard-setup-startup-hook)
    (setq dashboard-banner-logo-title "May this world be liberated from the tyranny of material reality")
    (setq dashboard-set-navigator t)
    (setq dashboard-startup-banner "/home/darklord/Pictures/hqdefault.png")
    (setq dashboard-center-content t)
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    (setq dashboard-set-footer nil)
    (setq dashboard-set-init-info nil)
    (setq dashboard-week-agenda t))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;Packages;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Help with keystrokes
(use-package which-key
    :init
    (setq which-key-separator " ")
    (setq which-key-prefix-prefix "+")
    (which-key-mode)
    :diminish which-key-mode
    :config
    (setq which-key-idle-delay 1))


;;Theme
;;(use-package doom-themes
;;    :ensure t
;;    :config
;;    ;; Global settings (defaults)
;;    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;	doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;    (load-theme 'doom-miramare t)
;;
;;    ;;Enable flashing mode-line on errors
;;    (doom-themes-visual-bell-config)
;;    ;;Corrects (and improves) org-mode's native fontification.
;;    (doom-themes-org-config))


(use-package gruvbox-theme 
    :ensure t
    :config
    (load-theme 'gruvbox t))



(use-package all-the-icons)

(use-package dtrt-indent)
(setq dtrt-indent-original-indent 0)

(use-package doom-modeline
    :init (doom-modeline-mode 1)
    :custom ((doom-modeline-height -5)))

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon  nil)
(setq frame-title-format "emacs")

;;Line spacing
(setq-default line-spacing 6)


;;UX
(use-package counsel
    :bind ("C-x b" . 'counsel-switch-buffer)
    :custom
    (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
    :config
    (counsel-mode 1))

;;Fuzzy completion
(use-package helm
    :ensure t
    :init
    (setq helm-mode-fuzzy-match t)
    (setq helm-completion-in-region-fuzzy-match t)
    (setq helm-candidate-number-list 50))


;;Improve emacs defaut help buffers
(use-package helpful
    :custom
    (counsel-describe-function-function #'helpful-callable)
    (counsel-describe-variable-function #'helpful-variable)
    :bind
    ([remap describe-function] . counsel-describe-function)
    ([remap describe-command]  . helpful-command)
    ([remap describe-variable] . counsel-describe-variable)
    ([remap describe-key]      . helpful-key))


;;Python development
(use-package elpy
    :ensure t
    :init
    (elpy-enable))


;;Git
(use-package magit
  :config
  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

(use-package magit-popup)


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;org mode;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;

(require 'org)

;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)

;; Overwrite selected text
(delete-selection-mode t)

;; Scroll to the first and last line of the buffer
(setq scroll-error-top-bottom t)


;; Todo keywords.Change these to your liking
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE" "CANCELED")))

;;Todo faces
(setq org-todo-keyword-faces
 '(("IN-PROGRESS" . "orange") ("WAITING" . "magenta") ("CANCELED" . "red") ("DONE" . "green") ("TODO" . "yellow"))
 )

;;Org tags
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("@university" . ?u) ("@others" . ?o)))


;; Org-Mode initial setup
(use-package org
    :bind
    (("C-c l" . org-store-link)
     ("C-c a" . org-agenda)
     ("C-c c" . org-capture)))


;; Spell checking
;; Requires Hunspell
(use-package flyspell
    :config
    (setq ispell-program-name "hunspell"
          ispell-default-dictionary "en_US")
    :hook (text-mode . flyspell-mode)
    :bind (("M-<f7>" . flyspell-buffer)
           ("<f7>" . flyspell-word)
           ("C-;" . flyspell-auto-correct-previous-word)))

;;Improve org mode looks
(setq org-startup-indented t
    org-pretty-entities t
    org-hide-emphasis-markers t
    org-startup-with-inline-images t
    org-image-actual-width '(300))


; Show hidden emphasis markers
(use-package org-appear
    :hook (org-mode . org-appear-mode))


;;Nice bullets
(use-package org-superstar
    :config
    (setq org-superstar-special-todo-items t)
    (add-hook 'org-mode-hook (lambda ()
    (org-superstar-mode 1))))


;;Distraction-free screen
(use-package olivetti
    :init
    (setq olivetti-body-width .67)
    :config
    (defun distraction-free ()
	"Distraction-free writing environment"
	(interactive)
	(if (equal olivetti-mode nil)
	    (progn
		(window-configuration-to-register 1)
		(delete-other-windows)
		(text-scale-increase 2)
		(olivetti-mode t))
	    (progn
		(jump-to-register 1)
		(olivetti-mode 0)
		(text-scale-decrease 2))))
    :bind
    (("<f9>" . distraction-free)))

(set-cursor-color "OrangeRed1")
(blink-cursor-mode 0)
