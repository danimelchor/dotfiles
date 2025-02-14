local M = {}

function M.exists(file)
   -- If ~ in file, expand
   if file:sub(1, 1) == "~" then
      file = os.getenv("HOME") .. file:sub(2)
   end

   local ok, _, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok
end

function M.is_stripe()
   return M.exists('~/stripe')
end

---@class Opts
---@field cwd string
---@field callback function

---@param cmd table
---@param opts Opts
function M.run_command(cmd, opts)
   -- Destructure cmd
   local base = table.remove(cmd, 1)
   local args = cmd

   local stdin = vim.uv.new_pipe()
   local stdout = vim.uv.new_pipe()
   local stderr = vim.uv.new_pipe()

   vim.uv.spawn(base, {
      cwd = opts.cwd,
      stdio = { stdin, stdout, stderr },
      args = args,
   })

   vim.uv.read_start(stdout, function(err, data)
      assert(not err, err)
      if data then
         vim.schedule(function()
            opts.callback(data)
         end)
      end
   end)
end

P = function(what)
   print(vim.inspect(what))
end

return M
