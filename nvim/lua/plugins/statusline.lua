local M = {}

vim.api.nvim_set_hl(0, 'StatusLineNormal', { fg = '#1e1e2e', bg = '#a6e3a1', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineInsert', { fg = '#1e1e2e', bg = '#89b4fa', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineVisual', { fg = '#1e1e2e', bg = '#b4befe', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineReplace', { fg = '#1e1e2e', bg = '#f38ba8', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineCommand', { fg = '#1e1e2e', bg = '#f9e2af', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineTerminal', { fg = '#1e1e2e', bg = '#89dceb', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineOther', { fg = '#1e1e2e', bg = '#a6adc8', bold = true })

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

local function mode_section()
  local m = vim.api.nvim_get_mode().mode
  local entry = modes[m] or { m, 'StatusLineOther' }
  return string.format('%%#%s# %s %%#StatusLine#', entry[2], entry[1])
end

local function file_icon()
  local filename = vim.api.nvim_buf_get_name(0)
  local ext = vim.fn.fnamemodify(filename, ':e')
  local icon = require('mini.icons').get('extension', ext) or ''
  return string.format('%s', icon)
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

  -- total_lines will always be at least 1, as vim.fn.line('$') returns 1 for an empty buffer.
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
    errors = { icon = '', hl = 'LspDiagnosticsSignError' },
    warnings = { icon = '', hl = 'LspDiagnosticsSignWarning' },
    hints = { icon = '', hl = 'LspDiagnosticsSignHint' },
    info = { icon = '', hl = 'LspDiagnosticsSignInformation' },
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
    git_status(),
    ' ',
    search_count(),
    ' ',
    lsp(),
    ' ',
    file_icon(),
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
