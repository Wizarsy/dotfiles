if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  . "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Env
export ZOXIDE_CMD_OVERRIDE=cd
export ZSH="$HOME/.oh-my-zsh"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#cfc9c2,bg:-1,bg+:#515C7E
  --color=hl:#9ece6a,hl+:#73DACA,info:#C0CAF5,marker:#7dcfff
  --color=prompt:#BB9AF7,spinner:#ff9e64,pointer:#e0af68,header:#C0CAF5
  --color=gutter:#515C7E,border:#414868,separator:#414868,label:#C0CAF5
  --color=query:#cfc9c2
  --border="sharp" --border-label="" --preview-window="border-sharp" --padding="1"
  --prompt=" " --marker="" --pointer="" --separator="-"
  --scrollbar="│" --info="right"'
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git docker zsh-autosuggestions zsh-completions ohmyzsh-full-autoupdate fast-syntax-highlighting command-not-found colored-man-pages fzf fzf-tab zoxide) 

. "$ZSH/oh-my-zsh.sh"

fpath+="$HOME/.zfunc"
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

# FZF
zstyle ':fzf-tab:*' use-fzf-default-opts yes

[[ ! -f "$HOME/.p10k.zsh" ]] || . "$HOME/.p10k.zsh"

# ASDF
fd -t f "zsh$|^env$" "$HOME/.asdf/plugins" | while read -r script; do; . "$script"; done

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

yay() {
  env -i zsh -l -c "yay $*; yay -Yc --noconfirm"
}

# Aliases
alias up="yay --noconfirm; sudo pkgfile -u"
alias ls="eza --icons=always --color=always"
alias cat="bat --style=auto --paging=never --theme=TokyoNight"
alias find="fd"
alias grep="rg"
alias mkdir="mkdir -p"
alias dotfiles="yadm --yadm-dir $HOME/.config/yadm/dotfiles --yadm-data $HOME/.local/share/yadm/dotfiles"
alias hyprdots="yadm --yadm-dir $HOME/.config/yadm/hyprdots --yadm-data $HOME/.local/share/yadm/hyprdots"
