;;; package --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'base)
(require 'base-theme)
(require 'base-extensions)
(require 'base-functions)
(require 'base-global-keys)

(require 'lang-python)

(require 'lang-go)

(require 'lang-haskell)

(require 'lang-c)

;; CUSTOOM CONFIG

;; no startup msg
(setq inhibit-startup-message t)

;; Avoid open new buffers while open dirs
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

;;Return nill if buffer is not sutable for switch
(defun pc-bufsw::can-work-buffer (buffer)
  (let ((name (buffer-name buffer)))
    (and (not (char-equal ?\  (aref name 0))) (not (string= name "*Messages*"))) ))

;; show trailing whitespaces
(setq show-trailing-whitespace t)

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; avoid annoying override global keys
(eval-after-load "elpy"
  '(cl-dolist (key '("C-<left>" "C-<right>"))
     (define-key elpy-mode-map (kbd key) nil)))
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)
(setq neo-show-auto-change-root t)
(setq neotree-show t)


(desktop-save-mode 1)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package powerline)
(powerline-default-theme)
(require 'tabbar-tweak)

 (defun my-tabbar-buffer-groups () ;; customize to show all normal files in one group

   "Returns the name of the tab group names the current buffer belongs to.
 There are two groups: Emacs buffers (those whose name starts with '*', plus
 dired buffers), and the rest.  This works at least with Emacs v24.2 using
 tabbar.el v1.7."
   (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
               ((eq major-mode 'dired-mode) "emacs")
               (t "user"))))
 (setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)

 (global-set-key [C-left] 'tabbar-backward-tab)
 (global-set-key [C-right] 'tabbar-forward-tab)

;(setq ispell-dictionary "en_US")

;(require 'flyspell-correct-ivy)

(use-package shell-pop)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(shell-pop-default-directory "/Users/kyagi/git")
 '(shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (eshell shell-pop-term-shell)))))
 '(shell-pop-term-shell "/bin/bash")
 '(shell-pop-universal-key "C-t")
 '(shell-pop-window-size 40)
 '(shell-pop-full-span t)
 '(shell-pop-window-position "bottom"))

;; Configure Orgmode
(use-package org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; some custom changes
(defun volatile-kill-buffer ()
  "Kill current buffer unconditionally."
  (interactive)
  (let ((buffer-modified-p nil))
    (kill-buffer (current-buffer))))

;; No tabs thanks
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(global-set-key (kbd "C-x k") 'volatile-kill-buffer)

;; copy/paste/undo/redo...
(cua-mode 1)
(global-set-key (kbd "C-y") 'redo)
(global-set-key (kbd "C-z") 'undo)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;;drag-stuff
(use-package drag-stuff)
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)

;; theme

(load-theme 'monokai-pro t)


;; highligths
(setq-default show-trailing-whitespace t)
(global-hl-line-mode 1)
(set-face-background 'hl-line "color-60")
