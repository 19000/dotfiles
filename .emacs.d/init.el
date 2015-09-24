(define-key input-decode-map "\e[1;10A" [S-M-up])
(define-key input-decode-map "\e[1;10B" [S-M-down])
(define-key input-decode-map "\e[1;10C" [S-M-right])
(define-key input-decode-map "\e[1;10D" [S-M-left])

(defalias 'qrr 'query-replace-regexp)

;(load "/Users/durrrr/Downloads/unbound.el")

(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)

;; Hook
(defun my-disable-electric-indentation ()
  "Stop ';', '}', etc, from re-indenting the current line."
  (c-toggle-electric-state -1))

(add-hook 'c-mode-common-hook
          (lambda () (c-toggle-electric-state -1)))

;;; Binding Keys
;; (defun my-tab-width ()
;;   "Cycle tab-width between values 2, 4, and 8."
;;   (interactive)
;;   (setq tab-width
;;         (cond ((eq tab-width 8) 2)
;;               ((eq tab-width 2) 4)
;;               (t 8)))
;;   (redraw-display))
;; (global-set-key (kbd "C-c t") 'my-tab-width)

;; ido-mode on
(ido-mode)

;; menu bar mode off
(menu-bar-mode -1)

;; Highlight parentheses pair
(show-paren-mode 1)
(setq show-paren-delay 0)

(eldoc-mode 1)                          ; Not work
                                        ; Need set for each buffer?
(define-key emacs-lisp-mode-map
  (kbd "M-.") 'find-function-at-point)

;; theme
;(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
;(require 'color-theme)

;; Not work in Emacs 24, it's for 23 before. See README in Solarized.
;(add-to-list 'load-path "~/.emacs.d/emacs-color-theme-solarized")
;(require 'color-theme-solarized)

;; This works.
;(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
;(load-theme 'solarized t)
;(set-frame-parameter nil 'background-mode 'light)
;(set-terminal-parameter nil 'background-mode 'light)
;(enable-theme 'solarized)

;; window managerment
(winner-mode 1)

(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "<f7>") 'other-window)
(global-set-key (kbd "<S-f7>") 'prev-window)
; (global-set-key "\C-o" 'other-window)

(defun prev-window ()
  (interactive)
  (other-window -1))
(global-set-key "\M-o" 'prev-window)

;;; Typed From Gary Video, There Seems Typo Errors...
;; ;; GRB: open temporary buffers in a dedicated window split
;; (setq special-display-regexps
;;       '("^\\*Completions\\*$"
;;         "^\\*Help\\*$"
;;         "^\\*Shell Command Output\\*$"
;;         "^\\*--------------------\\*$"
;;         ; and more ...
;;         ))
;; (setq grb-temporary-window (nth 2 (window-list)))
;; (defun grb-special-display (buffer &optional data)
;;   (let ((window grb-temporary-window))
;;     (with-selected-window window
;;       (switch-to-buffer buffer)
;;       window)))
;; (setq special-display-function #'grb-special-display)

;;; Python Run Shortcut
(defun my-run-python ()                 ; Gotcha: run-python is built-in ...
  (interactive) ; Why this is necessary?
  (save-buffer)
  (shell-command (format "python %s" (buffer-name))))

(defun shortcut-python-running ()
  ;;  (local-set-key (kbd "C-c r") '(lambda() (shell-command (format "python %s" (buffer-name))))))
  (local-set-key (kbd "C-c r") 'my-run-python))
(add-hook 'python-mode-hook 'shortcut-python-running)

;;; Mysql Run Shortcut
(defun my-run-mysql ()
  (interactive)
  (save-buffer)
  (shell-command (format "mysql -tTv -hlocalhost -uroot < %s" (buffer-name))))
(defun shortcut-mysql-running ()
  (local-set-key (kbd "C-c r") 'my-run-mysql))
(add-hook 'sql-mode-hook 'shortcut-mysql-running)

;;; Why this not work?
;; (eval-after-load "python-mode"
;;   '(define-key python-mode-map (kbd "C-c t") 'my-run-python))

;; (global-set-key (kbd "C-c k") 'my-run-python) ; Just test

(defun my-find-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
;; (global-set-key (kbd "C-c \\") 'my-find-file)
(global-set-key (kbd "C-c \\") (lambda ()
                                 (interactive)
                                 (find-file "~/.emacs.d/init.el")))

;;; Run Current File
;;; Ref: http://ergoemacs.org/emacs/elisp_run_current_file.html
(defun xah-run-current-file ()
    "Execute the current file.
For example, if the current buffer is the file x.py, then it'll call 「python x.py」 in a shell.
The file can be Emacs Lisp, PHP, Perl, Python, Ruby, JavaScript, Bash, Ocaml, Visual Basic, TeX, Java, Clojure.
File suffix is used to determine what program to run.

If the file is modified, ask if you want to save first.

URL `http://ergoemacs.org/emacs/elisp_run_current_file.html'
version 2015-08-23"
    (interactive)
    (let* (
           (ξsuffix-map
            ;; (‹extension› . ‹shell program name›)
            `(
              ("php" . "php")
              ("pl" . "perl")
              ("py" . "python")
              ("py3" . ,(if (string-equal system-type "windows-nt") "c:/Python32/python.exe" "python3"))
              ("rb" . "ruby")
              ("js" . "node") ; node.js
              ("sh" . "bash")
              ("clj" . "java -cp /home/xah/apps/clojure-1.6.0/clojure-1.6.0.jar clojure.main")
              ("ml" . "ocaml")
              ("vbs" . "cscript")
              ("tex" . "pdflatex")
              ("latex" . "pdflatex")
              ("java" . "javac")
              ;; ("pov" . "/usr/local/bin/povray +R2 +A0.1 +J1.2 +Am2 +Q9 +H480 +W640")
              ))
           (ξfname (buffer-file-name))
           (ξfSuffix (file-name-extension ξfname))
           (ξprog-name (cdr (assoc ξfSuffix ξsuffix-map)))
           (ξcmd-str (concat ξprog-name " \""   ξfname "\"")))

      (when (buffer-modified-p)
        (when (y-or-n-p "Buffer modified. Do you want to save first?")
          (save-buffer)))

      (cond
       ((string-equal ξfSuffix "el") (load ξfname))
       ((string-equal ξfSuffix "java")
        (progn
          (shell-command ξcmd-str "*xah-run-current-file output*" )
          (shell-command
           (format "java %s" (file-name-sans-extension (file-name-nondirectory ξfname))))))
       (t (if ξprog-name
              (progn
                (message "Running…")
                (shell-command ξcmd-str "*xah-run-current-file output*" ))
                      (message "No recognized program file suffix for this file."))))))

;;; Print Detailed Traceback For Debug
(setq debug-on-error t)

(setq inhibit-startup-message t)

;; (require 'mouse)
;; (xterm-mouse-mode t)
;; (defun track-mouse (e))

;; implement * like vim
;; (global-set-key (kbd "C-*") (lambda ()
;;                               (interactive)
;;                               (backward-word)
;;                               ()        ; ? get word under point
;;                               ))

;; This not work
(define-key isearch-mode-map (kbd "C-*")
  (lambda ()
    "Reset current isearch to a word-mode search of the word under point."
    (interactive)
    (setq isearch-word t
          isearch-string ""
          isearch-message "")
    (isearch-yank-string (word-at-point))))

;;; Plugin: yasnippet Snippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;;; Package Management
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/") t)
    (package-initialize))

;;; Plugin: NeoTree
(global-set-key [f8] 'neotree-toggle)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-feeds (quote ("https://news.ycombinator.com/rss"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; Plugin: Undo Tree
(global-undo-tree-mode)


;;; Plugin: Auto Completion Config
(ac-config-default)

;;; Jedi - Python auto-completion
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;;; System Clipboard: Copy, Paste and Cut
(defun pbcopy ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))
;;; This also works
;; (shell-command-on-region (region-beginning) (region-end) "pbcopy")

(defun pbpaste ()
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

(defun pbcut ()
  (interactive)
  (pbcopy)
  (delete-region (region-beginning) (region-end)))

(global-set-key (kbd "C-c c") 'pbcopy)
(global-set-key (kbd "C-c v") 'pbpaste)
;; (global-set-key (kbd "C-c x") 'pbcut)

;;; Window move
;;; ignore error
(defun ignore-error-wrapper (fn)
    "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
    (lexical-let ((fn fn))
      (lambda ()
        (interactive)
        (ignore-errors
          (funcall fn)))))

;; (global-set-key (kbd "<ESC> <left>") (ignore-error-wrapper 'windmove-left))
;; (global-set-key (kbd "<ESC> <right>") (ignore-error-wrapper 'windmove-right))
;; (global-set-key (kbd "<ESC> <up>") (ignore-error-wrapper 'windmove-up))
;; (global-set-key (kbd "<ESC> <down>") (ignore-error-wrapper 'windmove-down))


;;; Elscreen
(elscreen-start)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
      (if (region-active-p)
          (setq beg (region-beginning) end (region-end))
        (setq beg (line-beginning-position) end (line-end-position)))
      (comment-or-uncomment-region beg end)))
(global-set-key (kbd "M-;") 'comment-or-uncomment-region-or-line)


;;; Customize org-mode html export css
;;; Not work
;; (setq org-export-html-style-include-scripts nil
;;       org-export-html-style-include-default nil)
;; (setq org-export-html-style
;;       "<link rel=\"stylesheet\" type=\"text/css\" href=\"org-style.css\" />")
