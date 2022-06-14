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
    ['javascript'] = 'node %',
    ['ruby'] = 'ruby %'
}

local extra = 'echo \"\\\\n\\\\033[0;33mPlease press ENTER to continue \\\\033[0m\"; read; exit;'

function M.run()
    local ft = vim.bo.filetype
    local cmd_to_run = run_command_table[ft]

    if (cmd_to_run) then
        local cmd_title = 'echo \"\\\\033[0;33mExecuting \\\\"' ..
            cmd_to_run .. '\\\\"\\\\033[0m\\\\n\";'
        vim.cmd("2TermExec cmd='clear;" ..
            cmd_title .. cmd_to_run .. "; " .. extra .. "' direction=float")
    else
        print("\nFileType not supported\n")
    end
end

return M
