-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- Packer can manage itself

  use 'wbthomason/packer.nvim'

vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]]


  -- telescope

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }


  -- colorscheme

  use { 'dasupradyumna/midnight.nvim' }


  -- treesitter

  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use ('nvim-treesitter/playground')


  -- harpoon


  -- undotree
  
  use('mbbill/undotree')


  -- vim-fugitive
  
  use('tpope/vim-fugitive')


  -- lsp

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
 }


 -- nvim-tree
 

 -- auto pairing

 use {
     "windwp/nvim-autopairs",
     config = function() require("nvim-autopairs").setup {} end
 }


 -- tmux and split window navigation

 use('christoomey/vim-tmux-navigator')


 -- toggleterm (terminal inside vim)

 use {"akinsho/toggleterm.nvim", tag = '*', config = function()
     require("toggleterm").setup()
 end}



end)

