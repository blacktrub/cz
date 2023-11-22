local null_ls = require("null-ls")

local need_to_install = { "goimports", "stylua", "black", "jq" }

require("mason-null-ls").setup({
  ensure_installed = need_to_install,
})

local sources = {
  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.gofmt,
  null_ls.builtins.formatting.goimports,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.jq,
  null_ls.builtins.code_actions.gomodifytags,
  null_ls.builtins.code_actions.impl,
}

null_ls.setup({
  sources = sources,
  -- debug = true,
})

local nilaway = {
  name = "nilaway",
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "go" },
  generator = null_ls.generator({
    command = "nilaway",
    args = { "-json", "-pretty-print=false", "$DIRNAME" },
    from_stderr = true,
    format = "raw",
    check_exit_code = function(code, stderr)
      return code ~= 0
    end,
    on_output = function(params, done)
      local output = params.output
      local ok, parsed = pcall(vim.json.decode, output)
      if not ok or not parsed then
        return
      end

      local diagnostics = {}
      for _, value in pairs(parsed) do
        for _, item in ipairs(value["nilaway"]) do
          local line, col = item.posn:match(".*.go:(%d+):(%d+)")
          table.insert(diagnostics, {
            row = line,
            col = col,
            message = value.message,
            severity = vim.diagnostic.severity.WARN,
          })
        end
      end

      return done(diagnostics)
    end,
  }),
}

-- null_ls.register(nilaway)
