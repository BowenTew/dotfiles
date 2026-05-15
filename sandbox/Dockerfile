# NvChad starter sandbox
# ---
# build : docker build -t nvchad-sandbox dot_config/nvim/docker
# run   : docker run -it --rm nvchad-sandbox
# first launch inside the container will run `:Lazy sync` automatically;
# wait until it finishes, then press `q` to close the Lazy panel.

FROM alpine:3.21

ENV TERM=xterm-256color \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    EDITOR=nvim

# Core deps for nvim + NvChad ecosystem
#   neovim       : >= 0.10 in alpine 3.21
#   git/curl     : plugin manager
#   ripgrep/fzf  : telescope live-grep + fuzzy
#   nodejs/npm   : many LSP servers (ts_ls, vue_ls, ...)
#   gcc/make     : nvim-treesitter parser compilation
#   tmux/ncurses : nicer terminal session
#   lazygit      : optional, used by NvChad's <leader>gg
RUN apk add --no-cache \
        neovim \
        git curl wget bash \
        ripgrep fzf \
        nodejs npm \
        python3 py3-pip \
        gcc g++ make musl-dev \
        ncurses tmux \
        lazygit \
        unzip \
        sudo shadow

# Non-root user (NvChad runs fine as root, but cleaner this way)
ARG USER=chad
ARG UID=1000
RUN adduser -D -u ${UID} -s /bin/bash ${USER} \
 && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ${USER}
WORKDIR /home/${USER}

# Pull the official NvChad starter into ~/.config/nvim
RUN git clone --depth=1 https://github.com/NvChad/starter ~/.config/nvim \
 && rm -rf ~/.config/nvim/.git

# Codeberg aggressively rate-limits / IP-blocks (HTTP 429). The one NvChad dep
# hosted there (cmp-async-path) is mirrored 1:1 on GitHub, so:
#   1. pre-clone it from GitHub directly into lazy.nvim's plugin dir,
#      so `Lazy sync` finds it already present and skips the codeberg clone;
#   2. also add a global git insteadOf rule, in case lazy.nvim ever decides to
#      `git fetch` it later. NB: rewrite target has NO `.git` suffix to avoid
#      producing `...cmp-async-path.git.git` after prefix replacement.
RUN git config --global \
      url."https://github.com/FelipeLema/cmp-async-path".insteadOf \
      "https://codeberg.org/FelipeLema/cmp-async-path" \
 && mkdir -p ~/.local/share/nvim/lazy \
 && git clone --depth=1 https://github.com/FelipeLema/cmp-async-path \
      ~/.local/share/nvim/lazy/cmp-async-path

# Pre-install all plugins headlessly so the first interactive launch is instant.
# `Lazy! sync` is synchronous (the `!` means foreground). We do NOT swallow
# the exit code: if it fails, the build fails, so a broken layer can't be
# cached and silently reused on subsequent builds.
RUN nvim --headless "+Lazy! sync" "+qa"

# Pre-compile a few common treesitter parsers (optional, speeds up first edit).
RUN nvim --headless \
      "+TSInstallSync! lua vim vimdoc bash markdown markdown_inline json yaml" \
      "+qa" \
 || true

# Default shell so `docker run -it` drops you into bash; just type `nvim`.
CMD ["/bin/bash", "-l"]
