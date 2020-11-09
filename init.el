;; Package --- Summary
;;; Commentary:
;;Graeme Emacs config V05
;; Multi frame colour scheme
;;; Code:
(setq default-frame-alist
			(append default-frame-alist
							'((width . 105)
								(height . 50)
								(background-color . "black")
								(foreground-color . "#42c2f4")
								(cursor-color . "purple")
								)
							)
			)

;; Setup the font.
(set-face-attribute 'default nil :font "Hack" :height 64)


;; set the custom global colours
(set-face-foreground 'font-lock-doc-face "#808080")
(set-face-foreground 'font-lock-comment-face "#808080")
(set-face-foreground 'font-lock-string-face "#AA00AA")
(set-face-foreground 'font-lock-function-name-face "#FFFF00")
(set-face-foreground 'font-lock-variable-name-face "#00FF00")
(set-face-foreground 'font-lock-keyword-face "#2222FF")


;; setup useful modes
(show-paren-mode)


;; (tabkey2-mode)
(delete-selection-mode t)


;; save the session
(desktop-save-mode 1)


;;Setup the backup directory
(setq backup-directory-alist
			'((".*"."~/.emacs.d/saves")))
(setq backup-by-copying t)
;; (setq auto-save-file-name-transforms '((".*"."~/.emacs.d/temp" t)))


;; don't display scroll bars or toolbar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)


;;Org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook (lambda() (setq fill-column 100)))
(setq org-enforce-todo-dependencies t)
(setq org-todo-keywords
			'((sequence "TODO" "IN PROGRESS" "ON HOLD" "BLOCKED" "|" "DONE")))
(setq org-todo-keyword-faces
			'(("TODO" . "blue")
				("IN PROGRESS" . "yellow")
				("ON HOLD" . "cyan")
				("BLOCKED" . "red")
				("DONE" . "green")
				("DROPPED" . "dark red")))
(setq org-log-done t)


;; latex mode
(add-hook 'tex-mode-hook 'turn-on-auto-fill)
(add-hook 'tex-mode-hook (lambda() (setq fill-column 100)))


;; Highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3F1F1F")


;; ;shut up the bloody beep
(setq visible-bell 1)


;; c++-mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;; setup line displayppp
(global-display-line-numbers-mode)
(toggle-truncate-lines)


;; Mode Line
(line-number-mode)
(column-number-mode)
(display-time-mode)
(size-indication-mode)


;; display a line at column 80
(add-to-list 'load-path "~/.emacs.d/modes/fci/")
(require 'fill-column-indicator)
(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "red")
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)


;; set whitespace mode on
(setq whitespace-line 0)
(setq-default whitespace-indentation nil)
(setq-default whitespace-space nil)
(whitespace-mode 0)


;; set tabs to 2
(setq c-basic-offset 2)
(setq-default indent-tabs-mode 1)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)


;; handle indenting
(setq c-default-style "bsd")


;; indent case statments
;; (add-hook 'c-mode-common-hook
;;					 (lambda ()
;;						 (c-set-offset 'case-label +)))
(c-set-offset 'case-label '+)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
;; maximise the window
;; (w32-send-sys-command 6p1488)


;; Additional functions...
(defun my-multi-occur-in-matching-buffers (regexp &optional allbufs)
	"Show all lines matching REGEXP in all buffers (ALLBUFS)."
	(interactive (occur-read-primary-args))
	(multi-occur-in-matching-buffers ".*" regexp))
(global-set-key (kbd "M-s") 'my-multi-occur-in-matching-buffers)


;; Additional key bindings
(global-set-key (kbd "C-x /") 'comment-or-uncomment-region)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Rebind C-x C-c
(global-unset-key [(control x)(control c)])
(global-set-key (kbd "C-x C-c") 'kill-emacs)

;; Disable C-z
(global-unset-key [(control z)])
(global-unset-key[(control x)(control z)])


;; Disable M-.
(global-unset-key [(alt .)])


;; Auto update buffers
(global-auto-revert-mode t)


;; Set frame alpha
(set-frame-parameter (selected-frame) 'alpha '(93 83))
(add-to-list 'default-frame-alist '(alpha 93 83))


;; package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)


;; Package manager
(server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 '("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default))
 '(irony-cdb-search-directory-list '("." "build" "/home/v1gtinsd/Projects/tools/AutoDoc/include/" "/home/v1gtinsd/Projects/YATTE/" "/home/v1gtinsd/Projects/gTed/include"))
 '(line-spacing 0.0)
 '(package-selected-packages
	 '(company-irony company-irony-c-headers flycheck-irony irony magit projectile python-docstring company-go go-mode highlight-indent-guides jedi company-jedi dockerfile-mode cmake-mode neotree yaml-mode jinja2-mode web-mode company flycheck yasnippet yasnippet-snippets undo-tree ivy org php-mode highlight-indent-guides-mode)))


;; python settings
(add-hook 'python-mode-hook
		(lambda ()
			(setq python-indent 4)
			(setq tab-width 4)
			(setq indent-tabs-mode nil)
			(add-to-list 'write-file-functions
									 'delete-trailing-whitespace
									 'hs-minor-mode)
			)
		)

;; web-mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.phpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


;; Company
(add-hook 'after-init-hook 'global-company-mode)
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 2)
(with-eval-after-load 'company
	(add-to-list 'company-backends 'company-jedi)

	(define-key company-active-map (kbd "C-n") 'company-select-next)
	(define-key company-active-map (kbd "C-p") 'company-select-previous)
	(define-key company-search-map (kbd "C-n") 'company-select-next)
	(define-key company-search-map (kbd "C-p") 'company-select-previous)

	(define-key company-active-map [tab] 'company-complete-selection)
	(define-key company-active-map (kbd "TAB") 'company-complete-selection)

	(define-key company-active-map [esc] 'company-abort)
	(define-key company-active-map (kbd "ESC") 'company-abort)
	)


;; Projectile
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-project-search-path '("~/Projects/"))

;; Irony
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(setq irony-additional-clang-options '("-std=c11"
																			 "-I/home/v1gtinsd/Projects/YATTE/include"))

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)


;; Company-Irony && company irony c headers
(eval-after-load 'company
		'(add-to-list 'company-backends 'company-irony))

(eval-after-load 'company
		'(add-to-list 'company-backends 'company-irony-c-headers))

;; flycheck mode
(eval-after-load 'flycheck
	'(add-hook 'c-mode-hook
						 (lambda() (setq flycheck-clang-include-path
														 (list(expand-file-name "~/Projects/tools/AutoDoc/include"
																										"~/Projects/YATTE"
																										"~/Projects/gTed/include"))))))
(add-hook 'after-init-hook #'global-flycheck-mode)

;; flycheck-irony
(eval-after-load 'flycheck
		'(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; ivy
(require 'ivy)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d)")
(ivy-mode 1)


;; neotree
(setq new-smart-open t)
(define-key global-map (kbd"C-t") 'neotree-toggle)


;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)


;; iEdit
(define-key global-map (kbd "C-x ;") 'iedit-mode)


;; indent highlighting
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'fill)


;; nyan
(nyan-mode 1)


;; undo tree
(global-undo-tree-mode)

;;; init.el ends here
(put 'dired-find-alternate-file 'disabled nil)
