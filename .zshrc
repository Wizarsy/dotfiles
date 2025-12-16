if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  . "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -d "$HOME/.bin" ]] || export PATH="$HOME/.bin:$PATH"
[[ ! -d "$HOME/.local/.bin" ]] || export PATH="$HOME/.local/.bin:$PATH"

# Env
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(fzf eza zoxide fzf-tab asdf docker command-not-found colored-man-pages ohmyzsh-full-autoupdate zsh-autosuggestions fast-syntax-highlighting) 

export ZOXIDE_CMD_OVERRIDE=cd

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#cfc9c2,bg:-1,bg+:#515C7E
  --color=hl:#9ece6a,hl+:#73DACA,info:#C0CAF5,marker:#7dcfff
  --color=prompt:#BB9AF7,spinner:#ff9e64,pointer:#e0af68,header:#C0CAF5
  --color=gutter:#515C7E,border:#414868,separator:#414868,label:#C0CAF5
  --color=query:#cfc9c2
  --border="sharp" --border-label="" --preview-window="border-sharp" --padding="1"
  --prompt=" " --marker="" --pointer="" --separator="-"
  --scrollbar="│" --info="right"'

zstyle ':fzf-tab:*' use-fzf-default-opts yes

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'icons' yes
zstyle ':omz:plugins:eza' 'show-group' yes

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7
zstyle ':omz:update' verbose default

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

source "$ZSH/oh-my-zsh.sh"
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

# ASDF
[[ ! -d $HOME/.asdf ]] || fd -t f "zsh$|^env$" "$HOME/.asdf/plugins" | while read -r script; do; source "$script"; done

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
alias up="yay --noconfirm; sudo pkgfile -u"
alias cat="bat"
alias find="fd"
alias grep="rg"
alias du="dust"
