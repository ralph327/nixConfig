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
        autocomplete.nvim-cmp.enable = true;

        lazy.plugins = {
          "kanagawa.nvim" = {
            lazy = false;
            priority = 1000;
            package = pkgs.vimPlugins.kanagawa-nvim;
            setupModule = "kanagawa";
            setupOpts = {
              terminalColors = true;
              colors = {
                theme = {
                  dragon = {
                    ui = {
                      fg = "#87A987";
                      fg_dim = "#8a9a7b";
                      special = "#98BB6C";
                    };
                    syn = {
                      string = "#D27E99";
                      variable = "#87A987";
                      number = "#FF5D62";
                      constant = "#7FB4CA";
                      identifier = "#98BB6C";
                      parameter = "#6A9589";
                      fun = "#98BB6C";
                      statement = "#957FB8";
                      keyword = "#FFA066";
                      operator = "#FF5D62";
                      type = "#E6C384";
                      punct = "#727169";
                      comment = "#938056";
                    };
                  };
                };
              };
              theme = "dragon";
              background = {
                dark = "dragon";
                light = "lotus";
              };
            };
          };
        };
        luaConfigRC."kanagawa.vim" = "vim.cmd('colorscheme kanagawa')";

        keymaps = [
          {
            key = "<Home>";
            mode = "n";
            silent = true;
            action = "^";
          }
        ];
      };
    };
  };
}
