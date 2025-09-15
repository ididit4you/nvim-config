require("mcphub").setup({
  workspace = {
    enabled = true,                            -- Default: true
    look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" },
    reload_on_dir_changed = true,              -- Auto-switch on directory change
    port_range = { min = 40000, max = 41000 }, -- Port range for workspace hubs
    get_port = nil,                            -- Optional function for custom port assignment
  }
})
