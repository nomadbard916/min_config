# + Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# + global settings
export LANG='en_US.UTF-8'

# use both emacs and vim key binding
bindkey -e
bindkey -v

# use bash default value for history
export HISTSIZE=1000
export SAVEHIST=2000
export HISTFILE=~/.zsh_history

# remove any calls to compinit as zsh-autocomplete suggests
# autoload -Uz compinit && compinit # built-in one
# diaable it for ubuntu
skip_global_compinit=1

# set ZINIT_HOME for easier manipulation, like ZPLUG_HOME does
export ZINIT_HOME=$HOME/.local/share/zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# + zsh options
# see zshoptions(1) for details on what these do
# see also zshexpn(1) for details on how globbing works
setopt append_history # better concurrent shell history sharing
setopt auto_pushd # cd foo; cd bar; popd --> in foo again
setopt complete_in_word # more intuitive completions
setopt no_beep # BEEP
setopt extended_glob # better globs
setopt extended_history # better history
# setopt glob_complete # (see manual for description & tradeoffs)
setopt glob_star_short # ** means **/*, **/ means directory only **
setopt hist_expire_dups_first # don't fill your history as quickly with junk
setopt hist_ignore_space # ` command` doesn't save to history
setopt hist_subst_pattern # better globs / parameter expansion
setopt hist_reduce_blanks # `a  b` normalizes to `a b` in history
setopt hist_verify # reduce oops I sudoed the wrong thing
# setopt hist_ignore_all_dups # If a new command line being added to the history list duplicates an older one, the older command is removed from the list (even if it is not the previous event).
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt share_history             # Share history between all sessions.
setopt interactive_comments # so pasting live to test works
setopt ksh_glob # better globs
setopt long_list_jobs # easier to read job stuff
setopt null_glob # sane globbing
setopt pipe_fail # fail when the first command in a pipeline fails
setopt share_history # better concurrent shell history sharing
setopt no_rm_star_silent # confirm on `rm *` (default, but let's be safe)
setopt prompt_cr prompt_sp # don't clobber output without trailing newlines
setopt MENU_COMPLETE
setopt no_list_ambiguous

# + zinit plugin list
zinit ice depth"1"; zinit light romkatv/powerlevel10k

# plugins with installable packages
zinit ice as"completion"; zinit snippet OMZP::ag/_ag
zinit ice lucid wait='3'; zinit snippet OMZP::fzf
# needs Pygments (default) or Chroma
# zinit ice lucid wait='3'; zinit snippet OMZP::colorize  

# commands
zinit light agkozak/zsh-z
zinit snippet OMZP::command-not-found
zinit snippet OMZL::directories.zsh
zinit snippet OMZP::common-aliases
zinit snippet OMZP::safe-paste
# copy functionalities with command 'clipcopy' provided by the first library
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZP::copybuffer
zinit snippet OMZP::copypath
# zinit snippet OMZP::extract

# terminal
zinit snippet OMZL::theme-and-appearance.zsh

# systematic
zinit snippet OMZP::git
zinit ice as"completion"; zinit snippet OMZP::docker/_docker
zinit snippet OMZP::docker-compose
# zinit snippet OMZP::aws

# php
zinit snippet OMZP::composer
zinit snippet OMZP::laravel

# Python
zinit snippet OMZP::python
zinit snippet OMZP::pip
zinit snippet OMZP::pipenv
zinit snippet OMZP::poetry

# zsh installable plugins
zinit ice lucid wait='0' atload='_zsh_autosuggest_start'; zinit light zsh-users/zsh-autosuggestions
zinit ice lucid wait='5'; zinit light MichaelAquilina/zsh-you-should-use
# give up on 'zinit ice blockf' for this plugin as it destroys intellij's terminal
zinit light marlonrichert/zsh-autocomplete
zinit light Tarrasch/zsh-autoenv
# deprecated, this might not be powerful enough
# zinit ice lucid wait='5'; zinit light zsh-users/zsh-syntax-highlighting
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting

# 'softmoth/zsh-vim-mode' and 'softmoth/zsh-vim-mode' both break autosugestion


# + auto update zinit and plugins
# the snippets were borrowed from somewhere I forgot, 
# with zplug as the original implementation target
_zinit-check-interval() {
  now=$(date +%s)
  if [ -f "${1}" ]; then
    last_update=$(cat "${1}")
  else
    last_update=0
  fi
  interval=$(expr ${now} - ${last_update})
  echo "${interval}"
}

