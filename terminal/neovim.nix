{
  pkgs,
  ...
}: {
  programs.lazyvim = {
    enable = true;

    extras = {
      lang.python = {
        enable = true;
        installDependencies = true;        # Install ruff
        installRuntimeDependencies = true; # Install python3
      };
      lang.go = {
        enable = true;
        installDependencies = true;        # Install gopls, gofumpt, etc.
        installRuntimeDependencies = true; # Install go compiler
      };
      lang.rust = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
      lang.typst = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    config = {
      options = ''
        vim.opt.relativenumber = false
        vim.opt.wrap = true

        vim.cmd("highlight Normal guibg=none")
        vim.cmd("highlight NonText guibg=none")
        vim.cmd("highlight Normal ctermbg=none")
        vim.cmd("highlight NonText ctermbg=none")
      '';

      keymaps = ''
        vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
        vim.keymap.set("i", "vj", "<Esc>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
        vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
      '';
    };

    # Additional packages (optional)
    extraPackages = with pkgs; [
      nixd       # Nix LSP
      alejandra  # Nix formatter
    ];

    # Only needed for languages not covered by LazyVim extras
    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      wgsl      # WebGPU Shading Language
      templ     # Go templ files
    ];
  };
}
