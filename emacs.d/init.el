; Enable the magic of emacs to flow
(setq magic 1)

; Load color coding.
(global-font-lock-mode 1)

; Fix comments
(set-face-foreground 'font-lock-comment-face "pink")
(set-face-foreground 'font-lock-comment-delimiter-face "pink")

; Navigation key binding
(global-set-key [kp-home]  'beginning-of-line)
(global-set-key [home]     'beginning-of-line)
(global-set-key [kp-end]   'end-of-line)      
(global-set-key [end]      'end-of-line)

; More keybindings
(global-set-key (kbd "C-x /") 'comment-or-uncomment-region)
(global-set-key (kbd "C-x r") 'replace-string)

; Make the default tab stops smaller
(setq default-tab-width 2)
;(setq-default tab-stop-list '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40))

; Load color coding.
(global-font-lock-mode 1)

; Remove menu
(menu-bar-mode 0)

; Fix comments
(set-face-foreground 'font-lock-comment-face "pink")
(set-face-foreground 'font-lock-comment-delimiter-face "pink")

; Insert special characters
(define-prefix-command 'insert-characters)
(global-set-key (kbd "M-i") 'insert-characters)
(global-set-key (kbd "M-i d") "Δ")
(global-set-key (kbd "M-i l") "λ")

; Suppress the annoying 'add newline at end of file' on saves
(setq inhibit-default-init t)
(setq require-final-newline nil)

; Markdown
(autoload 'markdown-mode "~/.emacs.d/markdown-mode/markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.text" . markdown-mode) auto-mode-alist))

; Automatically load longlines and flyspell for text files
;(add-hook 'text-mode-hook 'longlines-mode)
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'text-mode-hook 'flyspell-mode)

; Javascript (for <23, included by default after that)
; http://code.google.com/p/js2-mode/
(when (< emacs-major-version 23)
  ; base js2
  (setq load-path (append (list (expand-file-name "~/.emacs.d/js2-mode")) load-path))
	
  (autoload 'js2-mode "js2-mode" "Major mode for Javascript" t)
  (autoload 'javascript-mode "javascript-mode" "Major mode for Javascript" t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

  ; add espresso for indentation
  (autoload 'espresso-mode "espresso")

  ; load the custom indentation function
  (load "custom-indent.el"))
