local M = {}

local defaults = {
    root_markers = { ".git", "package.json", "pyproject.toml", "Makefile" },
}

local function get_project_root(root_markers)
    local current_buf = vim.api.nvim_buf_get_name(0)
    if not current_buf or current_buf == "" or vim.bo.buftype ~= "" then
        return vim.fn.getcwd()
    end

    local file_dir = vim.fs.dirname(current_buf)

    local root_file = vim.fs.find(root_markers, {
        path = file_dir,
        upward = true,
    })[1]

    if root_file then
        -- vim.fs.find returns the path to the marker itself.
        -- If the marker is a directory (.git), dirname gives us the project root.
        -- If the marker is a file (package.json), dirname also gives us the project root.
        return vim.fs.dirname(root_file)
    end

    return vim.fn.getcwd()
end

M.copy_path = function(is_absolute, opts)
    -- Merge defaults with user opts for this specific call
    opts = vim.tbl_deep_extend("force", defaults, opts or {})

    local file_path = vim.api.nvim_buf_get_name(0)
    if not file_path or file_path == "" then
        vim.notify("Not a file buffer", vim.log.levels.WARN)
        return
    end

    local project_root = get_project_root(opts.root_markers)
    local result_path

    if is_absolute then
        result_path = vim.fs.normalize(file_path)
    else
        result_path = vim.fs.relpath(project_root, file_path)
    end

    if result_path then
        vim.fn.setreg("+", result_path)
        vim.notify("Copied: " .. result_path, vim.log.levels.INFO, { title = "Copy Path" })
    else
        vim.notify("Failed to calculate path", vim.log.levels.ERROR)
    end
end

M.setup = function(opts)
    -- Store opts in the setup or pass them to commands
    local final_opts = vim.tbl_deep_extend("force", defaults, opts or {})

    vim.api.nvim_create_user_command("LeCheminRelative", function()
        M.copy_path(false, final_opts)
    end, { desc = "Copy relative path to clipboard" })

    vim.api.nvim_create_user_command("LeCheminAbsolute", function()
        M.copy_path(true, final_opts)
    end, { desc = "Copy absolute path to clipboard" })
end

return M
