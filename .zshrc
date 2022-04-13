LANG='en_US.UTF-8'

# use bash default value for history
HISTSIZE=1000
SAVEHIST=2000
HISTFILE=~/.zsh_history

# remove any calls to compinit as zsh-autocomplete suggests
# autoload -Uz compinit && compinit # built-in one
# diaable it for ubuntu
skip_global_compinit=1

# + Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# + option settings
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

# commands
zinit light agkozak/zsh-z
zinit snippet OMZP::command-not-found
zinit snippet OMZP::common-aliases
zinit snippet OMZP::safe-paste
zinit snippet OMZP::extract
zinit snippet OMZP::copypath
# terminal
zinit snippet OMZP::colorize
zinit snippet OMZP::copybuffer
# systematic
zinit snippet OMZP::git
zinit ice as"completion"; zinit snippet OMZP::docker/_docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::aws
# php
zinit snippet OMZP::composer
zinit snippet OMZP::laravel
# Python
zinit snippet OMZP::python
zinit snippet OMZP::pip
zinit snippet OMZP::pipenv
zinit snippet OMZP::poetry

# zsh installable plugins
zinit ice lucid wait='5'; zinit light zsh-users/zsh-syntax-highlighting
zinit ice lucid wait='0' atload='_zsh_autosuggest_start'; zinit light zsh-users/zsh-autosuggestions
zinit ice lucid wait='5'; zinit light MichaelAquilina/zsh-you-should-use
zinit ice blockf; zinit light marlonrichert/zsh-autocomplete
zinit light Tarrasch/zsh-autoenv



# TODO: auto update self and plugins
# _zplug-check-interval() {
#   now=$(date +%s)
#   if [ -f "${1}" ]; then
#     last_update=$(cat "${1}")
#   else
#     last_update=0
#   fi
#   interval=$(expr ${now} - ${last_update})
#   echo "${interval}"
# }

# _zplug-check-for-updates() {
#   if [ -z "${ZPLUG_PLUGIN_UPDATE_DAYS}" ]; then
#     ZPLUG_PLUGIN_UPDATE_DAYS=14
#   fi

#   if [ -z "${ZPLUG_PLUGIN_UPDATE_FILE}" ]; then
#     ZPLUG_PLUGIN_UPDATE_FILE="${ZPLUG_HOME:-}/.zplug_plugin_lastupdate"
#   fi

#   local day_seconds=$(expr 24 \* 60 \* 60)
#   local plugins_seconds=$(expr ${day_seconds} \* ${ZPLUG_PLUGIN_UPDATE_DAYS})

#   local last_plugin=$(_zplug-check-interval ${ZPLUG_PLUGIN_UPDATE_FILE})

#   if [ ${last_plugin} -gt ${plugins_seconds} ]; then
#     echo "It has been $(expr ${last_plugin} / $day_seconds) days since your zplug plugins were updated"
#     zplug update

#     date +%s >! ${ZPLUG_PLUGIN_UPDATE_FILE}
#     zplug clean --force
#   fi
# }

# zmodload zsh/system
# lockfile=${ZPLUG_HOME:-~}/.zplug_autoupdate_lock
# touch $lockfile
# if ! which zsystem &> /dev/null || zsystem flock -t 1 $lockfile; then
#   _zplug-check-for-updates
#   command rm -f $lockfile
# fi

# use ag for FZF and ignore some files
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

# User configuration
# Preferred editor for local and remote sessions
# example:
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
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

# shortcut to backup vimrc and zshrc, then  update to dropbox
alias vimrc_publish="/bin/cp -f ~/.vimrc ~/.vimrc.bak; cp ~/.vimrc ~/Dropbox/.vimrc"
alias zshrc_publish="/bin/cp -f ~/.zshrc ~/.zshrc.bak; cp ~/.zshrc ~/Dropbox/.zshrc"

# shortcut to apply vimrc and zshrc changes from Dropbox after backup
alias vimrc_apply="cp ~/.vimrc ~/.vimrc.bak; cp ~/Dropbox/.vimrc ~/.vimrc"
alias zshrc_apply="cp ~/.zshrc ~/.zshrc.bak; cp ~/Dropbox/.zshrc ~/.zshrc"

# eval $(thefuck --alias)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
