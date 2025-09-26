local M = {}

function M.coderun()
  vim.cmd("write")

  local file = vim.fn.expand("%")
  local filetype = vim.bo.filetype
  local exec_dir = "./executables"

  -- Create exe files
  if filetype == "c" or filetype == "cpp" or filetype == "rust" or filetype == "java" then
    if vim.fn.isdirectory(exec_dir) == 0 then
      vim.fn.mkdir(exec_dir)
      vim.notify("Created directory: " .. exec_dir, vim.log.levels.INFO)
    end
  end

  local commands = {
    python = "python " .. vim.fn.shellescape(file),
    javascript = "node " .. vim.fn.shellescape(file),
    c = string.format("gcc %s -o %s/%s && %s/%s", vim.fn.shellescape(file), exec_dir, vim.fn.expand("%:r"), exec_dir, vim.fn.expand("%:r")),
    cpp = string.format("g++ %s -o %s/%s && %s/%s", vim.fn.shellescape(file), exec_dir, vim.fn.expand("%:r"), exec_dir, vim.fn.expand("%:r")),
    rust = string.format("rustc %s -o %s/%s && %s/%s", vim.fn.shellescape(file), exec_dir, vim.fn.expand("%:r"), exec_dir, vim.fn.expand("%:r")),
    java = string.format("javac -d %s *.java && java -cp %s %s", exec_dir, exec_dir, file),
  }

  if commands[filetype] then
    vim.cmd("split | terminal " .. commands[filetype])
    vim.cmd("autocmd termOpen * setlocal nowrap")
  else
    vim.notify("No run command configured for filetype: " .. filetype, vim.log.levels.WARN)
  end
end


function M.folderrun()
  vim.cmd("write")

  local file = vim.fn.expand("%")
  local filetype = vim.bo.filetype
  local exec_dir = "./executables"

  -- Ensure the executables directory exists
  if vim.fn.isdirectory(exec_dir) == 0 and filetype == "cpp" or filetype == "c" then
    vim.fn.mkdir(exec_dir)
    vim.notify("Created directory: " .. exec_dir, vim.log.levels.INFO)
  end

  local commands = {
    python = "python " .. vim.fn.shellescape(file),
    javascript = "node " .. vim.fn.shellescape(file),
    c = string.format("gcc %s -o %s/%s && %s/%s", vim.fn.shellescape(file), exec_dir, vim.fn.expand("%:r"), exec_dir, vim.fn.expand("%:r")),
    cpp = string.format("g++ *.cpp -o %s/%s && %s/%s", exec_dir, vim.fn.expand("%:r"), exec_dir, vim.fn.expand("%:r")),
    rust = "cargo run"
  }

  if commands[filetype] then
    vim.cmd("split | terminal " .. commands[filetype])
    vim.cmd("autocmd termOpen * setlocal nowrap")
  else
    vim.notify("No run command configured for filetype: " .. filetype, vim.log.levels.WARN)
  end
end


return M
