return {
  'neovim/nvim-lspconfig',
  opts = function()
    local keys = require('lazyvim.plugins.lsp.keymaps').get()

    keys[#keys + 1] = { 'K', '<cmd>lua vim.lsp.buf.hover()<CR>' }
    keys[#keys + 1] = { 'vgd', '<cmd>lua vim.lsp.buf.definition()<CR>' }
    keys[#keys + 1] = { '<leader>vws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>' }
    keys[#keys + 1] = { '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<CR>' }
    keys[#keys + 1] = { '[d', '<cmd>lua vim.diagnostic.goto_next()<CR>' }
    keys[#keys + 1] = { ']d', '<cmd>lua vim.diagnostic.goto_prev()<CR>' }
    keys[#keys + 1] = { '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>' }
    keys[#keys + 1] = { '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>' }
    keys[#keys + 1] = { '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>' }
    keys[#keys + 1] = { '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', mode = 'i' }
  end,
}
