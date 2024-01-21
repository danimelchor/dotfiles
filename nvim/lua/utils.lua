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

-- @class Cache
-- @field func function
-- @field checked boolean
-- @field result table
M.Cache = {}
M.Cache.__index = M.Cache

-- @param func function
-- @return Cache
M.Cache.new = function(func)
   local tbl = {}
   tbl.func = func
   tbl.checked = false
   tbl.result = {}
   setmetatable(tbl, M.Cache)
   return tbl
end

-- @param args table
M.Cache._call = function(self, args)
   self.result = self.func(args)
   self.checked = true
end

-- @param args table
-- @return table
M.Cache.call = function(self, args)
   if not self.checked then
      self:_call(args)
   end
   return self.result
end


return M
