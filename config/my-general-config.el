;; General
;; Hitting TAB always just indents the current line.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*General][General:1]]
(setq tab-always-indent t)
;; General:1 ends here



;; Only one auth source for magit & co.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*General][General:2]]
(setq auth-sources '("~/.netrc"))
;; General:2 ends here



;; Utf-8


;; [[file:~/.spacemacs.d/config/my-general-config.org::*General][General:3]]
(prefer-coding-system 'utf-8)
;; General:3 ends here



;; Enable line wrapping


;; [[file:~/.spacemacs.d/config/my-general-config.org::*General][General:4]]
(setq truncate-lines nil)
;; General:4 ends here

;; Appearance
;; Clean up spaceline contents.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Appearance][Appearance:1]]
(with-eval-after-load 'spaceline-segments
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-buffer-size-off))
;; Appearance:1 ends here

;; Ruby
;; Don't automatically insert the magic encoding comment.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Ruby][Ruby:1]]
(setq ruby-insert-encoding-magic-comment nil)
;; Ruby:1 ends here



;; Keybinding to toggle between new and old hash syntax.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Ruby][Ruby:2]]
(evil-leader/set-key
  "xrh" 'ruby-toggle-hash-syntax)
;; Ruby:2 ends here



;; Underscore should be a word delimiter in slim.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Ruby][Ruby:3]]
(add-hook 'slim-mode-hook #'(lambda () (modify-syntax-entry ?_ "_")))
;; Ruby:3 ends here

;; Elixir
;; Better formatting for test output buffers.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Elixir][Elixir:1]]
(setq alchemist-test-truncate-lines nil)
;; Elixir:1 ends here



;; Call elixir-format before save.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Elixir][Elixir:2]]
(add-hook 'elixir-mode-hook
          (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
;; Elixir:2 ends here

;; Go
;; Set tab width to 4.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Go][Go:1]]
(setq-default tab-width 4)
;; Go:1 ends here



;; Call go-format before save.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Go][Go:2]]
(setq go-format-before-save t)
;; Go:2 ends here



;; Enable flycheck for Go mode.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Go][Go:3]]
(add-hook 'go-mode-hook
          (lambda () (flycheck-mode 1)))
;; Go:3 ends here

;; Web Mode
;; Intendation settings


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Web%20Mode][Web Mode:1]]
(setq web-mode-css-indent-offset 2)
(setq js2-basic-offset 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq css-indent-offset 2)
(setq-default js2-basic-offset 2
              js-indent-level 2)
;; Web Mode:1 ends here

