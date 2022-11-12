local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

-- Enable completion triggered by <c-x><c-o>
--vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)


--buf_set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
--buf_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)

-- buf_set_keymap("n", "<leader>dm", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)


--    local vscode_java_test = "/usr/local/bin/vscode-java-test/server/*.jar"

-- local bundles = {

--      vim.fn.glob("/usr/local/bin/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
-- };
-- vim.list_extend(bundles, vim.split(vim.fn.glob("/usr/local/bin/vscode-java-test/server/*.jar"), "\n"))

local capabilities = require('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())

local config = {
    capabilities = capabilities,
    -- The command that starts the language server
    cmd = {
        "/usr/lib/jvm/java-11-openjdk/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g", "-Xmx2G",
        "-javaagent:/home/thotspot/.config/jdtLs/plugins/lombok.jar",
        "-jar",
        "/home/thotspot/.config/jdtLs/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
        "-configuration",
        "/home/thotspot/.config/jdtLs/config_linux",
        "-data", "/home/thotspot/.runner/workspace",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED"
        -- ADD REMAINING OPTIONS FROM https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line !
    },
    --     init_options = {
    --      bundles = bundles;
    --   },

    on_attach = function(a, bufnr)
        --  require'jdtls'.setup_dap()
        require 'jdtls.setup'.add_commands()
    end,

    root_dir = require('jdtls.setup').find_root({
        'build.xml', -- Ant
        'pom.xml', -- Maven
        'settings.gradle', -- Gradle
        'settings.gradle.kts', -- Gradle
    })
}
require('jdtls').start_or_attach(config)
