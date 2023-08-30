local M = {}

function M.exists(file)
   -- If ~ in file, expand
   if file:sub(1, 1) == "~" then
      file = os.getenv("HOME") .. file:sub(2)
   end

   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   if not ok then print(err) end
   return ok
end

function M.is_stripe()
   return M.exists('~/stripe')
end

return M