_zinit-check-for-updates() {
  if [ -z "${ZINIT_PLUGIN_UPDATE_DAYS}" ]; then
    ZINIT_PLUGIN_UPDATE_DAYS=14
  fi

  if [ -z "${ZINIT_PLUGIN_UPDATE_FILE}" ]; then
    ZINIT_PLUGIN_UPDATE_FILE="${ZINIT_HOME:-}/.zinit_plugin_lastupdate"
  fi

  local day_seconds=$(expr 24 \* 60 \* 60)
  local plugins_seconds=$(expr ${day_seconds} \* ${ZINIT_PLUGIN_UPDATE_DAYS})

  local last_plugin=$(_zinit-check-interval ${ZINIT_PLUGIN_UPDATE_FILE})

  if [ ${last_plugin} -gt ${plugins_seconds} ]; then
    echo "It has been $(expr ${last_plugin} / $day_seconds) days since your zinit plugins were updated"
    zinit self-update
    zinit update --all --parallel 50

    date +%s >! ${ZINIT_PLUGIN_UPDATE_FILE}
  fi
}

zmodload zsh/system
lockfile=${ZINIT_HOME:-~}/.zinit_autoupdate_lock
touch $lockfile
if ! which zsystem &> /dev/null || zsystem flock -t 1 $lockfile; then
  _zinit-check-for-updates
  command rm -f $lockfile
fi

# use ag for FZF and ignore some files
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# + set ailases
alias ptt="ssh bbsu@ptt.cc"

# separate aliases
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# separate paths, especially remove redundant ones by WSL2
if [ -f ~/.zsh_paths ]; then
    source ~/.zsh_paths
fi

# shortcut to vimrc
alias vimrc="vim ~/.vimrc"
# alias zshrc="vim ~/.zshrc" # this command is already in common aliases
 
# You need to export MIN_CONFIG_PATH first to use below aliases. I personally put it in ~/.zsh_paths
alias cdmc="cd $MIN_CONFIG_PATH"

# Shortcut to publish vimrc, zshrc, and ideavimrc config by backup first, then: 
# former two update to MIN_CONFIG_PATH, which is assigned in ~/.zsh_paths.
# ideavimrc needs to assign IDEAVIMRC_PATH_LOCAL AND IDEAVIMRC_PATH_REMOTE first in ~/.zsh_paths, then just copy
zcp(){
     /bin/cp -f ~/.zshrc ~/.zshrc.bak && cp ~/.zshrc $MIN_CONFIG_PATH/.zshrc && 
         cd $MIN_CONFIG_PATH && 
         git commit -am $1 && git push && 
         cd -
}
vcp(){
    /bin/cp -f ~/.vimrc ~/.vimrc.bak && cp ~/.vimrc $MIN_CONFIG_PATH/.vimrc && 
        cd $MIN_CONFIG_PATH && 
        git commit -am $1 && git push && 
        cd -
}
# TODO: make symlink for these paths
if [[ -d $IDEAVIMRC_PATH_LOCAL ]] && [[ -d $IDEAVIMRC_PATH_REMOTE ]] ; then
    alias ivcp="/bin/cp -f $IDEAVIMRC_PATH_LOCAL/.ideavimrc $IDEAVIMRC_PATH_LOCAL/.ideavimrc.bak && \
        cp $IDEAVIMRC_PATH_LOCAL/.ideavimrc $IDEAVIMRC_PATH_REMOTE/.ideavimrc"
else
    echo 'Please assign first $IDEAVIMRC_PATH_LOCAL and $IDEAVIMRC_PATH_REMOTE to make alias "ivcp" work.'
fi

# shortcut to apply vimrc, zshrc and ideavimr cconfig changes  from git repository after backup
# ideavimrc needs to assign IDEAVIMRC_PATH first in ~/.zsh_paths, which is assigned in ~/.zsh_paths
# ideavimrc needs to assign IDEAVIMRC_PATH_LOCAL AND IDEAVIMRC_PATH_REMOTE first in ~/.zsh_paths, then just copy
ZSHRC_PATH='~/.zshrc'
alias zca="cd $MIN_CONFIG_PATH && git pull && /bin/cp -f $ZSHRC_PATH $ZSHRC_PATH.bak && cp $MIN_CONFIG_PATH/.zshrc $ZSHRC_PATH && cd - && source $ZSHRC_PATH"
alias vca="cd $MIN_CONFIG_PATH && git pull && /bin/cp -f ~/.vimrc ~/.vimrc.bak && cp $MIN_CONFIG_PATH/.vimrc ~/.vimrc && cd -"
if [[ -d $IDEAVIMRC_PATH_LOCAL ]] && [[ -d $IDEAVIMRC_PATH_REMOTE ]] ; then
    alias ivca="/bin/cp -f $IDEAVIMRC_PATH_LOCAL/.ideavimrc $IDEAVIMRC_PATH_LOCAL/.ideavimrc.bak && \
        cp $IDEAVIMRC_PATH_REMOTE/.ideavimrc $IDEAVIMRC_PATH_LOCAL/.ideavimrc"
else
    echo 'Please assign first $IDEAVIMRC_PATH_LOCAL and $IDEAVIMRC_PATH_REMOTE to make alias "ivca" work.'
fi

# useful cli-gui tools
alias lzd=lazydocker
alias lzg=lazygit

# it's too slow, don't use.
# eval $(thefuck --alias)

# + p10k internal use
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
