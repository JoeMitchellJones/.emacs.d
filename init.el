(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("e4859645a914c748b966a1fe53244ff9e043e00f21c5989c4a664d649838f6a3" default)))
 '(package-selected-packages
   (quote
    (lorem-ipsum company evil-magit zoom magit ace-jump-mode helm which-key general ivy evil peacock-theme)))
 '(zoom-mode t nil (zoom)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq backup-directory-alist '(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

 ;; --------------------------------------------------------------------------------------

(global-linum-mode 1)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(load-theme 'peacock)

(ido-mode 1)
(setq ido-enable-flex-matching t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-d-scroll t)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  ;; snip...
)

(use-package which-key)
(which-key-mode 1)

(use-package helm)

(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

(use-package ace-jump-mode)
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(use-package zoom)

(use-package evil-magit)

(use-package ivy)
(ivy-mode 1)

(use-package lorem-ipsum)

(use-package ace-window)

(use-package magit)

(use-package powerline)
(use-package powerline-evil)
(powerline-evil-center-color-theme)

(defun find-user-init-file ()
  "Edit config in another window"
  (interactive)
  (find-file-other-window user-init-file))

(use-package general)
;; bind j and k in normal state globally
(general-define-key
 :keymaps 'normal
 "j" 'evil-next-visual-line
 "k" 'evil-previous-visual-line)

;; bind gj and gk
(general-define-key
 :prefix "g"
 :keymaps 'normal
 "j" 'evil-next-line
 "k" 'evil-previous-line)

;; named prefix key
(setq my-leader1 ",")
(general-define-key
 :prefix my-leader1
 :keymaps 'normal
 "mg" 'magit-status
 "mh" 'magit-dispatch-popup
 "d" 'dired
 "c" 'find-user-init-file
 "f" 'find-file
 "s" 'save-buffer)

;; bind a key in multiple states
(general-define-key :keymaps 'org-mode-map
                    :states '(insert emacs)
                    "<tab>" 'org-cycle)

(general-evil-setup)
;; all keywords arguments are still supported
(general-nmap :prefix "SPC"
  "1" 'delete-other-windows
  "0" 'delete-window
  "/" 'split-window-right
  "y" 'clipboard-kill-region
  "p" 'clipboard-yank
  "W" 'ace-window
  "b" 'ivy-switch-buffer
  "P" 'helm-mini
  "w" 'ace-jump-word-mode
  "c" 'ace-jump-char-mode
  "l" 'ace-jump-line-mode
  "L" 'lorem-ipsum-insert-paragraphs
  "B" 'eval-buffer
  "SPC" 'execute-extended-command)

;; bind in motion state (inherited by the normal, visual, and operator states)
(general-mmap "j" 'evil-next-visual-line
              "k" 'evil-previous-visual-line)

;; alternatively, for shorter names
(general-evil-setup t)
(mmap "j" 'evil-next-visual-line
      "k" 'evil-previous-visual-line)



 (set-frame-parameter (selected-frame) 'alpha '(98 . 80))
 (add-to-list 'default-frame-alist '(alpha . (98 . 80)))
