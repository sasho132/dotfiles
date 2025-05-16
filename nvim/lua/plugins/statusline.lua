local M = {}

local modes = {
  n = { 'NORMAL' },
  i = { 'INSERT' },
  v = { 'VISUAL' },
  V = { 'V-LINE' },
  [''] = { 'V-BLOCK' },
  R = { 'REPLACE' },
  c = { 'COMMAND' },
  t = { 'TERM' },
}

local function mode_section()
  local m = vim.api.nvim_get_mode().mode
  local entry = modes[m] or { m, 'StatusLineOther' }
  return string.format('%%#%s# %s %%#StatusLine#', entry[2], entry[1])
end

local function file_ext()
  local filename = vim.api.nvim_buf_get_name(0) -- get current buffer name (move inside function for fresh data)
  if filename == '' then
    return ' [No Name]' -- icon for noname
  end
  local ext = vim.fn.fnamemodify(filename, ':e')
  local icon = require('mini.icons').get('extension', ext) or ''
  local filetype = vim.bo.filetype
  if not filetype or filetype == '' then
    filetype = '[No Type]'
  end
  return string.format('%s %s', icon, filetype)
end

local function file_position()
  return string.format('%3d:%-2d ', vim.fn.line '.', vim.fn.col '.')
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
    ' %<%f', -- File path, shortened if space is low
    '%=',
    git_status(),
    ' ',
    '%=',
    lsp(),
    ' ',
    file_ext(),
    ' ',
    file_position(),
  }
end

vim.o.statusline = '%!v:lua.custom_statusline()'

return M
