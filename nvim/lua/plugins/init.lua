local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.api.nvim_command("packadd packer.nvim")
end

return require 'packer'.startup(function()
    use 'wbthomason/packer.nvim'

    use 'EdenEast/nightfox.nvim'
    use 'catppuccin/nvim'

    use {
        'kyazdani42/nvim-tree.lua',
        require = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
    }
    use({ 'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    })
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use {
        'romgrk/barbar.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'rafamadriz/friendly-snippets'
    use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
    use 'onsails/lspkind-nvim'
    use 'nvim-treesitter/nvim-treesitter'
    --  use {
    --      'neoclide/coc.nvim', branch = 'coc' }
    use {
        'nvim-telescope/telescope.nvim',
        require = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'nvim-treesitter/completion-treesitter'
    use 'tree-sitter/tree-sitter-bash'
    use 'Azganoth/tree-sitter-lua'
    use 'ikatyang/tree-sitter-markdown'
    use 'tree-sitter/tree-sitter-html'
    use 'tree-sitter/tree-sitter-javascript'
    use({ 'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    })
    use({
        "gbprod/substitute.nvim",
        config = function()
            require("substitute").setup({})
            vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
            vim.keymap.set("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
            vim.keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
            vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
        end
    })
    use {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use 'mfussenegger/nvim-jdtls'
    use 'p00f/nvim-ts-rainbow'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    }
    use({
        "folke/noice.nvim",
        event = "VimEnter",
        config = function()
            require 'noice'.setup({ config })
        end,
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    })

end)
