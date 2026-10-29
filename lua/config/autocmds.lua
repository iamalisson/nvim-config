-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Tell kitty (OSC 7) which dir we're "in": the project root of the current
-- buffer. kitty's `launch --cwd=last_reported` (ctrl+shift+enter/t) then opens
-- new windows there, even if nvim itself was started from another dir.
if vim.env.KITTY_WINDOW_ID then
  vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
    group = vim.api.nvim_create_augroup("kitty_osc7", { clear = true }),
    callback = function()
      local dir = LazyVim.root()
      if vim.fn.isdirectory(dir) == 1 then
        vim.api.nvim_ui_send("\027]7;" .. vim.uri_from_fname(dir) .. "\027\\")
      end
    end,
  })
end
