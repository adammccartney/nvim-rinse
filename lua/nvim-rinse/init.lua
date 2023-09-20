local M = {}

--generate n random integers in the range l to r
M._grint = function(n, l, r)
    local res = {}
    for i = 1, n do
        res[i] = math.random(l, r)
    end
    return res
end

-- Format a table of values into a line where IFS=,
M._fprintarr = function(A)
    local line = ""
    local len = #A
    for i = 1, len do
        if i < len then
            line = line .. string.format("%i, ", A[i])
        else
            line = line .. tostring(A[i])
        end
    end
    return line
end

-- setup for plugin, creates global commands
M.setup = function()
    vim.api.nvim_create_user_command('Ninsert',
    function(opts)
        -- split the args into individual values
        local args = vim.fn.split(opts.fargs[1], ",")
        local n = tonumber(args[1])
        local l = tonumber(args[2])
        local r = tonumber(args[3])
        local nums = M._grint(n, l, r)
        local line = M._fprintarr(nums)
        vim.fn.setreg("n", line)
        vim.cmd([[:startinsert]])
        vim.cmd([[:call append(line('.'), getreg('n'))]])
    end,
    { nargs = 1 })
end

return M
