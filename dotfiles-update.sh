# shellcheck shell=bash
dotfiles_dir="/root/.dotfiles"

__dotfiles_update() {
    cd "$dotfiles_dir" 2>/dev/null || return
    local before after
    before=$(git rev-parse HEAD)
    git pull --quiet
    after=$(git rev-parse HEAD)
    if [ "$before" != "$after" ]; then
        echo "dotfiles were updates, installing..."
        rake vim zsh
    fi
}

__dotfiles_update
