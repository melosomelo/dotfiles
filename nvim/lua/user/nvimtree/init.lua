local nvimtree_util = require "user.nvimtree.util"

require("nvim-tree").setup {
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false, -- disable neovims default file explorer
  hijack_cursor = true, -- keep the cursor on the first letter of the filename
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  root_dirs = {},
  prefer_startup_root = false,
  update_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 25,
    height = 30,
    hide_root_folder = false,
    side = "right",
    preserve_window_proportions = false,
    number = false,
    relativenumber = true,
    signcolumn = "yes",
    mappings = {
      custom_only = true,
      list = {{
        key = {"<CR>", "l"},
        action = "open"
      }, {
        key = "<C-v>",
        action = "vsplit"
      }, {
        key = "<C-x>",
        action = "split"
      }, {
        key = "<Tab>",
        action = "preview"
      }, {
        key = "d",
        action = "remove"
      }, {
        key = "r",
        action = "full_rename"
      }, {
        key = "<C-n>",
        action = "new",
        action_cb = nvimtree_util.create
      }, {
        key = "m",
        action = "move",
        action_cb = nvimtree_util.move
      }, {
        key = "<C-t>",
        action = "tab",
        action_cb = nvimtree_util.tab
      }}
    }
  },
  renderer = {
    add_trailing = true,
    group_empty = false,
    highlight_git = true,
    full_name = false,
    highlight_opened_files = "name",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "│ ",
        none = "  "
      }
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = ""
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌"
        }
      }
    },
    special_files = {"Cargo.toml", "Makefile", "README.md", "readme.md"}
  },
  hijack_directories = {
    enable = true,
    auto_open = true
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    update_root = false,
    ignore_list = {}
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {}
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = ""
    }
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {}
  },
  filesystem_watchers = {
    enable = false,
    interval = 100
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 400
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false
    },
    expand_all = {
      max_folder_discovery = 300
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = {"notify", "packer", "qf", "diff", "fugitive", "fugitiveblame"},
          buftype = {"nofile", "terminal", "help"}
        }
      }
    },
    remove_file = {
      close_window = true
    }
  },
  trash = {
    cmd = "gio trash",
    require_confirm = true
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false
    }
  }
}
