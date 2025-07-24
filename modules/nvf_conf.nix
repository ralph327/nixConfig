{
  pkgs,
  inputs,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        additionalRuntimePaths = [
          "${inputs.self}/modules/nvim"
        ];
        vimAlias = true;

        options.shiftwidth = 2;

        spellcheck = {
          enable = true;
          languages = ["en"];
          programmingWordlist.enable = true;
        };

        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.xsel.enable = true;
        };

        telescope.enable = true;

        lsp = {
          enable = true;

          formatOnSave = true;
          #trouble = true;
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          nix.enable = true;
          markdown.enable = true;
          bash.enable = true;
          css = {
            enable = true;
            format.type = "biome";
          };

          html.enable = true;
          sql.enable = true;
          ts = {
            enable = true;
            format.type = "biome";
          };
          go.enable = true;
          lua.enable = true;
          python.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
          tailwind.enable = true;
          svelte = {
            enable = true;
            format.type = "biome";
          };
        };

        treesitter.context.enable = true;

        lazy.plugins = {
          "kanagawa.nvim" = {
            lazy = false;
            priority = 1000;
            package = pkgs.vimPlugins.kanagawa-nvim;
          };
        };
        luaConfigRC."kanagawa.vim" = "vim.cmd('colorscheme kanagawa-wave')";
      };
    };
  };
}
