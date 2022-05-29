local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packet.init {
  display = {
    open_fn = function()
      return require("packer.util").float {
        border = "rounded"
      }
    end
  }
}

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
end)
