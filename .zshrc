if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  . "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git docker zsh-autosuggestions zsh-completions ohmyzsh-full-autoupdate fast-syntax-highlighting command-not-found colored-man-pages fzf fzf-tab zoxide) 

. "$ZSH/oh-my-zsh.sh"

fpath+="$HOME/.zfunc"
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

zstyle ':fzf-tab:*' use-fzf-default-opts yes

[[ ! -f "$HOME/.p10k.zsh" ]] || . "$HOME/.p10k.zsh"

eval "$(ssh-agent -s)" &> /dev/null; (ssh-add "$HOME"/.ssh/*.key) &> /dev/null

TRAPEXIT() {
  if [[ ! -o login ]]; then
    [[ ! -f "$HOME/.zlogout" ]] || . "$HOME/.zlogout"
  fi
	kill $SSH_AGENT_PID
}

# Yazi
y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Aliases
alias yay="ASDF_GOLANG_VERSION=system ASDF_PYTHON_VERSION=system ASDF_RUST_VERSION=system yay"
alias up="yay --noconfirm; yay -Yc --noconfirm"
alias ls="eza --icons=always --color=always"
alias cat="bat --style=auto"
alias find="fd"
alias grep="rg"
alias cd="z"
alias mkdir="mkdir -p"
