;;; Package --- Summary
;;; Commentary:
;;Graeme Emacs config V05
;; Multi frame colour scheme
;;; Code:
(setq default-frame-alist
      (append default-frame-alist
              '((width . 105)
                (height . 50)
                (background-color . "black")
                (foreground-color . "#0088FF")
                (cursor-color . "purple")
                                        ;(font . "ProggyTinyTT-12")
                )
              )
      )

(set-face-attribute 'default nil :font "ProggyTinyTT" :height 110)


;;Colour Scheme
;; (set-background-color "black")
;; (set-foreground-color "#00CCFF")
;; (set-foreground-color "#00FF00")
;; (set-cursor-color "purple")


;; Highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3F1F1F")


;; ;shut up the bloody beep
(setq visible-bell 1)


;; setup line display
(require 'linum)
(global-linum-mode)
(column-number-mode)
(toggle-truncate-lines)


;; display a line at column 80
(add-to-list 'load-path "~/.emacs.d/modes/fci/")
(require 'fill-column-indicator)
(setq fci-rule-column 80)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)


;; set whitespace mode on
(setq whitespace-line 0)
(setq-default whitespace-indentation nil)
(setq-default whitespace-space nil)
(whitespace-mode 1)


;; set tabs to 2
;; (setq c-basic-offset 2)
;; (setq-default indent-tabs-mode 0)
;; (setq-default tab-width 4)
;; (setq indent-line-function 'insert-tab)
(setq-default indent-tabs-mode nil)


;; handle indenting
(setq c-default-style "bsd")


;; indent case statments
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-offset 'case-label +)))
(c-set-offset 'case-label '+)


;; python settings
(add-hook 'python-mode-hook
          (lambda ()
            (add-to-list 'write-file-functions 'delete-trailing-whitespace)))


;; setup useful modes
(show-paren-mode)


;; (tabkey2-mode)
(delete-selection-mode t)


;; save the session
(desktop-save-mode 1)


;; don't display scroll bars or toolbar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)


;; set the comment colour
(set-face-foreground 'font-lock-comment-face "#505050")


;; maximise the window
;; (w32-send-sys-command 61488)


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


;; Disable C-z
(global-unset-key [(control z)])
(global-unset-key[(control x)(control z)])


;; Disable M-.
(global-unset-key [(alt .)])


;; Auto update buffers
(global-auto-revert-mode t)


;; Set frame alpha
(set-frame-parameter (selected-frame) 'alpha '(83 78))
(add-to-list 'default-frame-alist '(alpha 83 78))


;; package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)


;; auto-complete mode
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)


;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)


;; auto complete headers
(defun my:ac-c-header-init()
	(require 'auto-complete-c-headers)
	(add-to-list 'ac-sources 'ac-source-c-headers)
	(add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu/c++/5")
	(add-to-list 'achead:include-directories '"/usr/include"))
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)


;; iEdit
(define-key global-map (kbd "C-x ;") 'iedit-mode)


;; Package manager
(server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck-pony
     pony-mode
     pony-snippets
     ponylang-mode
     flycheck-yamllint
     flymake-yaml
     yaml-mode
     excorporate
     flycheck
     highlight-indent-guides-mode
     highlight-indent-guides
     projectile
     projectile-codesearch
     neotree
     web-mode
     slack
     lua-mode
     libmpdee
     iedit
     dts-mode
     auto-complete-c-headers
     auto-complete-auctex))))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.phpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


;; neotree
(setq new-smart-open t)
(define-key global-map (kbd"C-t") 'neotree-toggle)


;; indent highlighting
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


;; flycheck mode
(add-hook 'after-init-hook #'global-flycheck-mode)
;;; init.el ends here
