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

-- @param func function
-- @return Cache
function M.Cache:new(func)
   local tbl = {
      func = func,
      results = {}
   }
   self.__index = self
   setmetatable(tbl, self)
   return tbl
end

-- @param args table
function M.Cache:_call(args)
   self.results[args] = self.func(args)
end

-- @param args table
-- @return table
function M.Cache:call(args)
   if self.results[args] == nil then
      self.results = {}
      self:_call(args)
   end
   return self.results[args]
end

return M
