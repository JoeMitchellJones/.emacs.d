 ;; MELPA install --- Adds MELPA to list of package repositories
(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-auto-complete t)
 '(custom-safe-themes
   (quote
    ("10e3d04d524c42b71496e6c2e770c8e18b153fcfcc838947094dad8e5aa02cef" "4b207752aa69c0b182c6c3b8e810bbf3afa429ff06f274c8ca52f8df7623eb60" "7c3a6181ad96ae8cbe2414d7a45c999e46230310a64ea9fa86c6e8c46f7257c3" "d2c61aa11872e2977a07969f92630a49e30975220a079cd39bec361b773b4eb3" "31e64af34ba56d5a3e85e4bebefe2fb8d9d431d4244c6e6d95369a643786a40e" "4a7abcca7cfa2ccdf4d7804f1162dd0353ce766b1277e8ee2ac7ee27bfbb408f" default)))
 '(eclim-eclipse-dirs (quote ("e:/eclipse")))
 '(eclim-executable "e:/eclipse/eclim.bat")
 '(package-selected-packages
   (quote
    (doom-themes sublimity-attractive sublimity-map sublimity-scroll org monokai-theme multi-web-mode php-ext php-mode company-emacs-eclim company gradle-mode eclim flycheck ace-jump-mode tabbar darkokai-theme lorem-ipsum))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(setq use-package-always-ensure t)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;;
;; ace jump mode major function
;; 
(add-to-list 'load-path
	     "c:/Users/Cthugha/AppData/Roaming/.emacs.d/elpa/ace-jump-mode-20140616.115/ace-jump-mode.el")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)



;; 
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(use-package doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-one t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'doom-peacock t)

(use-package lorem-ipsum)
(lorem-ipsum-use-default-bindings)


(add-hook 'conf-mode-hook
          (lambda ()
            (local-set-key (kbd "\C-c SPC") 'ace-jump-mode)))

(use-package company)
(global-company-mode t)

(eval-after-load 'php-mode
  '(require 'php-ext))

(use-package multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)

(use-package org)

(use-package sublimity)
 (require 'sublimity-scroll)
 (require 'sublimity-map) ;; experimental
 (require 'sublimity-attractive)

(setq sublimity-map-size 20)
(setq sublimity-map-fraction 0.3)
(setq sublimity-map-text-scale -7)
(add-hook 'sublimity-map-setup-hook
          (lambda ()
            (setq buffer-face-mode-face '(:family "Monospace"))
            (buffer-face-mode)))
(sublimity-map-set-delay nil)

(ido-mode 1)
(setq ido-seperator "\n")

(global-set-key (kbd "C-c C-l") 'linum-mode)

(set-face-foreground 'linum "#E9B000")
