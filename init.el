
;; path
;; (setq root-dir (expand-file-name "~/.emacs.d"))
;; (add-to-list 'load-path root-dir)
;; (add-to-list 'load-path (concat root-dir "/misc"))

(cua-mode)
(show-paren-mode)
(column-number-mode)
(global-set-key (kbd "C-t") 'delete-trailing-whitespace)

;; fixing xterm bug
(define-key input-decode-map "\e[1;2A" [S-up])


(setq x-select-enable-clipboard t)

(set-input-method 'TeX)
(toggle-input-method)


;; Packages
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;; (setq tramp-default-method "ssh")


;; Programming shortcuts
;; (global-set-key (kbd "C-/") 'comment-region)


;; Julia
(load (expand-file-name "~/.emacs.d/ESS/lisp/ess-site"))
(setq inferior-julia-program-name "julia")
(add-hook 'julia-mode-hook
      '(lambda ()
         (local-set-key (kbd "C-d") 'ess-eval-line-and-step)
         (local-set-key (kbd "C-c C-c") 'ess-load-file)))


;; Python (epy)
(elpy-enable)
;; (elpy-use-ipython)
(setq elpy-rpc-python-command "python3")
(setq python-shell-interpreter "python3")
(setq elpy-rpc-backend "rope")

(add-hook 'python-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "C-d") 'elpy-shell-send-current-statement)))


(defvar my-python-shell-dir-setup-code
  "import os
home = os.path.expanduser('~')
while os.path.exists('__init__.py') and os.getcwd() != home:
    os.chdir('..')
del os")

(defun my-python-shell-dir-setup ()
  (let ((process (get-buffer-process (current-buffer))))
    (python-shell-send-string my-python-shell-dir-setup-code)
    (message "Setup project path")))

(add-hook 'inferior-python-mode-hook 'my-python-shell-dir-setup)


;; Clojure mode (cider)
;; (add-hook 'cider-mode-hook
;; 	  '(lambda ()
;; 	     (local-set-key (kbd "C-d") 'cider-eval-defun-at-point)
;; 	     (local-set-key (kbd "C-c C-c") 'cider-load-buffer)))


;; ;; Clojure: nrepl
;; (when (not (package-installed-p 'nrepl))
;;   (package-install 'nrepl))

;; ;; Clojure: key bindings
;; (add-hook 'clojure-mode-hook
;; 	  '(lambda () (local-set-key "\C-d" 'nrepl-eval-expression-at-point)))


;; Python
;; NOTE: this section contains a number of useful setting for all modes,
;; not only python mode!
;; (add-to-list 'load-path "~/.emacs.d/emacs-for-python/")
;; (require 'epy-setup)      ;; It will setup other loads, it is required!
;; (require 'epy-python)     ;; If you want the python facilities [optional]
;; (require 'epy-completion) ;; If you want the autocompletion settings [optional]
;; (require 'epy-editing)    ;; For configurations related to editing [optional]
;; (require 'epy-bindings)   ;; For my suggested keybindings [optional]
;; (require 'epy-nose)       ;; For nose integration
;; ;; (epy-setup-ipython)
;; (setq skeleton-pair nil)
;; ;; (ansi-color-for-comint-mode-on)
;; (setq python-shell-interpreter "ipython3"
;;       python-shell-interpreter-args "--simple-prompt -i")


;; (defun trim-string (string)
;;   (replace-regexp-in-string "\\`[ \t\n]*" ""
;;                             (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

;; (defun python-shell-send-line ()
;;   (interactive)
;;   (python-shell-send-string (trim-string (thing-at-point 'line)) nil t)
;;   (next-line))


;; (add-hook 'python-mode-hook
;; 	  '(lambda ()
;; 	     (local-set-key (kbd "C-d") 'python-shell-send-line)
;; 	     (local-set-key (kbd "C-c C-k") 'python-shell-send-buffer)
;; 	     (local-set-key (kbd "C-c !") 'run-python)
;; 	     (pretty-lambda-mode)
;; 	     (jedi:setup)
;; 	     (setq jedi:setup-keys t)
;; 	     (setq jedi:complete-on-dot t)))


;; (defvar my-python-shell-dir-setup-code
;;   "import os
;; home = os.path.expanduser('~')
;; while os.path.exists('__init__.py') and os.getcwd() != home:
;;     os.chdir('..')
;; del os")

;; (defun my-python-shell-dir-setup ()
;;   (let ((process (get-buffer-process (current-buffer))))
;;     (python-shell-send-string my-python-shell-dir-setup-code process)
;;     (message "Setup project path")))

;; (add-hook 'inferior-python-mode-hook 'my-python-shell-dir-setup)


;; Scala
;; (unless (package-installed-p 'scala-mode2)
;;   (package-refresh-contents) (package-install 'scala-mode2))


;; Go
;; (add-hook 'go-mode-hook
;; 	  (lambda ()
;; 	    (auto-complete-mode)
;; 	    (add-hook 'before-save-hook 'gofmt-before-save)
;; 	    (if (not (string-match "go" compile-command))
;; 		(set (make-local-variable 'compile-command)
;; 		     "go build -v && go test -v && go vet && go install"))
;; 	    (local-set-key (kbd "C-c C-c") 'compile)
;; 	    (local-set-key (kbd "M-.") 'godef-jump)))



;; Ruby
;; (add-to-list 'load-path "~/.emacs.d/ruby")
;; (autoload 'ruby-mode "ruby-mode"
;;   "Mode for editing ruby source files")
;; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;; (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
;; (autoload 'run-ruby "inf-ruby"
;;   "Run an inferior Ruby process")
;; (autoload 'inf-ruby-keys "inf-ruby"
;;   "Set local key defs for inf-ruby in ruby-mode")
;; (add-hook 'ruby-mode-hook
;; 	  '(lambda ()
;; 	     (inf-ruby-keys)
;; 	     (local-set-key "\C-d" 'ruby-send-definition)))
;; (add-hook 'ruby-mode-hook 'turn-on-font-lock)


;; Octave
;; (autoload 'octave-mode "octave-mod" nil t)
;; (setq auto-mode-alist
;;       (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; (add-hook 'octave-mode-hook
;; 	  (lambda ()
;; 	    (abbrev-mode 1)
;; 	    (auto-fill-mode 1)
;; 	    (if (eq window-system 'x)
;; 		(font-lock-mode 1))))

;; (add-hook 'octave-mode-hook
;;           (lambda ()
;;             (local-set-key "\C-d" 'octave-send-block)
;; 	    (local-set-key "\C-f" 'octave-send-defun)
;; 	    (local-set-key "\C-j" 'octave-send-line)))


;; R
;; (add-to-list 'auto-mode-alist '("\\.r$" . R-mode))
;; (add-to-list 'auto-mode-alist '("\\.R$" . R-mode))


;; Haskell
;; (add-hook 'haskell-mode-hook
;; 	  (lambda ()
;; 	    (local-set-key "\C-d" 'inferior-haskell-send-decl)
;;  	    (local-set-key (kbd "C-c C-c") 'inferior-haskell-load-file)
;; 	    (turn-on-haskell-indentation)))


;; PHP
;; (add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
;; (add-hook 'php-mode-hook
;;           (lambda ()
;; 	    (setq tab-width 4) ; or any other preferred value
;; 	    (defvaralias 'c-basic-offset 'tab-width)
;; 	    (defvaralias 'cperl-indent-level 'tab-width)))


;; XML
(setq nxml-child-indent 8)


(load (expand-file-name "~/.emacs.d/fireplace/fireplace"))

;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(font-lock-comment-face ((t (:foreground "magenta"))))
;;  '(font-lock-comment-delimiter-face ((t (:foreground "magenta")))))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(font-lock-comment-delimiter-face ((t (:foreground "yellow"))))
;;  '(font-lock-comment-face ((t (:foreground "yellow"))))
;;  '(font-lock-constant-face ((t (:foreground "cyan")))))


;; don't autocomplete unless completion menu is shown
;; (define-key ac-completing-map "\C-m" nil)
;; (setq ac-use-menu-map t)
;; (define-key ac-menu-map "\C-m" 'ac-complete)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("0aa12caf6127772c1a38f7966de8258e7a0651fb6f7220d0bbb3a0232fba967f" "fc0c179ce77997ecb6a7833310587131f319006ef2f630c5a1fec1a9307bff45" "870a63a25a2756074e53e5ee28f3f890332ddc21f9e87d583c5387285e882099" "55d31108a7dc4a268a1432cd60a7558824223684afecefa6fae327212c40f8d3" default)))
 '(fci-rule-color "#3a3a3a")
 '(hl-sexp-background-color "#121212")
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
