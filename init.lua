local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath})
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    -- Treesitter for better syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    -- LSP and Autocompletion
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    -- UI enhancements
    { "mellow-theme/mellow.nvim" },
    { "nvim-lualine/lualine.nvim" },
    { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    -- File Explorer
    { "nvim-tree/nvim-tree.lua" },
    -- Telescope (Fuzzy Finder)
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  })

  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.opt.smartindent = true
  vim.opt.termguicolors = true
  vim.opt.clipboard = "unnamedplus"
  vim.opt.cursorline = true
  vim.opt.scrolloff = 8 -- Keep 8 lines visible before reaching last line

  vim.g.mapleader = " "
  vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
  vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
  vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- Toggle file explorer

  local lspconfig = require("lspconfig")
  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
  lspconfig.clangd.setup({
    capabilities = lsp_capabilities
  })

  local cmp = require("cmp")
  cmp.setup({
    sources = {
      {name = 'path'},
      {name = 'nvim_lsp', keyword_length = 1},
      {name = 'buffer', keyword_length = 3},
      {name = 'luasnip', keyword_length = 2},
    },
    window = {
      documentation = cmp.config.window.bordered()
    },
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({select = false}),
      ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
      ['<Down>'] = cmp.mapping.select_next_item(select_opts),

      ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
      ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
      ['<C-e>'] = cmp.mapping.abort(),
    }
  })

  require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "python", "c" },
    highlight = { enable = true },
  })

  vim.cmd("colorscheme mellow")

  require("lualine").setup()
  require("bufferline").setup()
  require("nvim-tree").setup()
