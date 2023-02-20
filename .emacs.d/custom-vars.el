(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine 'xetex)
 '(TeX-source-correlate-method 'synctex)
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-html "xdg-open")
     (output-pdf "Evince")))
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-term-color-vector
   [unspecified "#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "#78dce8" "#ab9df2" "#a1efe4" "#fcfcfa"] t)
 '(awesome-tray-mode-line-active-color "#2fafff")
 '(awesome-tray-mode-line-inactive-color "#323232")
 '(beacon-color "#cc6666")
 '(blink-cursor-mode nil)
 '(column-number-mode 1)
 '(compilation-message-face 'default)
 '(custom-enabled-themes nil)
 '(default-input-method "greek")
 '(delete-selection-mode nil)
 '(diary-entry-marker 'font-lock-variable-name-face)
 '(display-battery-mode t)
 '(display-time-mode t)
 '(eterm-256color-disable-bold nil)
 '(flymake-error-bitmap '(flymake-double-exclamation-mark modus-theme-fringe-red))
 '(flymake-note-bitmap '(exclamation-mark modus-theme-fringe-cyan))
 '(flymake-warning-bitmap '(exclamation-mark modus-theme-fringe-yellow))
 '(frame-background-mode 'dark)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type 'cabal-repl)
 '(highlight-changes-colors '("#ff8eff" "#ab7eff"))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    '("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2")))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   '(("#424748" . 0)
     ("#63de5d" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#424748" . 100)))
 '(hl-bg-colors
   '("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342"))
 '(hl-fg-colors
   '("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3"))
 '(hl-paren-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(rustic yasnippet dirvish julia-snail org-pdfview prettify-greek prettify-math prettify-symbols-mode sly weblorg multi-vterm fira-code-mode dired dashboard hindent eshell-syntax-highlighting fish-completion vterm eglot eglot-jl smart-mode-line-atom-one-dark-theme smart-mode-line mood-line telephone-line minions exec-path-from-shell which-key lps-ui lsp-clients company-lsp lsp-haskell one-themes tuareg quelpa spaceline-config esh-autosuggest all-the-icons-ibuffer all-the-icons-ivy-rich cargo toml-mode lsp-ui company spaceline monokai-pro-theme monokai-theme org-bullets powerline spacemacs-theme swiper julia-mode use-package xterm-color julia-repl diredful ivy-rich modus-operandi-theme modus-vivendi-theme pdf-view rg desktop-environment exwm doom-modeline doom-themes alect-themes color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow dired-subtree all-the-icons-dired all-the-icons-ivy all-the-icons monokai-alt-theme god-mode dired-narrow lsp-julia lsp-mode markdown-mode dash-functional flycheck-julia openwith magit racer flycheck-rust rust-mode web-mode dante shell-switcher multi-eshell better-shell dired-ranger ox-reveal org iedit expand-region counsel org-reveal flymake-hlint haskell-mode utop merlin solarized-theme gruvbox-theme color-theme-solarized hc-zenburn-theme auctex racket-mode eterm-256color dired-single slime-company spaceline-all-the-icons smart-mode-line-powerline-theme distinguished-theme dakrone-theme badger-theme firecode-theme darkokai-theme atom-one-dark-theme atom-dark-theme afternoon-theme))
 '(pdf-misc-print-program-args '("-o media=A4"))
 '(pdf-misc-print-program-executable "/usr/bin/lpr")
 '(pdf-misc-print-programm "/usr/bin/lpr")
 '(pdf-misc-print-programm-args '("-o media=A4"))
 '(pos-tip-background-color "#E6DB74")
 '(pos-tip-foreground-color "#242728")
 '(server-mode t)
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tetris-x-colors
   [[229 192 123]
    [97 175 239]
    [209 154 102]
    [224 108 117]
    [152 195 121]
    [198 120 221]
    [86 182 194]])
 '(tool-bar-mode nil)
 '(vc-annotate-background-mode nil)
 '(vterm-max-scrollback 10000)
 '(weechat-color-list
   (unspecified "#242728" "#424748" "#F70057" "#ff0066" "#86C30D" "#63de5d" "#BEB244" "#E6DB74" "#40CAE4" "#06d8ff" "#FF61FF" "#ff8eff" "#00b2ac" "#53f2dc" "#f8fbfc" "#ffffff"))
 '(window-divider-mode nil)
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka Term SS12" :foundry "UKWN" :slant normal :weight normal :height 173 :width normal))))
 '(eterm-256color-blue ((t (:foreground "#268bd2"))))
 '(eterm-256color-bright-black ((t (:foreground "#fdf6e3" :weight semi-bold))))
 '(eterm-256color-bright-blue ((t (:foreground "DodgerBlue1" :weight semi-bold))))
 '(eterm-256color-bright-cyan ((t (:foreground "cyan2" :weight semi-bold))))
 '(eterm-256color-bright-green ((t (:foreground "green" :weight semi-bold))))
 '(eterm-256color-bright-magenta ((t (:foreground "#6c71c4" :weight semi-bold))))
 '(eterm-256color-bright-red ((t (:foreground "red" :weight semi-bold))))
 '(eterm-256color-bright-white ((t (:foreground "white" :weight semi-bold))))
 '(eterm-256color-bright-yellow ((t (:foreground "yellow" :weight semi-bold))))
 '(eterm-256color-cyan ((t (:foreground "#2aa198"))))
 '(eterm-256color-green ((t (:foreground "SpringGreen2"))))
 '(eterm-256color-magenta ((t (:foreground "#d33682"))))
 '(eterm-256color-red ((t (:foreground "#dc322f"))))
 '(eterm-256color-white ((t (:foreground "white"))))
 '(eterm-256color-yellow ((t (:foreground "#b58900"))))
 '(mode-line ((t (:family "Iosevka SS02" :foundry "UKWN" :slant normal :weight semi-bold :height 160 :width normal))))
 '(mode-line-inactive ((t (:family "Iosevka SS02" :foundry "UKWN" :slant normal :weight semi-bold :height 160 :width normal))))
 '(term ((t nil)))
 '(term-color-black ((t (:background "black" :foreground "#3F3F3F"))))
 '(term-color-blue ((t (:background "black" :foreground "#7CB8BB"))))
 '(term-color-cyan ((t (:foreground "#93E0E3" :background "#8CD0D3"))))
 '(term-color-green ((t (:foreground "#7F9F7F" :background "#9FC59F"))))
 '(term-color-magenta ((t (:foreground "#DC8CC3" :background "#CC9393"))))
 '(term-color-red ((t (:foreground "#AC7373" :background "#8C5353"))))
 '(term-color-white ((t (:foreground "#DCDCCC" :background "#656555"))))
 '(term-color-yellow ((t (:foreground "#DFAF8F" :background "#9FC59F"))))
 '(term-default-bg-color ((t (:inherit term-color-black))))
 '(term-default-fg-color ((t (:inherit term-color-white)))))

(provide 'custom-vars)
;;; custom-vars.el ends here
