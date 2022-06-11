
;; ------ Automatic emacs lines -------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(paredit parinfer-rust multiple-cursors cmake-mode which-key use-package spacemacs-theme solo-jazz-theme solarized-theme rainbow-delimiters projectile parinfer-rust-mode one-themes modus-themes ivy-rich helpful doom-themes doom-modeline counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; ------ Initial frame maximized ------
(add-to-list 'initial-frame-alist '(fullscreen . maximized))


;; ------ Emacs editor changes ------
(setq inhibit-startup-message t)    ; Disable startup message
(menu-bar-mode -1)                  ; Disable the menu bar
(scroll-bar-mode -1)                ; Disable visible scrollbar
(tool-bar-mode -1)                  ; Disable the toolbar
(tooltip-mode -1)                   ; Disable tooltips
(set-fringe-mode 10)                ; Give some breathing room
(switch-to-buffer "new-file" nil t) ; The initial buffer should be an empty buffer
(setq indent-tabs-mode nil)


;; ------ Mouse wheel ------
(setq mouse-wheel-scroll-amount '(2 ((shift) . 4) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)


;; ------ Use package variable ------
(setq use-package-always-ensure t)


;; ------- Themes light theme -------
(use-package one-themes
  :init
  (load-theme 'one-light t))


;; ------- Doom modeline -------
(use-package doom-modeline
  :init (doom-modeline-mode 1))


;; ------- Slime sbcl ---------
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")


;; -------- Slime personal commands ---------
(defun slime-quit ()
  (interactive)
  (slime-quit-lisp)
  (kill-buffer "*inferior lisp*"))

(define-key slime-editing-map (kbd "C-c r") 'slime-restart-inferior-lisp)
(define-key slime-editing-map (kbd "C-c q") 'slime-quit)


;; -------- Electric pair --------
(add-hook 'emacs-lisp-mode-hook       #'electric-pair-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'electric-pair-mode)
(add-hook 'ielm-mode-hook             #'electric-pair-mode)
(add-hook 'lisp-mode-hook             #'electric-pair-mode)
(add-hook 'lisp-interaction-mode-hook #'electric-pair-mode)
(add-hook 'scheme-mode-hook           #'electric-pair-mode)


;; ------- Line numbers -------
(column-number-mode)
(global-display-line-numbers-mode t)

(dolist (mode '(eshell-mode-hook)) ; Indicamos en que modos no queremos los numeros
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; ------- Which key mode -------
(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 5.0))


;; ------- Ivy mode -------
(use-package ivy
  :init (ivy-mode)
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))


;; ------ Ivy rich ------
(use-package ivy-rich
  :init (ivy-rich-mode 1))


;; ------ Counsel ------
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))


;; ------ helpful ------
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


;; ------ Projectile ------
(use-package projectile
  :config (projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (setq projectile-project-search-path nil)
  (when (file-directory-p "~/quicklisp/local-projects")
    (setq projectile-project-search-path (cons "~/quicklisp/local-projects" projectile-project-search-path)))
  (when (file-directory-p "~/GitHub")
    (setq projectile-project-search-path (cons "~/GitHub" projectile-project-search-path))))


;; ------- Multiple cursors -------
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-line-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-line-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
