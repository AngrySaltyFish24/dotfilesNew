local cli = {}
local helper = require('core.helper')

function cli:env_init()
  self.module_path = helper.path_join(self.config_path, 'lua', 'modules')
  self.lazy_dir = helper.path_join(self.data_path, 'lazy')

  package.path = package.path
    .. ';'
    .. self.rtp
    .. '/lua/vim/?.lua;'
    .. self.module_path
    .. '/?.lua;'
  local shared = assert(loadfile(helper.path_join(self.rtp, 'lua', 'vim', 'shared.lua')))
  _G.vim = shared()
end

return cli
