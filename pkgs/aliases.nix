{ lib, helixPlugins }:
let
  warnAlias =
    old: new:
    lib.warnOnInstantiate
      "helixPlugins.${old} is deprecated and has been renamed to helixPlugins.${new}"
      helixPlugins.${new};
in
{
  anchor = warnAlias "anchor" "anchor-hx";
  breadcrumbs = warnAlias "breadcrumbs" "breadcrumbs-hx";
  case = warnAlias "case" "case-hx";
  cliff = warnAlias "cliff" "cliff-hx";
  codesnap = warnAlias "codesnap" "codesnap-hx";
  context = warnAlias "context" "context-hx";
  devicons = warnAlias "devicons" "devicons-hx";
  emotional = warnAlias "emotional" "emotional-hx";
  eval = warnAlias "eval" "eval-hx";
  expansions = warnAlias "expansions" "expansions-hx";
  extend-sibling = warnAlias "extend-sibling" "extend-sibling-hx";
  fake-warp = warnAlias "fake-warp" "fake-warp-hx";
  flash = warnAlias "flash" "flash-hx";
  forest = warnAlias "forest" "forest-hx";
  fresco = warnAlias "fresco" "fresco-hx";
  glyph = warnAlias "glyph" "glyph-hx";
  grove = warnAlias "grove" "grove-hx";
  hetex = warnAlias "hetex" "hetex-hx";
  http = warnAlias "http" "http-hx";
  http2curl = warnAlias "http2curl" "http2curl-scm";
  insert-literal = warnAlias "insert-literal" "insert-literal-hx";
  lsp-picker = warnAlias "lsp-picker" "lsp-picker-hx";
  matte = warnAlias "matte" "matte-hx";
  microscope = warnAlias "microscope" "microscope-hx";
  modeline = warnAlias "modeline" "modeline-hx";
  moka = warnAlias "moka" "moka-hx";
  monaspace = warnAlias "monaspace" "monaspace-hx";
  notify = warnAlias "notify" "notify-hx";
  nrepl = warnAlias "nrepl" "nrepl-hx";
  ogre = warnAlias "ogre" "ogre-hx";
  oil = warnAlias "oil" "oil-hx";
  paredit = warnAlias "paredit" "paredit-hx";
  presence = warnAlias "presence" "presence-hx";
  previously = warnAlias "previously" "previously-hx";
  repl-ui = warnAlias "repl-ui" "repl-ui-hx";
  run-command = warnAlias "run-command" "run-command-scm";
  run-shell = warnAlias "run-shell" "run-shell-hx";
  scooter = warnAlias "scooter" "scooter-hx";
  scopeline = warnAlias "scopeline" "scopeline-hx";
  select-ts = warnAlias "select-ts" "select-ts-hx";
  show-keys = warnAlias "show-keys" "show-keys-hx";
  smooth-scroll = warnAlias "smooth-scroll" "smooth-scroll-hx";
  streal = warnAlias "streal" "streal-hx";
  switch = warnAlias "switch" "switch-hx";
  switcheroo = warnAlias "switcheroo" "switcheroo-hx";
  trail = warnAlias "trail" "trail-hx";
  ts-utils = warnAlias "ts-utils" "ts-utils-hx";
  ui-utils = warnAlias "ui-utils" "ui-utils-hx";
  vim = warnAlias "vim" "vim-hx";
  vista = warnAlias "vista" "vista-hx";
  wakatime = warnAlias "wakatime" "wakatime-hx";
  who = warnAlias "who" "who-hx";
  yank-flash = warnAlias "yank-flash" "yank-flash-hx";
  zen-mode = warnAlias "zen-mode" "zen-mode-hx";
}
