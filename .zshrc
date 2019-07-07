# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# History
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# makes fn + delete delete forward
bindkey "^[[3~" delete-char

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    # indicate when there are uncommited changes
    if [[ -n $(git status -s) ]]; then
      current_branch+=" *"
    fi

    echo " %{$fg_bold[green]%}$current_branch%{$reset_color%}"
  fi
}
setopt promptsubst
PS1='%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) $ '

# load ASDF for version management
[[ -d "$HOME/.asdf" ]] && . $HOME/.asdf/asdf.sh

# autoload zsh completion system
autoload -U compinit && compinit

# git completions
[ -f "~/git-completion.zsh" ] && source ~/git-completion.zsh

alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# https://github.com/tmuxinator/tmuxinator
[ -f "~/.bin/tmuxinator.zsh" ] && source ~/.bin/tmuxinator.zsh

# Set the default editor to vs code
export EDITOR='code'
