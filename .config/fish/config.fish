# Disables fish greeting
set -U fish_greeting

# Abbreviations
abbr -a delstore "find . -name 'DS_Store' -type f -delete"
# x86 brew directory
abbr -a ibrew /usr/local/bin/brew
# Delete TimeMachine local snapshots
abbr -a del_tm_snapshot tmutil listlocalsnapshotdates | awk '{ if (NR>1) {system("tmutil deletelocalsnapshots " $1)}}'
# exa abbreviations
abbr -a ls "exa"
abbr -a lsi "exa --icons"


# PATH
fish_add_path ~/.local/dev/flutter
fish_add_path /opt/homebrew/bin/
fish_add_path ~/.local/bin/
fish_add_path ~/.ghcup/bin/

# Syntax highlighting
set fish_color_error red --underline 

# Colors
set fish_pager_color_selected_background --background=5A5A5A -d
set fish_pager_color_selected_prefix 028DB8 
set fish_color_command 70B431
set fish_color_quote 00FFD6

# Vi-mod
fish_default_key_bindings
# fish_vi_key_bindings insert
# set fish_cursor_insert line
# set fish_cursor_replace_one underscore

# Environment variables
set -xg VISUAL nvim
# fucking java
set -xg JAVA_HOME /Users/luis/Library/Java/JavaVirtualMachines/openjdk-16.0.1/Contents/Home
# Set bat as pager
set -xg MANPAGER "sh -c 'col -bx | bat -l man -p'"
# NVM
set -xg NVM_DIR $HOME/.nvm

# Starship prompt
starship init fish | source
