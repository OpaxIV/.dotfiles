;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Maximize emacs on startup
;; add fullscreen element to list variable 'initial-frame-alist'
;; built-in Emacs variable containing settings that should be applied only to first frame Emacs creates
(add-to-list 'initial-frame-alist '(fullscreen . maximized))



;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-spacegrey)
(setq doom-theme 'doom-material)
;;(setq doom-theme 'doom-solarized-light)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.



;; ----------------------------------------------------------------------------------------
;; USER CONFIG
;; ----------------------------------------------------------------------------------------

;; --- Splash Screen
;; set ascii art
;; a function is needed to be passed as a variable, hence the lamba

(defun my-splash ()
  (let ((banner
         '("        Free as in FREE Software."
           "        =========================")))
    (dolist (line banner)
      (insert (concat line "\n")))))

(setq +doom-dashboard-ascii-banner-fn #'my-splash)

;; 2do

;; set additional terminal shortcut

;;2do




;; --- General

;; User Info:
;; On Mac and Linux the config.el file must reside in the '~/.config/doom' directory
;; On Windows it resides under '~/.doom.d'

;; Font Size
;; Set font and size
(setq doom-font (font-spec :family "Courier" :size 14 :weight 'regular))


;; Key Mappings
(map! :leader
      (:prefix ("n" . "notes")  ; SPC n is "notes" prefix
       (:prefix ("r" . "roam")  ; SPC n r is "roam" prefix
        :desc "Toggle roam buffer" "l" #'org-roam-buffer-toggle
        :desc "Find roam node" "f" #'org-roam-node-find
        :desc "Insert roam node" "i" #'org-roam-node-insert)))


;; Enable system-wide clipboard integration
(setq select-enable-primary t)
(setq select-enable-clipboard t)


;; Define default directory to open on start-up
(setq default-directory "~/org/")


;; --- Dired

;; add usual hjkl bindings to dired
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file)



;; -- Latex
;; Latex Shell Path
(add-to-list 'exec-path "/Library/TeX/texbin")
(setenv "PATH"
        (concat "/Library/TeX/texbin:" (getenv "PATH")))


(setq org-startup-with-latex-preview t)



;; --- Org Mode

;; Set default folder upon startup
(after! org
  ;; Set the org directory
  ;; change depending on OS or needs
  (setq org-directory "~/org/"))


;; Org Agenda

;; Set Agenda files location, ignore conflict and config files
; (after! org
;   (setq org-agenda-files
;         (seq-filter
;          (lambda (f)
;            (and (not (string-match-p "sync-conflict" f))
;                 (not (string-match-p "/\\.[^/]+$" f))))
;          (directory-files-recursively "~/org/agenda" "\\.org$"))))

(after! org
  (setq org-agenda-files
        (directory-files-recursively
         "~/org/agenda"
         "\\.org$"
         nil
         (lambda (dir)
           (and
            ;; skip hidden dirs
            (not (string-match-p "/\\.[^/]+/?$" dir))
            ;; skip sync conflict dirs/files
            (not (string-match-p "sync-conflict" dir)))))))



;; agenda view
;(setq org-agenda-prefix-format
;      ;; make sure to add a category to heading
;      '((agenda . " %i %-12:c%?-12t ")
;        (todo   . " %i %-12:c ")
;        (tags   . " %i %-12:c ")
;        (search . " %i %-12:c ")))

;;(setq org-agenda-prefix-format '((agenda . " %i %-12:c%?-12t% s %b")))


;; Define org-agenda tags
;; use C-c C-q to add tags to a todo item
(after! org
  (setq org-tag-alist
        ; Place
        '((:startgroup)
          ("@home" . ?H)
          ("@school" . ?S)
          ("@out" . ?O)
          ("@office" . ?U)
          (:endgroup)

        ; Device
          (:startgroup)
          ("@computer" . ?C)
          ("@phone" . ?P)
          (:endgroup)

        ; Type of Todo
          (:startgroup)
          ("@activity" . ?a)
          ("@car" . ?m)
          ("@contact" . ?c)
          ("@creative" . ?k)
          ("@errands" . ?r)
          ("@finances" . ?f)
          ("@habits" . ?h)
          ("@japanese" . ?j)
          ("@miscellaneous" . ?o)
          ("@programming" . ?p)
          ("@study" . ?s)
          ("@tech" . ?t)
          ("@work" . ?w)
          (:endgroup)
          )))

;; hide tags inside of agenda view
(setq org-agenda-hide-tags-regexp ".*")


;; Rename File and Buffer
(defun rename-file-and-buffer (new-name)
  "Rename current buffer and the file it is visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer is not visiting a file!")
      (progn
        (rename-file filename new-name 1)
        (set-visited-file-name new-name t t)
        (rename-buffer (file-name-nondirectory new-name))
        (set-buffer-modified-p nil)
        (message "Renamed to %s" new-name)))))

;; Enable Trash
(setq delete-by-moving-to-trash t)


;; Delete all DONE Todos in one go
;; searches in agenda folder only
(defun org-delete-all-done ()
  ;; access function using M+x keys
  (interactive)
  ;; iterate over all files inside the org-agenda-files variable
  (dolist (file (org-agenda-files))
    ;; process multiple files without opening them/switch between them
    (with-current-buffer (find-file-noselect file)
      ;; search the tag /DONE in the current file
      ;; do not follow sub-files/children
      ;; delete the subtree under the found org entry
      ;; save the buffer
      (org-map-entries (lambda () (org-cut-subtree)) "/DONE" 'file)
      (save-buffer))))

;; create custom agenda views
(after! org
  (setq org-agenda-custom-commands
        '(("t" "Today's agenda"
           agenda ""
           ((org-agenda-span 1)
            (org-agenda-start-day "0d")))

          ("h" "Habits only"
           tags "STYLE=\"habit\""))))



;; Org Roam

;; set org roam directory
;;(setq org-roam-directory "~/org/roam/")  ;; set your preferred notes folder
(after! org-roam
  (setq org-roam-directory "~/org/roam/"
        org-roam-file-exclude-regexp "\\(^\\..*\\|sync-conflict\\)")
  (org-roam-db-autosync-mode 1))


(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory org-roam-directory)
 :config
  (org-roam-setup)
  (org-roam-db-autosync-mode))


;; Org-Roam-UI Config
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))



;; Org Habits

; (after! org
;  (add-to-list 'org-modules 'org-habit))

;(after! org
;  (add-to-list 'org-modules 'org-habit)
;  (setq org-agenda-custom-commands
;        '(("h" "Habits only"
;           tags-todo "STYLE=\"habit\""))))

(after! org
  (add-to-list 'org-modules 'org-habit)
  ; enable habits inside of main agenda view
  (setq org-habit-show-all-today t))
        ; create custom view for habits


;; Org Ql / Org Rifle

;; org-ql setup
;; loaded after org initialisation
(use-package! org-ql
  :after org)





;; --- C Programming

;; set "gnu" style indenting
(setq c-default-style "linux"
      c-basic-offset 4)



;; --- Python Programming
