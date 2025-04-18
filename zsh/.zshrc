task

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zdharma-continuum/zinit-annex-bin-gem-node
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit ice as"program" from"gh-r" \
    sbin'**/gh' \
    cli/cli
zinit light cli/cli

zinit ice as"command" from"gh-r" bpick"atuin-*.tar.gz" mv"atuin*/atuin -> atuin" \
    atclone"./atuin init zsh > init.zsh; ./atuin gen-completions --shell zsh > _atuin" \
    atpull"%atclone" src"init.zsh"
zinit light atuinsh/atuin


zinit ice as"program" from"gh-r" \
    sbin'**/lsd' \
    lsd-rs/lsd
zinit light lsd-rs/lsd
alias ls="lsd -l"

zinit ice as"program" from'gh-r'  \
    sbin'**/fzf'  \
    atclone'fzf --zsh > fzf.zsh' \
    atpull'%atclone' \
    src'fzf.zsh' \
  junegunn/fzf
zinit light junegunn/fzf

autoload compinit; compinit
