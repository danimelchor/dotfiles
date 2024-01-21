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
-- @field results table
M.Cache = {}
M.Cache.__index = M.Cache

-- @param func function
-- @return Cache
M.Cache.new = function(func)
   local tbl = {}
   tbl.func = func
   tbl.results = {}
   setmetatable(tbl, M.Cache)
   return tbl
end

-- @param args table
M.Cache._call = function(self, args)
   self.results[args] = self.func(args)
end

-- @param args table
-- @return table
M.Cache.call = function(self, args)
   if self.results[args] == nil then
      self.results = {}
      self:_call(args)
   end
   return self.results[args]
end


return M
