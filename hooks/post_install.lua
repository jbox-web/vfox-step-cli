--- Performs additional setup after installation
--- Documentation: https://mise.jdx.dev/tool-plugin-development.html#postinstall-hook
--- @param ctx {rootPath: string, runtimeVersion: string, sdkInfo: table} Context

require("util")

local log = require("log")

function PLUGIN:PostInstall(ctx)
  local sdkInfo = ctx.sdkInfo[PLUGIN.name]
  local path = sdkInfo.path

  local binaries = {"step"}
  install_from_list(path, binaries)

  -- Verify installation works
  local destFile = path .. "/bin/step"
  local result = os.execute(destFile .. " version > /dev/null 2>&1")
  if result ~= 0 then
    error(PLUGIN.name .. " installation appears to be broken")
  end
end
