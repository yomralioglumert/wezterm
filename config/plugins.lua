local wezterm = require('wezterm')

local nf = wezterm.nerdfonts

local M = {}

local function require_plugin(url)
   local ok, plugin = pcall(wezterm.plugin.require, url)
   if not ok then
      wezterm.log_warn('Could not load plugin: ' .. url, plugin)
      return nil
   end
   return plugin
end

local function append_key(config, key)
   config.keys = config.keys or {}
   table.insert(config.keys, key)
end

local function protected_call(label, fn)
   local ok, err = pcall(fn)
   if not ok then
      wezterm.log_warn(label, err)
   end
end

local function setup_workspace_switcher(config)
   local workspace_switcher =
      require_plugin('https://github.com/MLFlexer/smart_workspace_switcher.wezterm')
   if not workspace_switcher then
      return nil
   end

   workspace_switcher.zoxide_path = '/opt/homebrew/bin/zoxide'
   workspace_switcher.workspace_formatter = function(label)
      return wezterm.format({
         { Foreground = { Color = '#57E389' } },
         { Attribute = { Intensity = 'Bold' } },
         { Text = nf.md_briefcase_variant .. '  ' .. label },
      })
   end

   append_key(config, {
      key = 's',
      mods = 'LEADER',
      action = workspace_switcher.switch_workspace(),
   })
   append_key(config, {
      key = 'S',
      mods = 'LEADER',
      action = workspace_switcher.switch_to_prev_workspace(),
   })

   return workspace_switcher
end

local function setup_resurrect(config, workspace_switcher)
   local resurrect = require_plugin('https://github.com/MLFlexer/resurrect.wezterm')
   if not resurrect then
      return
   end

   resurrect.state_manager.set_max_nlines(2000)
   resurrect.state_manager.periodic_save({
      interval_seconds = 900,
      save_workspaces = true,
      save_windows = false,
      save_tabs = false,
   })

   append_key(config, {
      key = 'r',
      mods = 'LEADER',
      action = wezterm.action_callback(function(window, pane)
         resurrect.fuzzy_loader.fuzzy_load(window, pane, function(id)
            if not id then
               return
            end

            local state_type = string.match(id, '^([^/]+)')
            local name = string.match(id, '([^/]+)$')
            name = string.match(name, '(.+)%..+$') or name
            local opts = {
               relative = true,
               restore_text = true,
               on_pane_restore = resurrect.tab_state.default_on_pane_restore,
            }

            protected_call('Could not restore state: ' .. id, function()
               if state_type == 'workspace' then
                  resurrect.workspace_state.restore_workspace(
                     resurrect.state_manager.load_state(name, 'workspace'),
                     opts
                  )
               elseif state_type == 'window' then
                  resurrect.window_state.restore_window(
                     pane:window(),
                     resurrect.state_manager.load_state(name, 'window'),
                     opts
                  )
               elseif state_type == 'tab' then
                  resurrect.tab_state.restore_tab(
                     pane:tab(),
                     resurrect.state_manager.load_state(name, 'tab'),
                     opts
                  )
               end
            end)
         end)
      end),
   })

   append_key(config, {
      key = 'R',
      mods = 'LEADER',
      action = wezterm.action_callback(function()
         protected_call('Could not save workspace state', function()
            resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
         end)
      end),
   })

   wezterm.on('smart_workspace_switcher.workspace_switcher.created', function(window, _path, label)
      protected_call('Could not restore workspace: ' .. label, function()
         resurrect.workspace_state.restore_workspace(
            resurrect.state_manager.load_state(label, 'workspace'),
            {
               window = window,
               relative = true,
               restore_text = true,
               on_pane_restore = resurrect.tab_state.default_on_pane_restore,
            }
         )
      end)
   end)

   wezterm.on('smart_workspace_switcher.workspace_switcher.selected', function()
      protected_call('Could not save workspace state', function()
         resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
      end)
   end)

   wezterm.on('augment-command-palette', function()
      local palette = {
         {
            brief = 'Workspace: restore session',
            icon = 'md_backup_restore',
            action = config.keys[#config.keys - 1].action,
         },
         {
            brief = 'Workspace: save session',
            icon = 'md_content_save',
            action = config.keys[#config.keys].action,
         },
      }

      if workspace_switcher then
         table.insert(palette, 1, {
            brief = 'Workspace: switch',
            icon = 'md_briefcase_arrow_up_down',
            action = workspace_switcher.switch_workspace(),
         })
         table.insert(palette, 2, {
            brief = 'Workspace: previous',
            icon = 'md_briefcase_clock',
            action = workspace_switcher.switch_to_prev_workspace(),
         })
      end

      return palette
   end)
end

function M.apply_to_config(config)
   local workspace_switcher = setup_workspace_switcher(config)
   setup_resurrect(config, workspace_switcher)
end

return M
