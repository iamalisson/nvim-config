-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "oc", function()
  local cwd = vim.fn.getcwd()

  vim.fn.jobstart({

    "kitty",
    "@",
    "launch",

    "--type=window",

    "--cwd=" .. cwd,

    "zsh",
    "-i",
    "-c",
    "opencode", -- Change "zsh" to "bash" if needed
  }, {

    pty = true,

    on_stdout = function(_, data)
      local msg = table.concat(data, "\n"):gsub("%s+$", "")
      if #msg > 0 and msg:match("[Ee]rror") then
        vim.notify("Kitty error: " .. msg, vim.log.levels.ERROR)
      end
    end,
  })
end, { desc = "OpenCode in new kitty terminal" })

vim.keymap.set("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.getcwd())
  vim.notify("cwd copied")
end, { desc = "Copy current working directory (pwd)" })

vim.keymap.set("n", "<leader>cu", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify("Copied path: " .. path)
end, { desc = "Copy current file absolute path" })

vim.keymap.set("n", "<leader>k", ":silent !xdg-open %:p:h<CR>", { silent = true })