;; JavaScript
;; Allow =.dir-locals.el= files to set prettier-related settings.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*JavaScript][JavaScript:1]]
(put 'prettier-js-args 'safe-local-variable 'listp)
(put 'prettier-js-command 'safe-local-variable 'stringp)
;; JavaScript:1 ends here



;; Setup [[https://github.com/abicky/nodejs-repl.el][nodejs-repl.el]] keybindings.

;; [[file:~/.spacemacs.d/config/my-general-config.org::*JavaScript][JavaScript:2]]
(spacemacs/set-leader-keys-for-major-mode 'js2-mode "ne" 'nodejs-repl-send-last-expression)
(spacemacs/set-leader-keys-for-major-mode 'js2-mode "nl" 'nodejs-repl-send-line)
(spacemacs/set-leader-keys-for-major-mode 'js2-mode "nr" 'nodejs-repl-send-region)
(spacemacs/set-leader-keys-for-major-mode 'js2-mode "nb" 'nodejs-repl-send-buffer)
(spacemacs/set-leader-keys-for-major-mode 'js2-mode "nf" 'nodejs-repl-load-file)
(spacemacs/set-leader-keys-for-major-mode 'js2-mode "n'" 'nodejs-repl-switch-to-repl)
(spacemacs/set-leader-keys-for-major-mode 'js2-mode "ns" 'nodejs-repl-switch-to-repl)
;; JavaScript:2 ends here

;; SQL
;; The =sqlfmt= does not work very well with Postgres and is also outdated.
;; This uses [[https://github.com/darold/pgFormatter][pgFormatter]] instead, installed with =brew install pgformatter=.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*SQL][SQL:1]]
(setq sqlfmt-executable "pg_format")
(setq sqlfmt-options '())
;; SQL:1 ends here

;; Movements
;; Make evil-mode up/down operate in screen lines instead of logical lines.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Movements][Movements:1]]
(define-key evil-motion-state-map "j" 'evil-next-visual-line)
(define-key evil-motion-state-map "k" 'evil-previous-visual-line)
;; Movements:1 ends here



;; Also in visual mode...


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Movements][Movements:2]]
(define-key evil-visual-state-map "j" 'evil-next-visual-line)
(define-key evil-visual-state-map "k" 'evil-previous-visual-line)
;; Movements:2 ends here



;; Move line under cursor with =C-j/k=.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Movements][Movements:3]]
(define-key evil-normal-state-map (kbd "C-j") 'move-text-down)
(define-key evil-normal-state-map (kbd "C-k") 'move-text-up)
;; Movements:3 ends here



;; Pressing =H= in any edit mode moves the cursor to the first non-blank character.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Movements][Movements:4]]
(evil-global-set-key 'normal "H" 'evil-first-non-blank)
(evil-global-set-key 'visual "H" 'evil-first-non-blank)
(evil-global-set-key 'motion "H" 'evil-first-non-blank)
;; Movements:4 ends here



;; Pressing =L= in any edit mode moves the cursor to the end of line.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Movements][Movements:5]]
(evil-global-set-key 'normal "L" (lambda () (interactive) (evil-end-of-line)))
(evil-global-set-key 'visual "L" (lambda () (interactive) (evil-end-of-line)))
(evil-global-set-key 'motion "L" (lambda () (interactive) (evil-end-of-line)))
;; Movements:5 ends here



;; Type =g l= to get a fast home row friendly jump menu to go to a visible line.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Movements][Movements:6]]
(define-key evil-motion-state-map "gl" 'evil-avy-goto-line)
(define-key evil-normal-state-map "gl" 'evil-avy-goto-line)
;; Movements:6 ends here



;; Type =g o <char> <char>= to get a fast home row friendly jump menu to go to a visible word that starts with these characters.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Movements][Movements:7]]
(define-key evil-motion-state-map "go" 'evil-avy-goto-char-2)
(define-key evil-normal-state-map "go" 'evil-avy-goto-char-2)
;; Movements:7 ends here

;; Macros

;; Type =Q= to execute the macro recorded to =q.=


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Macros][Macros:1]]
(evil-global-set-key 'normal (kbd "Q") (lambda () (interactive) (evil-execute-macro 1 "@q")))
;; Macros:1 ends here

;; Dired
;; In =dired=, move to parent directory with =h= and open thing under cursor with =l=.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Dired][Dired:1]]
(with-eval-after-load 'dired
  (evil-define-key 'normal dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file
    )
  )
;; Dired:1 ends here

;; Umlauts
;; Make Umlauts work like in the rest of MacOS.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Umlauts][Umlauts:1]]
(global-unset-key (kbd "M-s"))
(global-set-key (kbd "M-s")
                (lambda ()
                  "Insert ß."
                  (interactive)
                  (insert "ß")))
(global-unset-key (kbd "M-u"))
(global-set-key (kbd "M-u a")
                (lambda ()
                  "Insert ä."
                  (interactive)
                  (insert "ä")))
(global-set-key (kbd "M-u A")
                (lambda ()
                  "Insert Ä."
                  (interactive)
                  (insert "Ä")))
(global-set-key (kbd "M-u o")
                (lambda ()
                  "Insert ö."
                  (interactive)
                  (insert "ö")))
(global-set-key (kbd "M-u O")
                (lambda ()
                  "Insert Ö."
                  (interactive)
                  (insert "Ö")))
(global-set-key (kbd "M-u u")
                (lambda ()
                  "Insert ü."
                  (interactive)
                  (insert "ü")))
(global-set-key (kbd "M-u U")
                (lambda ()
                  "Insert Ü."
                  (interactive)
                  (insert "Ü")))
;; Umlauts:1 ends here

;; Misc
;; Set hippie expand from M-/ to ctrl-space.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Misc][Misc:1]]
(global-set-key (kbd "C-SPC") 'hippie-expand)
;; Misc:1 ends here

;; Emojis
;; Overwrite emoji settings.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Emojis][Emojis:1]]
(defun --set-emoji-font (frame)
  "Adjust the font settings of FRAME so Emacs can display emoji properly."
  (if (eq system-type 'darwin)
      ;; For NS/Cocoa
      (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji" :size 10) frame 'prepend)
    ;; For Linux
    (set-fontset-font t 'symbol (font-spec :family "Symbola") frame 'prepend)))

;; For when Emacs is started in GUI mode:
(--set-emoji-font nil)
;; Hook for when a frame is created with emacsclient
;; see https://www.gnu.org/software/emacs/manual/html_node/elisp/Creating-Frames.html
(add-hook 'after-make-frame-functions '--set-emoji-font)
(setq company-emoji-insert-unicode t)
;; Emojis:1 ends here

;; Switch between Rails i18n files
;; This function switches between the German and the English translation file in a Rails project. Especially handy, if the project has a lot of files per language.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Switch%20between%20Rails%20i18n%20files][Switch between Rails i18n files:1]]
(defun switch-rails-i18n-file()
  "Switches to the i18n file in the other language"
  (interactive)
  (if (search "/de/" buffer-file-name)
    (find-file (replace-regexp-in-string "/de/" "/en/" (buffer-file-name)))
    (find-file (replace-regexp-in-string "/en/" "/de/" (buffer-file-name))))
  )
;; Switch between Rails i18n files:1 ends here

;; Finalization
;; In the end, satisfy the Spacemacs loading mechanism.


;; [[file:~/.spacemacs.d/config/my-general-config.org::*Finalization][Finalization:1]]
(provide 'my-general-config)
;; Finalization:1 ends here
