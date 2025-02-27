;;; init-ui.el --- Theme, modeline and window behavior -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

;; Use default theme in terminals
(use-package doom-themes
  :ensure t
  :when (display-graphic-p)
  :config
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(use-package emacs
  :ensure nil
  :unless (display-graphic-p)
  :config
  (load-theme 'leuven t))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-irc nil)
  (doom-modeline-mu4e nil)
  (doom-modeline-gnus nil)
  (doom-modeline-github nil)
  (doom-modeline-persp-name nil)
  (doom-modeline-unicode-fallback t)
  (doom-modeline-enable-word-count nil))

;; Customize popwin behavior
(use-package shackle
  :ensure t
  :hook (after-init . shackle-mode)
  :custom
  (shackle-default-size 0.5)
  (shackle-default-alignment 'below)
  (shackle-rules '((magit-status-mode    :select t :inhibit-window-quit t :same t)
                   (magit-log-mode       :select t :inhibit-window-quit t :same t)
                   (vc-annotate-mode     :select t :inhibit-window-quit t :same t)
                   ("*quickrun*"         :select t :inhibit-window-quit t :same t)
                   (profiler-report-mode :select t)
                   (xwidget-webkit-mode  :select t :same t)
                   (comint-mode          :select t :align t :size 0.4)
                   (grep-mode            :select t :align t)
                   (rg-mode              :select t :align t)
                   ;; See also `help-window-select'
                   (apropos-mode         :select nil :align t :size 0.4)
                   (help-mode            :select nil :align t :size 0.4)
                   ("*Flycheck errors*"         :select t   :align t :size 10)
                   ("*Backtrace*"               :select t   :align t :size 15)
                   ("*Shell Command Output*"    :select nil :align t :size 0.4)
                   ("*Async Shell Command*"     :select nil :align t :size 0.4)
                   ("*Org-Babel Error Output*"  :select nil :align t :size 0.3)
                   ("*package update results*"  :select nil :align t :size 10)
                   ("*Process List*"            :select t   :align t :size 0.3)
                   ("*Occur*"                   :select t   :align t)
                   ("\\*eldoc\\( for \\)?.*\\*" :select nil :align t :size 15 :regexp t))))

(use-package help
  :ensure nil
  :custom
  (help-window-select t)
  (help-enable-variable-value-editing t))

;; Windows layout recorder
;;
;; You can still use `winner-mode' on Emacs 26 or early. On Emacs 27, it's
;; preferred over `winner-mode' for better compatibility with `tab-bar-mode'.
(use-package tab-bar
  :ensure nil
  :hook (after-init . tab-bar-history-mode)
  :custom
  (tab-bar-history-buttons-show nil))

(use-package nerd-icons
  :ensure t
  :when (display-graphic-p)
  :demand t)

(use-package dashboard
  :ensure t
  :init
  ;; Format: "(icon title help action face prefix suffix)"
  (setq dashboard-navigator-buttons `(((,(if (fboundp 'nerd-icons-octicon) (nerd-icons-octicon "nf-oct-mark_github") "★")
                                        "GitHub" "Browse" (lambda (&rest _) (browse-url homepage-url)))
                                       (,(if (fboundp 'nerd-icons-octicon) (nerd-icons-octicon "nf-oct-heart") "♥")
                                        "Stars" "Show stars" (lambda (&rest _) (browse-url stars-url)))
                                       (,(if (fboundp 'nerd-icons-octicon) (nerd-icons-octicon "nf-oct-alert") "⚑")
                                        "Issue" "Report issue" (lambda (&rest _) (browse-url issue-url)) warning)
                                       (,(if (fboundp 'nerd-icons-octicon) (nerd-icons-octicon "nf-oct-download") "♺")
                                        "Upgrade" "Upgrade packages synchronously" (lambda (&rest _) (package-upgrade-all nil)) success))))
  (dashboard-setup-startup-hook)
  :config
  (defconst homepage-url "https://github.com/condy0919/.emacs.d")
  (defconst stars-url (concat homepage-url "/stargazers"))
  (defconst issue-url (concat homepage-url "/issues/new"))
  :custom
  (dashboard-startup-banner 'logo)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-set-init-info t)
  (dashboard-set-navigator t)
  (dashboard-items '((recents   . 10)
                     (projects  . 7))))

(provide 'init-ui)

;;; init-ui.el ends here
