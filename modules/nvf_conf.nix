{pkgs, ... } :
{
  programs.nvf = {
    enable = true;
    settings = {
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
      vim.clipboard.enable = true;
      vim.clipboard.registers = "unnamedplus";
      vim.clipboard.providers.xsel.enable = true;
      vim.telescope.enable = true;
    }; 
  };
}
