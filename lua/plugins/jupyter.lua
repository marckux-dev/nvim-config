-- path: ./lua/plugins/jupyter.lua
-- Jupyter notebook integration via molten-nvim (runner) + jupytext (file format)
return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    init = function()
      -- Use the dedicated jupyter venv for the kernel
      vim.g.python3_host_prog = vim.fn.expand("~/.venv/jupyter/bin/python3")
      vim.g.molten_image_provider = "none"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    keys = {
      { "<leader>ji", "<cmd>MoltenInit<cr>",                     desc = "Jupyter: init kernel" },
      { "<leader>je", "<cmd>MoltenEvaluateOperator<cr>",         desc = "Jupyter: eval operator", expr = true },
      { "<leader>jl", "<cmd>MoltenEvaluateLine<cr>",             desc = "Jupyter: eval line" },
      { "<leader>jv", "<cmd>MoltenEvaluateVisual<cr>",           desc = "Jupyter: eval visual", mode = "v" },
      { "<leader>jc", "<cmd>MoltenReevaluateCell<cr>",           desc = "Jupyter: re-eval cell" },
      { "<leader>jd", "<cmd>MoltenDelete<cr>",                   desc = "Jupyter: delete cell output" },
      { "<leader>jh", "<cmd>MoltenHideOutput<cr>",               desc = "Jupyter: hide output" },
      { "<leader>js", "<cmd>MoltenShowOutput<cr>",               desc = "Jupyter: show output" },
      { "<leader>jo", "<cmd>MoltenOpenInBrowser<cr>",            desc = "Jupyter: open in browser" },
    },
  },
  {
    -- Converts .ipynb <-> .py/.md on open/save via jupytext
    "GCBallesteros/jupytext.nvim",
    config = function()
      require("jupytext").setup({
        style = "hydrogen",        -- use # %% cell markers
        output_extension = "py",
        force_ft = "python",
      })
    end,
  },
}
