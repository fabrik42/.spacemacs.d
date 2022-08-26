;; Logging Task State change

;; Changes to task states might get logged, especially for recurring routines.
;; If so, log them in a drawer, not the content of the note.


;; [[file:my-org-config.org::*Logging Task State change][Logging Task State change:1]]
(setq org-log-state-notes-into-drawer t)
;; Logging Task State change:1 ends here

;; Initialization

;; This enables buffer face mode for the Org agenda views.

;; While Org mode needs a lot of custom styling to work in =variable-pitch-mode= I take the easy way out in the agenda view by choosing the monospaced version of the font: =iA Writer Mono S=. It is way easier to align the ASCII tables of agenda with a font with a fixed pitch.


;; [[file:my-org-config.org::*Initialization][Initialization:1]]
(defun my-org-config/setup-buffer-face ()
  (setq buffer-face-mode-face '(:family "iA Writer Mono S"))
  (buffer-face-mode)
  )
(add-hook 'org-agenda-mode-hook 'my-org-config/setup-buffer-face)
;; Initialization:1 ends here



;; Once Org mode loaded, turn on =olivetti=, hide tilde fringes and enable visual line mode.


;; [[file:my-org-config.org::*Initialization][Initialization:2]]
(defun my-org-config/after-org-mode-load ()
  (visual-line-mode)
  (vi-tilde-fringe-mode -1)

  (require 'org-indent)
  (org-indent-mode)
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))

  (variable-pitch-mode 1)

  (require 'olivetti)
  (olivetti-mode)
  )

(add-hook 'org-mode-hook 'my-org-config/after-org-mode-load)
;; Initialization:2 ends here



;; Save all Org buffers after archiving, as this will trigger the auto-commit of the git repo the Org files live in.


;; [[file:my-org-config.org::*Initialization][Initialization:3]]
(defun my-org-config/after-org-archive ()
  (org-save-all-org-buffers))

(add-hook 'org-archive-hook 'my-org-config/after-org-archive)
;; Initialization:3 ends here



;; Within a recurring task, reset contained check boxes when task is done if =RESET_CHECK_BOXES= property is set to =t=.


;; [[file:my-org-config.org::*Initialization][Initialization:4]]
(require 'org-checklist)
;; Initialization:4 ends here

;; Quick Access
;; Quick access to my most important org functions is given by opening the menu =SPC o=.

;; It is not really needed/working to declare this prefix, as the prefix =o= is reserved  for user bindings anyways.


;; [[file:my-org-config.org::*Quick Access][Quick Access:1]]
(spacemacs/declare-prefix "o" "org mode")
;; Quick Access:1 ends here



;; You can view my daily agenda with =SPC o d=.


;; [[file:my-org-config.org::*Quick Access][Quick Access:2]]
(defun my-org-daily-agenda ()
  (interactive)
  (org-agenda nil "d")
  )

(spacemacs/set-leader-keys "od" 'my-org-daily-agenda)
;; Quick Access:2 ends here



;; Add a new todo with preselected template with =SPC o t=.


;; [[file:my-org-config.org::*Quick Access][Quick Access:3]]
(defun my-org-add-todo ()
  (interactive)
  (org-capture nil "t")
  )
(spacemacs/set-leader-keys "ot" 'my-org-add-todo)
;; Quick Access:3 ends here



;; Add a new feedback note entry with preselected template with =SPC o f=.


;; [[file:my-org-config.org::*Quick Access][Quick Access:4]]
(defun my-org-add-feedback ()
  (interactive)
  (org-capture nil "f")
  )
(spacemacs/set-leader-keys "of" 'my-org-add-feedback)
;; Quick Access:4 ends here



;; Add a new notable change/fact entry with preselected template with =SPC o n=.


;; [[file:my-org-config.org::*Quick Access][Quick Access:5]]
(defun my-org-add-to-changelog ()
  (interactive)
  (org-capture nil "n")
  )
(spacemacs/set-leader-keys "on" 'my-org-add-to-changelog)
;; Quick Access:5 ends here



;; Call =org-capture= with =SPC o c=.


;; [[file:my-org-config.org::*Quick Access][Quick Access:6]]
(spacemacs/set-leader-keys "oc" 'org-capture)
;; Quick Access:6 ends here



;; Call =org-agenda= with =SPC o a=.


;; [[file:my-org-config.org::*Quick Access][Quick Access:7]]
(spacemacs/set-leader-keys "oa" 'org-agenda)
;; Quick Access:7 ends here



;; Call =org-store-link= with =SPC o l=.


;; [[file:my-org-config.org::*Quick Access][Quick Access:8]]
(spacemacs/set-leader-keys "ol" 'org-store-link)
;; Quick Access:8 ends here



;; /Experimental:/ Open a mini buffer to search through all org file names.

;; Not sure how much sense this makes, as I want the selected file to be opened in the proper perspective. Also, maybe =org-rifle= makes more sense?


;; [[file:my-org-config.org::*Quick Access][Quick Access:9]]
(defun my-org-helm-find-file ()
  (interactive)
  (helm-browse-project-find-files "/Users/fabrik42/org")
  )

(spacemacs/set-leader-keys "oj" 'my-org-helm-find-file)
;; Quick Access:9 ends here


;; #+ATTR_ORG: :width 500
;; #+RESULTS[de0d1f75a775b1231b73bb3cc21a48169d241f63]:
;; [[file:images/file_setup.png]]

;; I use a general inbox file to collect all new tasks on the run and will batch-schedule/refile them a couple times a day.

;; Inbox and mobile inbox co-exist to prevent sync conflicts when adding tasks while having no internet connection. This works pretty well and I treat them equally in the agenda views.


;; [[file:my-org-config.org::*Files][Files:2]]
(defvar org-my-inbox-file "~/org/inbox.org")
(defvar org-my-mobile-inbox-file "~/org/inbox_mobile.org")
;; Files:2 ends here



;; Default note file, that will also be used for capturing new notes.


;; [[file:my-org-config.org::*Files][Files:3]]
(setq org-default-notes-file org-my-inbox-file)
;; Files:3 ends here



;; Work-related tasks and notes.


;; [[file:my-org-config.org::*Files][Files:4]]
(defvar org-my-general-files "~/org")
;; Files:4 ends here



;; Private tasks and notes.


;; [[file:my-org-config.org::*Files][Files:5]]
(defvar org-my-projects-dir "~/org/projects")
;; Files:5 ends here



;; The files to be used for agenda display. This contains:

;; - Task inbox file
;; - Mobile task inbox file
;; - Work tasks file

;; /Note:/ Right now, I would like to have =TODOs= in my project files as well. However, this does not play well with [[https://beorgapp.com/][beorg]], as the app only allows one org directory without subfolders. :(


;; [[file:my-org-config.org::*Files][Files:6]]
(add-to-list 'org-agenda-files org-my-general-files)
(add-to-list 'org-agenda-files org-my-projects-dir)
;; Files:6 ends here



;; Refile targets are all agenda files, plus my project files. I fine-tune the considered headings to prevent human error when choosing the new location.


;; [[file:my-org-config.org::*Files][Files:7]]
(setq org-refile-targets (quote (
                                 (org-agenda-files :maxlevel . 2)
                                 )))
;; Files:7 ends here

;; Capture
;; Store new notes at the beginning of a file or entry.


;; [[file:my-org-config.org::*Capture][Capture:1]]
(setq org-reverse-note-order t)
;; Capture:1 ends here



;; These are my custom capture templates.


;; [[file:my-org-config.org::*Capture][Capture:2]]
(setq org-capture-templates '(("t" "Todo [inbox]"
                                entry
                                (file "~/org/inbox.org")
                                "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n  %i\n")
                              ("n" "Notable change/fact"
                                entry
                                (file "~/org/changelog.org")
                                "* %? \n:PROPERTIES:\n:CREATED: %U\n:END:\n  %i\n")
                              ("l" "Link currently stored [inbox]"
                                entry
                                (file "~/org/inbox.org")
                                "* TODO %i%?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\%A\n%i\n")
                              ("f" "Feedback note"
                                entry
                                (file "~/org/feedback.org")
                                "* Feedback for: %^{prompt}\n:PROPERTIES:\n:CREATED: %U\n:END:\n- [ ] %?\n\n")))
;; Capture:2 ends here

;; Agenda
;; Enable [[https://github.com/alphapapa/org-super-agenda][org-super-agenda]] mode.


;; [[file:my-org-config.org::*Agenda][Agenda:1]]
(org-super-agenda-mode)
;; Agenda:1 ends here



;; Disable the [[https://github.com/alphapapa/org-super-agenda/issues/112#issuecomment-548224512][super agenda header map]].


;; [[file:my-org-config.org::*Agenda][Agenda:2]]
(setq org-super-agenda-header-map nil)
;; Agenda:2 ends here



;; Show warnings for deadlines 7 days in advance.


;; [[file:my-org-config.org::*Agenda][Agenda:3]]
(setq org-deadline-warning-days 7)
;; Agenda:3 ends here



;; Use a straight line as separator for between agenda blocks.
;; See [[https://www.utf8-chartable.de/unicode-utf8-table.pl?start=9472&utf8=dec&unicodeinhtml=dec][Unicode/UTF-8-character table]].


;; [[file:my-org-config.org::*Agenda][Agenda:4]]
(setq org-agenda-block-separator 9472)
;; Agenda:4 ends here



;; Don't show scheduled items in agenda when they are in a =DONE= state.


;; [[file:my-org-config.org::*Agenda][Agenda:5]]
(setq org-agenda-skip-scheduled-if-done t)
;; Agenda:5 ends here



;; Agenda view starts today and +7 days.


;; [[file:my-org-config.org::*Agenda][Agenda:6]]
(setq org-agenda-start-on-weekday nil)
;; Agenda:6 ends here



;; Map the custom agenda commands to keys.


;; [[file:my-org-config.org::*Custom Agenda Views][Custom Agenda Views:4]]
(setq org-agenda-custom-commands '(
    ("h" "IOKI DASHBOARD"
     ((agenda "" (
                  (org-agenda-overriding-header "THIS WEEK")
                  (org-agenda-span 'day)
                  (org-agenda-scheduled-leaders '("   " "%2dx"))
                  ))
      (tags "+inbox"
            ((org-agenda-overriding-header "INBOX: Entries to refile")))
      (todo "VERIFY"
            ((org-agenda-overriding-header "FINAL VERIFICATION PENDING")))
      )
     )
    ("w" "WEEKLY REVIEW"
     (
      (todo "DONE"
            (
             (org-agenda-overriding-header "DONE!")
     ))
      (todo "CANCELLED"
            ((org-agenda-overriding-header "CANCELLED")))
      (todo "TODO"
            ((org-agenda-overriding-header "TODO Items (without time attached)")
             (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled 'timestamp))))
      (todo "WAIT"
            ((org-agenda-overriding-header "WAIT: Items on hold (without time attached)")
             (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled 'timestamp))))
      )
     )
    ("d" "DAILY"
     ((agenda "" ((org-agenda-span 'day)
                  (org-agenda-compact-blocks t)
                  ;; (org-agenda-deadline-leaders)
                  ;; (org-agenda-scheduled-leaders)
                  (org-agenda-prefix-format '(
                                              (agenda . "  %?-12t")
                                              ))
                  (org-super-agenda-groups
                   '(
                     (:name "⏰ Calendar" :time-grid t)
                     (:name "Optional" :priority "C" :order 90)
                     (:name "📚 Tickets" :category "Tickets" :order 80)
     
                     (:name "⚠ Overdue!" :deadline past)
                     (:name "⚠ Overdue!" :scheduled past)
     
                     ;; Discard full-day events from agenda
                     (:discard (:category "Cal"))
     
                     (:name "⭐ Next" :todo "NEXT")
                     (:name "⭐ Important" :priority "A")
                     (:name "📌 Routines" :category "Routines")
     
                     (:auto-category t)
                     ))
                  ))
      (alltodo "" ((org-agenda-overriding-header "")
                   (org-agenda-prefix-format '(
                                               (todo . "  ")
                                               ))
                   (org-super-agenda-groups
                    '(
                      (:name "🌆 End of day" :todo "ENDOFDAY")
                      (:name "Inbox" :tag "inbox")
                      (:name "Verify" :todo "VERIFY")
                      (:discard (:anything t))
                      )
                    ))))
     )
    ))
;; Custom Agenda Views:4 ends here

;; Appearance
;; Show the filename and outline path in helm when refiling an entry.
;; Also refile in one step (makes much more sense for helm).


;; [[file:my-org-config.org::*Appearance][Appearance:1]]
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
;; Appearance:1 ends here



;; The header line appears, optionally, at the top of a window, analogous to mode line.
;; Hack to give some vertical space at the top of each buffer.


;; [[file:my-org-config.org::*Appearance][Appearance:2]]
(setq header-line-format " ")
;; Appearance:2 ends here



;; Folding symbol for the headings.


;; [[file:my-org-config.org::*Appearance][Appearance:3]]
(setq org-ellipsis "  ")
;; Appearance:3 ends here



;; Show actually /italicized/ text instead of =/italicized text/=.


;; [[file:my-org-config.org::*Appearance][Appearance:4]]
(setq org-hide-emphasis-markers t)
;; Appearance:4 ends here



;; Fontify (aka "highlight, change appearance via font settings") the whole line for headings.
;; This is useful when setting a background color for the =org-level-*= faces.


;; [[file:my-org-config.org::*Appearance][Appearance:5]]
(setq org-fontify-whole-heading-line t)
;; Appearance:5 ends here



;; Change the face of a headline if it is marked =DONE=.
;; Normally, only the TODO/DONE keyword indicates the state of a headline.
;; When this is non-nil, the headline after the keyword is set to the =org-headline-done= as an additional indication.


;; [[file:my-org-config.org::*Appearance][Appearance:6]]
(setq org-fontify-done-headline t)
;; Appearance:6 ends here



;; Add a special face to =#+begin_quote= and =#+begin_verse= block.


;; [[file:my-org-config.org::*Appearance][Appearance:7]]
(setq org-fontify-quote-and-verse-blocks t)
;; Appearance:7 ends here



;; Set bullet glyphs for Org headings via [[https://github.com/integral-dw/org-superstar-mode#org-superstar-headline-bullets-list][org-superstar-mode]].


;; [[file:my-org-config.org::*Appearance][Appearance:8]]
(setq org-superstar-headline-bullets-list '("⬢" "◆" "▲" "■"))
;; Appearance:8 ends here



;; Show tags directly after headings (not on the right), which plays nicer with line-wrapping.


;; [[file:my-org-config.org::*Appearance][Appearance:9]]
(setq org-tags-column 0)
;; Appearance:9 ends here



;; Set a wider body witdh for =olivetti-mode=.


;; [[file:my-org-config.org::*Appearance][Appearance:10]]
(setq olivetti-body-width 81)
;; Appearance:10 ends here

;; Faces
;; Faces for =TODO= states. The colors are based on the [[https://github.com/dracula/emacs][Dracula theme for Emacs]].


;; [[file:my-org-config.org::*Faces][Faces:1]]
(let* (
       (comment      "#6272a4")
       (warning      "#ffb86c")
       (rainbow-1    "#f8f8f2")
       (rainbow-2    "#8be9fd")
       (rainbow-3    "#bd93f9")
       (rainbow-4    "#ff79c6")
       (rainbow-5    "#ffb86c")
       (rainbow-6    "#50fa7b")
       (rainbow-7    "#f1fa8c")
       (rainbow-8    "#0189cc")
       (rainbow-9    "#ff5555")
       (rainbow-10   "#a0522d")

       (variable-pitch-font `(:family "iA Writer Quattro S" ))
       (fixed-pitch-font    `(:family "Fira Mono" ))
       (fixed-pitch-font-alt `(:family "iA Writer Mono S" )))

  (setq org-todo-keyword-faces (list
                              `("TODO"
                                ,@fixed-pitch-font
                                :foreground ,comment
                                :weight bold
                                )
                              `("NEXT"
                                ,@fixed-pitch-font
                                :foreground ,warning
                                :weight bold)
                              `("WAIT"
                                ,@fixed-pitch-font
                                :foreground ,rainbow-2
                                :weight bold)
                              `("VERIFY"
                                ,@fixed-pitch-font
                                :foreground ,rainbow-7
                                :weight bold)
                              `("ENDOFDAY"
                                ,@fixed-pitch-font
                                :foreground ,rainbow-3
                                :weight bold)
                              `("LOWPRIO"
                                ,@fixed-pitch-font
                                :foreground ,comment
                                :weight bold)
                              `("DONE"
                                ,@fixed-pitch-font
                                :foreground ,rainbow-6
                                :weight bold)
                              `("CANCELLED"
                                ,@fixed-pitch-font
                                :foreground ,rainbow-9
                                :weight bold)
                              ))
)
;; Faces:1 ends here

;; Babel
;; Syntax highlightning in code blocks


;; [[file:my-org-config.org::*Babel][Babel:1]]
(setq org-src-fontify-natively t)
;; Babel:1 ends here



;; Trying to fix indentation behaviour within code blocks.


;; [[file:my-org-config.org::*Babel][Babel:2]]
(setq org-edit-src-content-indentation 0)
(setq org-src-tab-acts-natively t)
(setq org-src-preserve-indentation t)
;; Babel:2 ends here



;; Allow babel code execution without confirming it every time.


;; [[file:my-org-config.org::*Babel][Babel:3]]
(setq org-confirm-babel-evaluate nil)
;; Babel:3 ends here



;; Available embedded languages for babel.


;; [[file:my-org-config.org::*Babel][Babel:4]]
(org-babel-do-load-languages 'org-babel-load-languages
                              '((sql . t)
                                (shell . t)
                                (dot . t)
                                (emacs-lisp . t)
                                (ruby . t)
                                (js . t)
                                (jq . t)
                                (mermaid . t)
                                (plantuml . t)))
;; Babel:4 ends here



;; PlantUML settings for generating diagrams. It needs to know the path to the installed PlantUML =jar=, in this case installed via =homebrew=, so this path is available by calling =brew info plantuml=.


;; [[file:my-org-config.org::*Babel][Babel:5]]
(setq org-plantuml-jar-path "/usr/local/Cellar/plantuml/1.2018.3/libexec/plantuml.jar")
;; Babel:5 ends here



;; Mermaid settings for generating diagrams. It needs to know the path to the installed  =mermaid cli=, in this case installed via =homebrew=, so this path is available by calling =brew info mermaid-cli=.


;; [[file:my-org-config.org::*Babel][Babel:6]]
(setq ob-mermaid-cli-path "/usr/local/bin/mmdc")
;; Babel:6 ends here

;; Export
;; Do not inline CSS code when generating HTML exports. Instead, the CSS of the chosen theme will be used. This especially applies to fontified code blocks.


;; [[file:my-org-config.org::*Export][Export:1]]
(setq org-html-htmlize-output-type 'css)
;; Export:1 ends here

;; Attachments
;; Org download should use the attachment features to save the images.


;; [[file:my-org-config.org::*Attachments][Attachments:1]]
(setq org-download-method 'attach)
;; Attachments:1 ends here

;; Encryption
;; The package =org-crypt= allows to encrypt subtrees using =GPG=.


;; [[file:my-org-config.org::*Encryption][Encryption:1]]
(require 'org-crypt)
;; Encryption:1 ends here



;; Prevent the crypt tag from using inheritance so that there is no encrypted data inside encrypted data.


;; [[file:my-org-config.org::*Encryption][Encryption:2]]
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; Encryption:2 ends here



;; Set GPG key to use for encryption


;; [[file:my-org-config.org::*Encryption][Encryption:3]]
(setq org-crypt-key "821280F4")
;; Encryption:3 ends here



;; Encrypt all entries before saving.


;; [[file:my-org-config.org::*Encryption][Encryption:4]]
(org-crypt-use-before-save-magic)
;; Encryption:4 ends here



;; Disable auto-save-mode for the current buffer prior to decrypting an entry.


;; [[file:my-org-config.org::*Encryption][Encryption:5]]
(setq org-crypt-disable-auto-save t)
;; Encryption:5 ends here



;; Set crypt as default tag available in Org files.


;; [[file:my-org-config.org::*Encryption][Encryption:6]]
(setq org-tag-alist '(("crypt" . ?c)))
;; Encryption:6 ends here



;; Add keybindings for encrypting and decrypting a subtree.


;; [[file:my-org-config.org::*Encryption][Encryption:7]]
(spacemacs/set-leader-keys-for-major-mode
  'org-mode "se" 'org-encrypt-entry)

(spacemacs/set-leader-keys-for-major-mode
  'org-mode "sd" 'org-decrypt-entry)
;; Encryption:7 ends here

;; Misc Keybindings
;; Allows to change the =TODO= state of a task via =, k=.


;; [[file:my-org-config.org::*Misc Keybindings][Misc Keybindings:1]]
(spacemacs/set-leader-keys-for-major-mode
  'org-mode "k" 'org-todo)
;; Misc Keybindings:1 ends here



;; Adds [[https://github.com/unhammer/org-rich-yank][org-rich-yank]].


;; [[file:my-org-config.org::*Misc Keybindings][Misc Keybindings:2]]
(spacemacs/set-leader-keys-for-major-mode
  'org-mode "ir" 'org-rich-yank)
;; Misc Keybindings:2 ends here

;; Finalization
;; In the end, satisfy the Spacemacs loading mechanism.


;; [[file:my-org-config.org::*Finalization][Finalization:1]]
(provide 'my-org-config)
;; Finalization:1 ends here
