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
    (ace-jump-mode helm which-key general ivy evil peacock-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

(use-package evil)
(evil-mode 1)

(use-package ivy)
(ivy-mode 1)

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
 "f" 'find-file)

;; bind a key in multiple states
(general-define-key :keymaps 'org-mode-map
                    :states '(insert emacs)
                    "<tab>" 'org-cycle)

(general-evil-setup)
;; all keywords arguments are still supported
(general-nmap :prefix "SPC"
  "p" 'helm-mini
  "w" 'ace-jump-word-mode
  "c" 'ace-jump-char-mode
  "l" 'ace-jump-line-mode
  "SPC" 'execute-extended-command)

;; bind in motion state (inherited by the normal, visual, and operator states)
(general-mmap "j" 'evil-next-visual-line
              "k" 'evil-previous-visual-line)

;; alternatively, for shorter names
(general-evil-setup t)
(mmap "j" 'evil-next-visual-line
      "k" 'evil-previous-visual-line)

(use-package which-key)
(which-key-mode 1)

(use-package helm)

(use-package ace-jump-mode)
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
