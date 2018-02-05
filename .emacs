;(set gc-cons-threshold 100000000)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Some other customizations
;; (package-refresh-contents)
(defvar myPackages
  '(better-defaults
    ein ;; add the ein package (Emacs ipython notebook)
    elpy ;; add the elpy package
    flycheck ;; better syntax checking
    py-autopep8
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; Org-mode
;; -*- mode: elisp -*-
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
;; (require 'org)				
(setq load-path (cons "~/builds/org-mode/lisp" load-path))
(setq load-path (cons "~/builds/org-mode/contrib/lisp" load-path))
(require 'org-install)

;; Make Org mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b049d9678472e59466f69219061a975090485ab8c53c3944b133807279f587ab" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "c1390663960169cd92f58aad44ba3253227d8f715c026438303c09b9fb66cdfb" "0f90f1a9b666877d24d93d8c6330a5b68becdebe1cc55ef859799e84c6c4c08e" default)))
 '(org-agenda-files
   (quote
    ("~/Documents/Life/organizer.org" "~/2.org" "~/org-mode_tutorial")))
 '(package-selected-packages
   (quote
    (ggtags org-ref exec-path-from-shell elpy better-defaults material-theme twilight-bright-theme htmlize org2jekyll "org2jekyll" "org2jekyll" ox-twbs org-bullets magit magit-popup git-commit ghub))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; MAGit Setup
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; Init File
(global-set-key (kbd "C-c i") 
                (lambda () (interactive) (find-file "~/.emacs")))
;; Meta Key Setup
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; Set some keyboard shortcuts
(global-set-key (kbd "C-k") 'kill-whole-line)
(global-set-key (kbd "C-d") 'delete-backward-char)

;; Org-Mode Setup
(require 'ox-publish)
(require 'org-ref)
(global-set-key (kbd "C-c o") 
                (lambda () (interactive) (find-file "~/org/index.org")))
(global-set-key (kbd "C-c t") 
                (lambda () (interactive) (find-file "~/org/tasks.org")))
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/org/tasks.org")'
(setq org-indent-mode t)
(setq org-startup-indented t)
;; Publish
;; Setup
;; (setq org-publish-project-alist
;;       `(("org"
;;          :base-directory "~/org/"
;;          :recursive t
;;          :publishing-directory "/org/public_html"
;;          :publishing-function org-html-publish-to-html)))

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(load-theme 'tango-dark)
;(load-theme 'material t)
;(load-theme 'zenburn)
(load-theme 'mytango-dark)
(global-hl-line-mode +1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(global-linum-mode t)
(line-number-mode -1)
(toggle-frame-fullscreen)


;; Python
(elpy-enable)
(exec-path-from-shell-initialize)
;; (setq python-shell-interpreter "jupyter" 
      ;; python-shell-interpreter-args "console --simple-prompt")
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")
;(setenv "JUPYTER_CONSOLE_TEST" "1")
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Tabs!
(setq-default indent-tabs-mode nil)




;; C/C++
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)
