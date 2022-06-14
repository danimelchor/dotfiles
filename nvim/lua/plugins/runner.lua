M = {}

local run_command_table = {
    ['cpp'] = 'g++ % -o %:r && ./%:r',
    ['c'] = 'gcc % -o %:r && ./%:r',
    ['python'] = 'python3 %',
    ['lua'] = 'lua %',
    ['java'] = 'javac % && java %:r',
    ['zsh'] = 'zsh %',
    ['sh'] = 'sh %',
    ['rust'] = 'rustc % && ./%:r',
    ['go'] = 'go run %',
    ['javascript'] = 'node %'
}

local command = 'echo \"\\\\033[0;33mExecuting \\\\"' .. run_command_table[vim.bo.filetype] .. '\\\\"\\\\033[0m\\\\n\";'
local extra = 'echo \"\\\\n\\\\033[0;33mPlease press ENTER to continue \\\\033[0m\"; read; exit;'

function M.run()
    if (run_command_table[vim.bo.filetype]) then
       vim.cmd("2TermExec cmd='clear;" .. command .. run_command_table[vim.bo.filetype].."; " .. extra .. "' direction=float")
   else
       print("\nFileType not supported\n")
   end
end

return M
