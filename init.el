;; desu
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

(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(compilation-message-face (quote default))
 '(custom-safe-themes
   (quote
    ("c3d4af771cbe0501d5a865656802788a9a0ff9cf10a7df704ec8b8ef69017c68" "e4859645a914c748b966a1fe53244ff9e043e00f21c5989c4a664d649838f6a3" default)))
 '(fci-rule-color "#3C3D37")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (exec-path-from-shell key-chord org-bullets monokai-theme powerline-evil powerline ace-window golden-ratio lorem-ipsum company evil-magit magit ace-jump-mode helm which-key general ivy evil peacock-theme)))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
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
(global-visual-line-mode 1)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

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

(use-package key-chord)
(setq key-chord-two-keys-delay 0.1)
(key-chord-define evil-insert-state-map "fd" 'evil-normal-state)
(key-chord-mode 1)

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

(use-package golden-ratio)
(golden-ratio-mode 1)
(setq golden-ratio-auto-scale t)

(use-package evil-magit)

(use-package ivy)
(ivy-mode 1)

(use-package lorem-ipsum)

(use-package ace-window)

(use-package magit)

(use-package powerline)
(use-package powerline-evil)
(powerline-evil-center-color-theme)

(use-package monokai-theme)
(load-theme 'monokai t)

(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

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
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"
			     "~/org/uni.org"
			     "~/org/home.org"))

(general-evil-setup)
;; all keywords arguments are still supported
(general-nmap :prefix "SPC"
  "1" 'delete-other-windows
  "0" 'delete-window
  "/" 'split-window-right
  "-" 'split-window-below
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
  "ol" 'org-store-link
  "oa" 'org-agenda
  "ot" 'org-todo
  "o RET" 'org-insert-todo-heading
  "oo" 'org-open-at-point
  "ol" 'org-store-link
  "oL" 'org-insert-link
  "oAT" 'org-todo-list
  "os" 'org-schedule
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

(global-set-key (kbd "C-<wheel-up>") 'text-scale-increase)
(global-set-key (kbd "C-<wheel-down>") 'text-scale-decrease)

(add-to-list 'golden-ratio-extra-commands 'ace-window)

(add-hook 'before-save-hook 'time-stamp)

(add-hook 'org-mode-hook 'turn-on-flyspell)
