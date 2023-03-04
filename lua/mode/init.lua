--[[
-- You can define new groups of keybinds like this:
require("mode").add("n", "hello", {
  ["<leader>h"] = "<cmd>echo \"hello world!\"<cr>",
  ["<leader>f"] = function () print("g'day") end,
})

-- you can activate a group of keybinds with the `on` function:
require("mode").on("hello")

-- ... and you can deactivate groups too:
require("mode").off("hello")

]]--

local M = {}

M._groups = {}

local function find_existing(mode, mappings)
  local existing = vim.api.nvim_get_keymap(mode)
  local overlap = {}

  for lhs, _ in pairs(mappings) do
    for _, mapping in pairs(existing) do
      if lhs:gsub('<leader>', vim.g.mapleader) == mapping.lhs then
        overlap[lhs] = mapping.rhs or mapping.callback
      end
    end
  end

  return overlap
end

M.add = function (mode, name, mappings)
  M._groups[name] = { mode = mode, mappings = mappings, existing = find_existing(mode, mappings)}
end

M.on = function (name)
  local mode = M._groups[name].mode
  for lhs, rhs in pairs(M._groups[name].mappings) do
    vim.keymap.set(mode, lhs, rhs)
  end
end

M.off = function (name)
  local group = M._groups[name]

  for lhs, _ in pairs(group.mappings) do
    vim.keymap.del(group.mode, lhs)
  end

  for lhs, rhs in pairs(group.existing) do
    vim.keymap.set(group.mode, lhs, rhs)
  end
end

return M
