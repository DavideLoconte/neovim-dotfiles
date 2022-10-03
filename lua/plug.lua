-- [[ plug.lua ]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
      -- [[ Theme ]]
    use { 'DanilaMihailov/beacon.nvim' }               -- cursor jump
    use {
        'nvim-lualine/lualine.nvim',                     -- statusline
        requires = {'kyazdani42/nvim-web-devicons',
        opt = true}
    }
    use { 'Mofiqul/dracula.nvim' }
    
    -- Configurations for Nvim LSP
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    use 'mfussenegger/nvim-dap'
    use "nvim-lua/plenary.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use { 'nvim-treesitter/nvim-treesitter' }
    use {'ms-jpq/coq_nvim', 'ms-jpq/coq.artifacts', 'ms-jpq/coq.thirdparty'}
end)
