# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

LANG='en_US.UTF-8'
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

# sane zplug installation defaults
if [[ -z "$ZPLUG_HOME" ]]; then
  ZPLUG_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zplug"
fi
if [[ -z "$ZPLUG_CACHE_DIR" ]]; then
  ZPLUG_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zplug"
fi

# Ensure zplug is installed
if [[ ! -d "$ZPLUG_HOME" ]]; then
  git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
  source "$ZPLUG_HOME/init.zsh" && zplug --self-manage update
else
  source "$ZPLUG_HOME/init.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


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


# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.



# full plugin set
# plugins=(
# # plugins with installable packages
# ag fzf z
# # commands
# command-not-found common-aliases safe-paste web-search extract copypath
# # terminal
# colored-man-pages colorize copybuffer
# # systematic
# git 
# # environments
# docker docker-compose  aws
# # PHP
# composer laravel
# # Python
# python pip pipenv poetry
# # zsh installable plugins
# zsh-autosuggestions you-should-use zsh-autocomplete 
# zsh-syntax-highlighting  # this one must be the last in plugin list
# # JS
# # npm 
# # Java
# # mvn spring

# # deprecated, left for reference
# # zsh-completions 
# # dash
# # tmux
# )

# zplug plugin list
# zplug itself
zplug "zplug/zplug", hook-build: "zplug --self-manage"
# theme, maybe use powerlevel10k later
# zplug "themes/ys", from:oh-my-zsh, as:theme
zplug romkatv/powerlevel10k, as:theme, depth:1

# oh-my-zsh plugins
# plugins with installable packages
zplug "plugins/ag", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
# commands
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/safe-paste", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/copypath", from:oh-my-zsh
# terminal
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/copybuffer", from:oh-my-zsh
# systematic
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/svn", from:oh-my-zsh # dummy plugin to supress error msg only 
# environments
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/aws", from:oh-my-zsh
# php
zplug "plugins/composer", from:oh-my-zsh
zplug "plugins/laravel", from:oh-my-zsh
# Python
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/pippipenv", from:oh-my-zsh
zplug "plugins/poetry", from:oh-my-zsh

# zsh installable plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2  # (defer:2 means syntax-highlighting gets loaded after completions)
zplug "zsh-users/zsh-autosuggestions"
zplug "MichaelAquilina/zsh-you-should-use"
zplug "marlonrichert/zsh-autocomplete"
zplug "Tarrasch/zsh-autoenv"
zplug "hlissner/zsh-autopair"

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load

# zplug auto update plugin
_zplug-check-interval() {
  now=$(date +%s)
  if [ -f "${1}" ]; then
    last_update=$(cat "${1}")
  else
    last_update=0
  fi
  interval=$(expr ${now} - ${last_update})
  echo "${interval}"
}

_zplug-check-for-updates() {
  if [ -z "${ZPLUG_PLUGIN_UPDATE_DAYS}" ]; then
    ZPLUG_PLUGIN_UPDATE_DAYS=14
  fi

  if [ -z "${ZPLUG_PLUGIN_UPDATE_FILE}" ]; then
    ZPLUG_PLUGIN_UPDATE_FILE="${ZPLUG_HOME:-}/.zplug_plugin_lastupdate"
  fi

  local day_seconds=$(expr 24 \* 60 \* 60)
  local plugins_seconds=$(expr ${day_seconds} \* ${ZPLUG_PLUGIN_UPDATE_DAYS})

  local last_plugin=$(_zplug-check-interval ${ZPLUG_PLUGIN_UPDATE_FILE})

  if [ ${last_plugin} -gt ${plugins_seconds} ]; then
    echo "It has been $(expr ${last_plugin} / $day_seconds) days since your zplug plugins were updated"
    zplug update

    date +%s >! ${ZPLUG_PLUGIN_UPDATE_FILE}
    zplug clean --force
  fi
}

zmodload zsh/system
lockfile=${ZPLUG_HOME:-~}/.zplug_autoupdate_lock
touch $lockfile
if ! which zsystem &> /dev/null || zsystem flock -t 1 $lockfile; then
  _zplug-check-for-updates
  command rm -f $lockfile
fi

# ENABLE_CORRECTION="true"


# for zsh built-in completion
zstyle ':completion:*' list-prompt   ''
zstyle ':completion:*' select-prompt ''
# complete with a nicer menu, but it may be in conflict with auto suggestion
# zstyle ':completion:*' menu yes select 


autoload -Uz compinit && compinit # built-in one

# use ag for FZF and ignore some files 
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'


# source $ZSH/oh-my-zsh.sh


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ptt="ssh bbsu@ptt.cc"


# separate aliases
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# separate paths, especially remove redundant ones by WSL2
if [ -f ~/.zsh_paths ]; then
    source ~/.zsh_paths
fi

# use the real fd when common-aliases has assigned alias for find
# unalias fd


# shortcut to vimrc 
alias vimrc="vim ~/.vimrc"
# alias zshrc="vim ~/.zshrc" # this command is already in common aliases

# shortcut to backup vimrc and zshrc, then  update to dropbox
alias vimrc_publish="/bin/cp -f ~/.vimrc ~/.vimrc.bak; cp ~/.vimrc ~/Dropbox/.vimrc"
alias zshrc_publish="/bin/cp -f ~/.zshrc ~/.zshrc.bak; cp ~/.zshrc ~/Dropbox/.zshrc"

# shortcut to apply vimrc and zshrc changes from Dropbox after backup
alias vimrc_apply="cp ~/.vimrc ~/.vimrc.bak; cp ~/Dropbox/.vimrc ~/.vimrc"
alias zshrc_apply="cp ~/.zshrc ~/.zshrc.bak; cp ~/Dropbox/.zshrc ~/.zshrc"

# let's play with SpaceVim, don't  let it override ~/.vimrc
alias svim_install='git clone https://github.com/SpaceVim/SpaceVim.git ~/.SpaceVim' 
alias svim='vim -u ~/.SpaceVim/vimrc'

eval $(thefuck --alias)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
