local colors_file = io.open(os.getenv('HOME') .. '/.local/share/nvim-colors.json', 'r')
if not colors_file then
  local base16_colors = {
    base00 = '#131313',
    base01 = '#1f1f1f',
    base02 = '#2a2a2a',
    base03 = '#919191',
    base04 = '#c6c6c6',
    base05 = '#e2e2e2',
    base06 = '#e2e2e2',
    base07 = '#303030',
    base08 = '#ffb4ab',
    base09 = '#dec38c',
    base0A = '#e7bdb6',
    base0B = '#ffb4a8',
    base0C = '#705c2e',
    base0D = '#9c4236',
    base0E = '#775651',
    base0F = '#ba1a1a',
  }

  require('base16-colorscheme').setup(base16_colors)
  return
end

local content = colors_file:read('*all')
colors_file:close()

local ok, colors_data = pcall(vim.fn.json_decode, content)
if not ok then
  -- vim.notify('Failed to parse Mutagen colors JSON: ' .. tostring(colors_data), vim.log.levels.ERROR)
  return
end

local colors = colors_data.colors
if not colors then
  -- vim.notify('No colors found in Mutagen JSON', vim.log.levels.ERROR)
  return
end

local base16_colors = {
  base00 = colors.base00,
  base01 = colors.base01,
  base02 = colors.base02,
  base03 = colors.base03,
  base04 = colors.base04,
  base05 = colors.base05,
  base06 = colors.base06,
  base07 = colors.base07,
  base08 = colors.base08,
  base09 = colors.base09,
  base0A = colors.base0A,
  base0B = colors.base0B,
  base0C = colors.base0C,
  base0D = colors.base0D,
  base0E = colors.base0E,
  base0F = colors.base0F,
}

require('base16-colorscheme').setup(base16_colors)
