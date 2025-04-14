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

# ssh-agent
{ pid="$(pgrep -u $USER ssh-agent)" && export SSH_AUTH_SOCK=/run/user/1000/ssh-agent.sock && export SSH_AGENT_PID=$pid && unset pid } &> /dev/null || { eval "$(ssh-agent -s -a /run/user/1000/ssh-agent.sock)" && ssh-add "$HOME"/.ssh/*.key } &> /dev/null

# ASDF
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
command fd -t f -g "set*.zsh" "$HOME/.asdf/plugins" &> /dev/null | while read -r script; do; . "$script"; done

# Functions
TRAPEXIT() {
  if [[ ! -o login ]]; then
    [[ ! -f "$HOME/.zlogout" ]] || . "$HOME/.zlogout"
  fi
}

## Yazi
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
alias dotfiles="yadm"
alias archconf="yadm --yadm-repo $HOME/.local/share/yadm/arch_config.git"
alias hyprdots="yadm --yadm-repo $HOME/.local/share/yadm/hyprdots.git"
