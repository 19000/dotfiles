(define-key input-decode-map "\e[1;10A" [S-M-up])
(define-key input-decode-map "\e[1;10B" [S-M-down])
(define-key input-decode-map "\e[1;10C" [S-M-right])
(define-key input-decode-map "\e[1;10D" [S-M-left])

(define-key input-decode-map "\e[1;2D" [S-left])
(define-key input-decode-map "\e[1;2C" [S-right])
(define-key input-decode-map "\e[1;2B" [S-down])
(define-key input-decode-map "\e[1;2A" [S-up])

;; (define-key input-decode-map "\e[18;2~" [S-f7])

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
(setq ido-separator "\n")

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

;; (global-set-key (kbd "C-o") 'other-window)
;; (global-set-key (kbd "<f7>") 'other-window)
;; (global-set-key (kbd "<S-f7>") 'prev-window)

;; (global-set-key (kbd "<S-left>") 'windmove-left)
;; (global-set-key (kbd "<S-right>") 'windmove-right)
;; (global-set-key (kbd "<S-up>") 'windmove-up)
;; (global-set-key (kbd "<S-down>") 'windmove-down)

(defun my-other-frame ()
  (interactive)
  (other-frame 1))

;; ;XXX: This is code for emacs23, incompatible with 24
;; Error: Symbol's function definition is void: lexical-let
;; 
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

;;; TODO: Collect kbd
;;;     M-;
;;;     M-.
;;;     C-c c
;;;     C-c v
;;;     
;;; I use a minor mode for all my "override" key bindings
;;; http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs/5340797#5340797
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<S-left>") 'windmove-left)
    (define-key map (kbd "<S-right>") 'windmove-right)
    ;; (define-key map (kbd "<S-up>") (ignore-error-wrapper 'windmove-up))
    (define-key map (kbd "<S-up>") 'windmove-up)
    (define-key map (kbd "<S-down>") 'windmove-down)

    (define-key map (kbd "<f7>") 'my-other-frame)
    (define-key map (kbd "C-o") 'ido-find-file)
    (define-key map (kbd "M-o") 'execute-extended-command)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)



(my-keys-minor-mode 1)
; (global-set-key "\C-o" 'other-window)

;; (defun prev-window ()
;;   (interactive)
;;   (other-window -1))


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

;;; Package Management
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/") t)
    (package-initialize))

;;; Plugin: yasnippet Snippet
;;; Use `package-list` rather than file below
;; (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
;; (require 'yasnippet)
(yas-global-mode 1)

;;; Plugin: NeoTree
(global-set-key [f8] 'neotree-toggle)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(elfeed-feeds
   (quote
    ("http://feeds.developer.yahoo.net/YDNBlog?format=xml" "http://www.classicalguitarblog.net/feed/" "http://blog.coursera.org/rss" "http://feeds.feedburner.com/CreativeBloq" "http://vimeo.com/channels/documentaryfilm/videos/rss" "http://vimeo.com/channels/everythinganimated/videos/rss" "http://vimeo.com/channels/fubiz/videos/rss" "http://google-opensource.blogspot.com/feeds/posts/default" "http://www.wikihow.com/feed.rss" "http://www.ibm.com/developerworks/views/java/rss/libraryview.jsp" "http://www.ibm.com/developerworks/views/linux/rss/libraryview.jsp" "http://www.ibm.com/developerworks/views/web/rss/libraryview.jsp" "http://www.ibm.com/developerworks/cn/rss/dwcn_dwtp.rss" "http://feed.ishoulu.com/" "http://feeds.gawker.com/lifehacker/vip" "http://lovegedash.jugem.jp/?mode=rss" "http://feeds.feedburner.com/lyndacom-new-releases" "http://seekr.im/feed" "http://www.pixiv.net/spotlight/feed" "http://feeds.feedburner.com/Qiangqiang3" "http://www.quora.com/rss" "http://feeds.feedburner.com/iamsk" "http://solfeggiosound.com/?feed=rss2" "http://classicalguitarlessons.blogspot.com/feeds/posts/default" "https://github.com/blog.atom" "http://tinyfool.org/feed/" "http://blog.udacity.com/feeds/posts/default" "http://www.openclasses.info/feed" "http://feed.williamlong.info/" "http://feeds.feedburner.com/zhihu-daily" "http://zhihudaily.dev.malash.net/" "http://feed.google.org.cn/" "http://us3.campaign-archive2.com/feed?u=cf8241623925c632081356828&id=38f49f3119" "http://coolshell.cn/feed" "http://ricepig.sinaapp.com/?feed=rss2" "http://eatsalt.blog.163.com/rss/" "http://bangumi.tv/feed/blog/anime" "http://t66y.com/rss.php" "http://a-nerd.info/?feed=rss2" "http://blog.2dango.com/feed" "http://armsword.com/feed" "http://heyf.me/?feed=rss2" "http://backtrace.io/blog/atom.xml" "http://www.byvoid.com/blog/feed" "http://www.binarythink.net/feed/" "http://blog.binux.me/atom.xml" "http://feeds.feedburner.com/blacktulipcn" "http://www.boxjar.com/feed/" "http://catx.me/atom.xml" "https://chu2byo.me/rss/" "http://chain.logdown.com/posts.rss" "http://chenluois.com/blog/rss.xml" "http://www.chengxiaos.com/feed" "http://tianchunbinghe.blog.163.com/rss/" "http://foocoder.com/atom.xml" "http://feeds.feedburner.com/DeepReader" "http://www.derekblog.com/feed/" "http://thoseawesomeguys.com/joedevblog/feed/" "http://halfelf.me/feed" "http://feeds.feedburner.com/initiative" "http://fex.baidu.com/feed.xml" "http://funcman.logdown.com/posts.rss" "http://feeds.feedburner.com/GrokCode" "http://ilite.me/feed/" "http://www.minroad.com/?feed=rss2" "http://bluegene8210.is-programmer.com/posts.rss" "http://bluegene8210.is-programmer.com/comments.rss" "http://bluegene8210.is-programmer.com/messages.rss" "http://feeds.feedburner.com/kernelpanicim" "http://blog.csdn.net/lifetragedy/rss/list" "http://livid.v2ex.com/atom.xml" "http://blog.lovedboy.com/atom.xml" "http://lyric.im/atom.xml" "http://macshuo.com/?feed=rss2" "http://feeds2.feedburner.com/metacircus" "http://liuzhigong.blog.163.com/rss/" "http://cmgs.me/feed.xml" "http://besteric.com/atom.xml" "http://blog.csdn.net/qinysong/rss/list" "http://chloerei.com/feed.xml" "http://blog.kochiya.me/feed.xml" "http://feeds.feedburner.com/sivan" "http://andrewliu.tk/atom.xml" "http://sonicwu.com/atom.xml" "http://dhruvasagar.com/feed" "http://tjrus.com/rss" "http://zh.undozen.com/rss" "http://blog.thomasupton.com/atom.xml" "http://superuser.com/feeds/user/132604" "http://www.wdk.pw/feed" "http://gameofworlds.tumblr.com/rss" "http://blog.xavierskip.com/feed.xml" "http://blog.yegle.net/feeds/all.atom.xml" "http://yonsm.net/feed/" "http://blog.csdn.net/yumik0/rss/list" "http://zihua.li/feed/" "http://atalasii.com/rss" "http://icerote.net/blog/rss" "http://ideafoc.us/feed" "http://blog.codingnow.com/atom.xml" "http://www.stutostu.com/?feed=rss2" "http://mindhacks.cn/feed/" "http://fleurer-lee.com/atom.xml" "http://ippotsuko.com/blog/feed/" "http://blog.csdn.net/jaminwm/rss/list" "http://outmyself.com/feed/" "http://otakustay.com/rss/" "http://feed.feedsky.com/sofish" "http://blog.kuroy.me/feed/" "http://www.liaoxuefeng.com/feed" "http://blog.sina.com.cn/rss/1199839991.xml" "http://blog.x8128.com/atom.xml" "http://feed.feedsky.com/paicha" "http://blog.0907.org/feed" "http://blog.mutoo.im/feed/" "http://blog.mutoo.im/feed/2014/01/reading-concerned-joe-devblog-3.html" "http://phoenixtoday.blogbus.com/index.rdf" "http://kagami.me/feed" "http://biergaizi.info/?feed=rss" "http://nullice.com/feed" "http://www.muimi.me/feeds/posts/default?alt=rss" "http://www.c5a3.com/feed" "http://cheng.guru/atom.xml" "https://hacg.club/wordpress/feed" "http://miao.hu/feed.xml" "http://feeds.feedburner.com/eggfan/zudW" "http://eggfan.org/feed" "http://feeds.feedburner.com/hc1983" "http://www.yixiao.net/zblog/feed.asp" "http://blog.imsuzie.com/feed" "http://mytharcher.github.com/feed.xml" "http://askrain.lofter.com/rss" "http://feeds.feedburner.com/ruanyifeng" "http://vincent.bernat.im/en/blog/atom.xml" "http://lilydjwg.is-programmer.com/posts.rss" "https://hitomi.la/index-all.atom" "https://apple4us.com/feed" "http://digg.com/rss/top.rss" "http://www.ftchinese.com/rss/news" "http://www.ftchinese.com/sc/rss_r.jsp" "http://www.ftchinese.com/rss/hotstoryby7day" "http://news.ycombinator.com/rss" "http://www.solidot.org/index.rss" "http://news.google.com/news?pz=1&cf=all&ned=us&hl=en&topic=ir&output=rss" "http://news.google.com/news?pz=1&cf=all&ned=us&hl=en&output=rss" "http://news.google.com/news?pz=1&cf=all&ned=us&hl=en&topic=w&output=rss" "http://feed.feedsky.com/my1510" "http://feeds2.feedburner.com/chinagfwblog" "http://share.dmhy.org/topics/rss/rss.xml" "http://www.hexieshe.com/feed" "http://news.google.com/news?cf=all&ned=cn&hl=zh-CN&topic=h&num=3&output=rss" "http://news.google.com/news?cf=all&ned=cn&hl=zh-CN&topic=ir&output=rss" "http://wangcong.org/blog/?feed=rss2" "https://www.destroyallsoftware.com/blog/index.xml" "http://blog.csdn.net/gideal_wang/rss/list" "http://feeds.feedburner.com/linuxtoy" "http://v2ex.com/index.xml" "http://www.yining.org/feed/atom/" "http://feeds.feedburner.com/aquarianboy" "http://feed.feedsky.com/MSDN_l1gm" "http://blog.jjgod.org/feed/" "http://drops.wooyun.org/feed" "http://www.52pojie.cn/forum.php?mod=rss" "http://gold.xitu.io/rss" "http://www.linuxeden.com/feed.php" "http://programming.reddit.com/.rss" "http://feeds.feedburner.com/codinghorror/" "http://gfwrev.blogspot.com/feeds/posts/default" "http://feeds.feedburner.com/LatestNewPagesOnComputerHope" "http://linux.101hacks.com/feed/" "http://linux.byexamples.com/feed/" "http://zh.lucida.me/atom.xml" "http://lcx.cc/?a=rss" "http://feedproxy.google.com/TheGeekStuff" "http://www.v2ex.com/feed/tab/tech.xml" "http://gdata.youtube.com/feeds/base/users/DiscoveryNetworks/uploads?alt=rss&v=2&orderby=published&client=ytapi-youtube-profile" "http://gdata.youtube.com/feeds/base/users/GoProCamera/uploads?alt=rss&v=2&orderby=published&client=ytapi-youtube-profile" "http://gdata.youtube.com/feeds/base/users/JimmyKimmelLive/uploads?alt=rss&v=2&orderby=published&client=ytapi-youtube-profile" "http://youtube.com/rss/global/top_viewed_today.rss" "http://gdata.youtube.com/feeds/base/users/techcrunch/uploads?alt=rss&v=2&orderby=published&client=ytapi-youtube-profile" "http://gdata.youtube.com/feeds/base/users/TEDtalksDirector/uploads?alt=rss&v=2&orderby=published&client=ytapi-youtube-profile" "http://gdata.youtube.com/feeds/base/users/TheEllenShow/uploads?alt=rss&v=2&orderby=published&client=ytapi-youtube-profile" "http://dev.duoshuo.com/feed" "http://www.read.org.cn/feed" "http://blog.eqoe.cn/feed.xml" "http://7thgen.info/blog/feed/" "http://www.cnblogs.com/codemood/rss" "http://www.write.org.cn/feed" "http://feed.pixnet.net/blog/posts/rss/okplaymayday" "http://blog.csdn.net/v_JULY_v/rss/list" "http://blog.sina.com.cn/rss/1342072407.xml" "https://news.ycombinator.com/rss"))))
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
(defun pbcopy-old ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))
;;; This also works
;; (shell-command-on-region (region-beginning) (region-end) "pbcopy")
(defun pbcopy (start end arg &optional interactive)
  (interactive "r\nP\np")
  (if interactive
      (if (region-active-p)
          (call-process-region start end "pbcopy")
        (call-process-region (point-min) (point-max) "pbcopy")))
  (setq deactivate-mark t))


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


;;; Elscreen
;; (elscreen-start)

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

;;; org-agenda
;; (global-set-key "\C-ca" 'org-agenda)

(setq linum-format "%d ")

;; For M-( insert with no space
(setq parens-require-spaces nil)

;; use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

;; when cursor is on edge, move to the other side, as in a torus space
(setq windmove-wrap-around t )

(hiwin-activate)

;; (global-hl-line-mode 1)
;; (set-face-background 'hl-line "#3e4446")
;; (set-face-foreground 'highlight nil)


;;; For restore Windows and Frames, otherwise it'll throw errors when `desktop-change-dir`.
;;; http://stackoverflow.com/questions/18612742/emacs-desktop-save-mode-error
;;;
;; (setq desktop-restore-frames t)
;; (setq desktop-restore-in-current-display t)
;;; It is the (setq desktop-restore-forces-onscreen nil) line specifically that fixes this issue. 
(setq desktop-restore-forces-onscreen nil)


;;; http://stackoverflow.com/questions/10363982/how-can-i-open-a-temporary-buffer
(defun new-scratch ()
  (interactive)
  (switch-to-buffer (make-temp-name "Scratch-")))
