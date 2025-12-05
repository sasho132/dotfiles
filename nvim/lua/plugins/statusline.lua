local M = {}

local config = {
  show_block = true,
  show_lsp = true,
  show_git = true,
  show_search = true,
  show_icon = true,
}

vim.api.nvim_set_hl(0, 'StatusLineNormal', { link = 'NormalMode' })
vim.api.nvim_set_hl(0, 'StatusLineInsert', { link = 'InsertMode' })
vim.api.nvim_set_hl(0, 'StatusLineVisual', { link = 'VisualMode' })
vim.api.nvim_set_hl(0, 'StatusLineReplace', { link = 'ReplaceMode' })
vim.api.nvim_set_hl(0, 'StatusLineCommand', { link = 'CmdLineMode' })
vim.api.nvim_set_hl(0, 'StatusLineTerminal', { link = 'TerminalMode' })
vim.api.nvim_set_hl(0, 'StatusLineOther', { link = 'StatusLineMode' })

local function mode_section()
  local modes = {
    n = { 'NORMAL', 'StatusLineNormal' },
    i = { 'INSERT', 'StatusLineInsert' },
    v = { 'VISUAL', 'StatusLineVisual' },
    V = { 'V-LINE', 'StatusLineVisual' },
    [''] = { 'V-BLOCK', 'StatusLineVisual' },
    R = { 'REPLACE', 'StatusLineReplace' },
    c = { 'COMMAND', 'StatusLineCommand' },
    t = { 'TERM', 'StatusLineTerminal' },
  }

  local m = vim.api.nvim_get_mode().mode
  local entry = modes[m] or { m, 'StatusLineOther' }

  if config.show_block then
    return string.format('%%#%s# %%#StatusLine# %s %%#StatusLine#', entry[2], entry[1])
  else
    return string.format('%%#%s# %s %%#StatusLine#', entry[2], entry[1])
  end
end

local function file_icon()
  local icon_cache = {}
  local ok, mini_icons = pcall(require, 'mini.icons')
  if not ok then
    return ''
  end
  local filename = vim.api.nvim_buf_get_name(0)
  local ext = vim.fn.fnamemodify(filename, ':e')
  if icon_cache[ext] then
    return icon_cache[ext]
  end
  local icon = mini_icons.get('extension', ext) or ''
  icon_cache[ext] = string.format('%s', icon)
  return icon_cache[ext]
end

local function file_ext()
  local filetype = vim.bo.filetype or ''
  filetype = filetype ~= '' and filetype or '[No Type]'
  return string.format('%s', filetype)
end

local function file_position()
  return string.format('%3d:%-2d', vim.fn.line '.', vim.fn.col '.')
end

local function file_percentage()
  local current_line = vim.fn.line '.'
  local total_lines = vim.fn.line '$'
  local percentage = (current_line / total_lines) * 100
  local icon
  if percentage <= 12.5 then
    icon = '󰪞'
  elseif percentage <= 25 then
    icon = '󰪟'
  elseif percentage <= 37.5 then
    icon = '󰪠'
  elseif percentage <= 50 then
    icon = '󰪡'
  elseif percentage <= 62.5 then
    icon = '󰪢'
  elseif percentage <= 72.5 then
    icon = '󰪣'
  elseif percentage <= 87.5 then
    icon = '󰪤'
  else
    icon = '󰪥'
  end

  --return string.format('%s %.0f%%', icon, percentage)
  return string.format('%s ', icon)
end

local function search_count()
  if vim.v.hlsearch == 0 then
    return ''
  end

  local ok, count = pcall(vim.fn.searchcount, { recompute = true, maxcount = 500 })
  if (not ok or (count.current == nil)) or (count.total == 0) then
    return ''
  end

  if count.incomplete == 1 then
    return '?/?'
  end

  local too_many = ('>%d'):format(count.maxcount)
  local total = ((count.total > count.maxcount) and too_many) or count.total

  return '  ' .. (' %s/%s '):format(count.current, total)
end

local function lsp()
  if not vim.diagnostic then
    return ''
  end
  local count = { errors = 0, warnings = 0, info = 0, hints = 0 }
  for _, diag in ipairs(vim.diagnostic.get(0)) do
    local sev = diag.severity
    if sev == vim.diagnostic.severity.ERROR then
      count.errors = count.errors + 1
    elseif sev == vim.diagnostic.severity.WARN then
      count.warnings = count.warnings + 1
    elseif sev == vim.diagnostic.severity.INFO then
      count.info = count.info + 1
    elseif sev == vim.diagnostic.severity.HINT then
      count.hints = count.hints + 1
    end
  end

  local symbols = {
    errors = { icon = '', hl = 'DiagnosticSignError' },
    warnings = { icon = '', hl = 'DiagnosticSignWarning' },
    hints = { icon = '', hl = 'DiagnosticSignHint' },
    info = { icon = '', hl = 'DiagnosticSignInformation' },
  }

  local result = {}
  for kind, data in pairs(symbols) do
    if count[kind] > 0 then
      table.insert(result, string.format(' %%#%s#%s %d', data.hl, data.icon, count[kind]))
    end
  end

  return table.concat(result)
end

local function git_status()
  if not vim.g.gitsigns_head then
    return ''
  end
  local gsd = vim.b.gitsigns_status_dict
  if not gsd or not gsd.head then
    return ''
  end
  local result = ' ' .. gsd.head
  if gsd.added and gsd.added > 0 then
    result = result .. ' +' .. gsd.added
  end
  if gsd.changed and gsd.changed > 0 then
    result = result .. ' ~' .. gsd.changed
  end
  if gsd.removed and gsd.removed > 0 then
    result = result .. ' -' .. gsd.removed
  end

  return result
end

function _G.custom_statusline()
  return table.concat {
    mode_section(),
    ' ',
    ' %<%f', -- File path, shortened if space is low
    '%=',
    config.show_git and git_status() or '',
    ' ',
    config.show_search and search_count() or '',
    ' ',
    config.show_lsp and lsp() or '',
    ' ',
    config.show_icon and file_icon() or '',
    ' ',
    file_ext(),
    ' ',
    file_position(),
    ' ',
    file_percentage(),
  }
end

vim.o.statusline = '%!v:lua.custom_statusline()'

return M
