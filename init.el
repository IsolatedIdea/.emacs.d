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
                (foreground-color . "#5585fc")
                (cursor-color . "purple")
                                        ;(font . "ProggyTinyTT-12")
                )
              )
      )

;; (set-face-attribute 'default nil :font "ProggyTinyTT" :height 110)
(set-face-attribute 'default nil :font "Hack" :height 70)

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


;; set the custom global colours
(set-face-foreground 'font-lock-comment-face "#505050")
(set-face-foreground 'font-lock-string-face "#888800")
(set-face-foreground 'font-lock-function-name-face "#00bf13")
(set-face-foreground 'font-lock-variable-name-face "#00a359")
;; (set-face-foreground 'font-lock-variable-name-face "#FF0000")
(set-face-foreground 'font-lock-keyword-face "#df00ff")


;; Set frame alpha
(set-frame-parameter (selected-frame) 'alpha '(100 100))
(add-to-list 'default-frame-alist '(alpha 100 100))


;; Auto update buffers
(global-auto-revert-mode t)


;; Highlight current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3F1F1F")


;; ;shut up the bloody beep
(setq visible-bell 1)


;; setup line display
(require 'linum)
(global-linum-mode)
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


;; set tabs to 2
(setq c-basic-offset 2)
(setq-default indent-tabs-mode 0)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

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
            (add-to-list 'write-file-functions 'delete-trailing-whitespace)
            (indent-tabs-mode nil)))


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


;; package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;; Package manager
(server-start)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.phpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-tree-sitter-mode))
(add-to-list 'auto-mode-alist '("\\.xaml\\'" . xml-mode))


;; flycheck mode
;; (add-hook 'after-init-hook #'global-flycheck-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-clients-clangd-executable "D:\\compilers\\clangd_13.0.0\\bin\\clangd")
 '(package-selected-packages
	 '(py-autopep8 elpy company-jedi jedi jedi-core flycheck lsp-mode undo-tree highlight-indent-guides use-package nyan-mode ivy csharp-mode company)))

;; use-packeage
(require 'use-package)


(require 'lsp-mode)
(add-hook 'prog-mode-hook #'lsp)


;; indent highlighting
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


;; Company mode
(use-package company
						 :ensure t
						 :config
						 (setq company-idle-delay 0)
						 (setq company-dabbrev-downcase 0)
						 (setq company-minimum-prefix-length 1))

(with-eval-after-load 'company
	(define-key company-active-map (kbd "C-n") #'company-select-next)
	(define-key company-active-map (kbd "C-p") #'company-select-previous))

(with-eval-after-load 'company
	(global-company-mode))


;; Undo-Tree
(global-undo-tree-mode)
(setq undo-tree-visuliser-diff 1)
(setq undo-tree-visuliser-timestamps t)
(setq undo-tree-auto-save-history t)

;; Ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

;; (setq omnisharp-server-executable-path "D:\\AppData\\Roaming\\.emacs.d\\Omnisharp-win-x86-server\\OmniSharp.exe")

;; Flycheck
;; (flycheck-mode 1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Nyan-mode
(nyan-mode t)

(setq org-todo-keywords
			'((sequence "TODO" "IN-PROGRESS" "ON-HOLD" "WAITING" "DONE")))


;; An attemt to use the windows compiler...

(defvar msbuild-old-path-var (getenv "PATH"))

(defun msbuild-2017-x86-setup ()
  "Set enviorment variables to load Microsoft Visual C++ Compiler (MSVC 32 bits)"
  (interactive)
  (message "Setting 32 bits MSVC building tools.")
  (setenv "PATH" msbuild-old-path-var)
  (setenv "INCLUDE"
        (concat
             "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/ATLMFC/include"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/include"
         ";" "c:/Program Files (x86)/Windows Kits/NETFXSDK/4.8/include/um"
         ";" "C:/Program Files (x86)/Windows Kits/10/include/10.0.16299.0/ucrt"
         ";" "C:/Program Files (x86)/Windows Kits/10/include/10.0.16299.0/shared"
         ";" "C:/Program Files (x86)/Windows Kits/10/include/10.0.16299.0/um"
         ";" "C:/Program Files (x86)/Windows Kits/10/include/10.0.16299.0/winrt"
         ))

  (setenv "LIB"
        (concat
             "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/ATLMFC/lib/x86"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/lib/x86"
         ";" "c:/Program Files (x86)/Windows Kits/NETFXSDK/4.8/Lib/um/x86"
         ";" "C:/Program Files (x86)/Windows Kits/10/lib/10.0.16299.0/ucrt/x86"
         ";" "C:/Program Files (x86)/Windows Kits/10/lib/10.0.16299.0/um/x86"
         ))

  (setenv  "LIBPATH"
         (concat
              "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/ATLMFC/lib/x86"
          ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/lib/x86"
          ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/lib/x86/store/references"
          ";" "C:/Program Files (x86)/Windows Kits/10/UnionMetadata/10.0.16299.0"
          ";" "C:/Program Files (x86)/Windows Kits/10/References/10.0.16299.0"
          ";" "C:/Windows/Microsoft.NET/Framework/v4.0.30319"
          ))

  (setenv "PATH"
        (concat
         (getenv "PATH")
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/bin/HostX86/x86"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/VC/VCPackages"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/CommonExtensions/Microsoft/TestWindow"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/CommonExtensions/Microsoft/TeamFoundation/Team Explorer"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/MSBuild/15.0/bin/Roslyn"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Team Tools/Performance Tools"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/Shared/Common/VSPerfCollectionTools/"
         ";" "C:/Program Files (x86)/Microsoft SDKs/Windows/v10.0A/bin/NETFX 4.6.1 Tools/"
         ";" "C:/Program Files (x86)/Microsoft SDKs/F#/4.1/Framework/v4.0/"
         ";" "C:/Program Files (x86)/Windows Kits/10/bin/x86"
         ";" "C:/Program Files (x86)/Windows Kits/10/bin/10.0.16299.0/x86"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community//MSBuild/15.0/bin"
         ";" "C:/Windows/Microsoft.NET/Framework/v4.0.30319"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/Tools/"
         )))

(defun msbuild-2017-x64-setup ()
  "Set enviorment variables to load Microsoft Visual C++ Compiler (MSVC) 64 bits"
  (interactive)
  (message "Setting 64 bits building tools.")
  (setenv "PATH" msbuild-old-path-var)
  (setenv "INCLUDE"
        (concat
             "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/ATLMFC/include"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/include"
         ";" "C:/Program Files (x86)/Windows Kits/NETFXSDK/4.8/include/um"
         ";" "C:/Program Files (x86)/Windows Kits/10/include/10.0.16299.0/ucrt"
         ";" "C:/Program Files (x86)/Windows Kits/10/include/10.0.16299.0/shared"
         ";" "C:/Program Files (x86)/Windows Kits/10/include/10.0.16299.0/um"
         ";" "C:/Program Files (x86)/Windows Kits/10/include/10.0.16299.0/winrt"
         ))

  (setenv "LIB"
        (concat
             "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/ATLMFC/lib/x64"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/lib/x64"
         ";" "C:/Program Files (x86)/Windows Kits/NETFXSDK/4.8/lib/um/x64"
         ";" "C:/Program Files (x86)/Windows Kits/10/lib/10.0.16299.0/ucrt/x64"
         ";" "C:/Program Files (x86)/Windows Kits/10/lib/10.0.16299.0/um/x64"
         ))

  (setenv  "LIBPATH"
         (concat
              "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/ATLMFC/lib/x64"
          ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/lib/x64"
          ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/lib/x64/store/references"
          ";" "C:/Program Files (x86)/Windows Kits/10/UnionMetadata/10.0.16299.0"
          ";" "C:/Program Files (x86)/Windows Kits/10/References/10.0.16299.0"
          ";" "C:/Windows/Microsoft.NET/Framework/v4.0.30319"
          ))

  (setenv "PATH"
        (concat
         (getenv "PATH")
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/bin/HostX86/x64"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/VC/VCPackages"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/CommonExtensions/Microsoft/TestWindow"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/CommonExtensions/Microsoft/TeamFoundation/Team Explorer"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/MSBuild/15.0/bin/Roslyn"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Team Tools/Performance Tools"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/Shared/Common/VSPerfCollectionTools/"
         ";" "C:/Program Files (x86)/Microsoft SDKs/Windows/v10.0A/bin/NETFX 4.6.1 Tools/"
         ";" "C:/Program Files (x86)/Microsoft SDKs/F#/4.1/Framework/v4.0/"
         ";" "C:/Program Files (x86)/Windows Kits/10/bin/x64"
         ";" "C:/Program Files (x86)/Windows Kits/10/bin/10.0.16299.0/x64"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community//MSBuild/15.0/bin"
         ";" "C:/Windows/Microsoft.NET/Framework/v4.0.30319"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/IDE/"
         ";" "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/Common7/Tools/"
         )))


(defun compile-msvc-x86()
  (interactive)
  (msbuild-2017-x86-setup)
  (let ((compile-command (format "cl.exe \"%s\""
                                 (file-name-nondirectory (buffer-file-name))))
        (compilation-ask-about-save nil))
    (call-interactively #'compile )))

(defun compile-msvc-x64 ()
  (interactive)
  (msbuild-2017-x64-setup)
  (let ((compile-command (format "cl.exe \"%s\""
                                 (file-name-nondirectory (buffer-file-name))))
        (compilation-ask-about-save nil))
    (call-interactively #'compile )))
;;; init.el ends here
