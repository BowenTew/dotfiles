# Sandbox (Docker)

## Build

```bash
cd ~/.local/share/chezmoi
docker build -t nvchad-sandbox dot_config/nvim/docker
```

First build takes ~5–10 min: Alpine pkgs + `Lazy sync` (50+ plugins) +
treesitter parser compilation.

### Troubleshooting build failures

- **`Codeberg ... 429` / `Your IP address has been blocked`**
  Codeberg aggressively IP-blocks. The Dockerfile sidesteps this by
  **pre-cloning the only Codeberg-hosted dep (`cmp-async-path`) from GitHub**
  straight into lazy.nvim's plugin dir, so `Lazy sync` never talks to Codeberg.
  An `insteadOf` rewrite is also baked in for any later `:Lazy update`.
  If you ever see 429 on a *different* Codeberg URL, add another
  `git config --global url."https://github.com/...".insteadOf "https://codeberg.org/..."`
  line and a matching pre-clone, or just disable that plugin in NvChad's spec.
  **You must rebuild without cache after editing the Dockerfile:**
  ```bash
  docker rmi nvchad-sandbox 2>/dev/null
  docker build --no-cache -t nvchad-sandbox dot_config/nvim/docker
  ```
- **`git clone` timeout to github.com**
  Build with a proxy:
  ```bash
  docker build \
    --build-arg HTTP_PROXY=http://host.docker.internal:7890 \
    --build-arg HTTPS_PROXY=http://host.docker.internal:7890 \
    -t nvchad-sandbox dot_config/nvim/docker
  ```
- **Build succeeded but some plugins still missing**
  Just run `:Lazy sync` once inside the container.

## Run

```bash
docker run -it --rm nvchad-sandbox
# you land in bash; then:
nvim          # NvChad dashboard
nvim .        # opens nvim-tree on a directory
```

Tip: pass a host folder if you want real code to play with:

```bash
docker run -it --rm -v "$PWD:/work" -w /work nvchad-sandbox
```

## Cleanup

```bash
docker rmi nvchad-sandbox
```
