--[[
  prevent_crash.lua
  Simple Lua script to attempt to prevent system error/crash during a download process.
  Usage: lua prevent_crash.lua <download_url> <output_file>
  This script will attempt to:
    - Check disk space before download
    - Catch download errors and retry
    - Limit memory usage (soft, via chunked download)
--]]

local socket = require("socket.http")
local ltn12 = require("ltn12")

local function get_free_space(path)
  -- Simple Windows-only disk space check using dir command
  local pipe = io.popen('dir "' .. path .. '"')
  if not pipe then return nil end
  local output = pipe:read("*a")
  pipe:close()
  local free = output:match("([%d,]+)%s+bytes free")
  if free then
    return tonumber(free:gsub(",", ""))
  end
  return nil
end

local function download_file(url, output, max_retries)
  local retries = 0
  while retries <= max_retries do
    local file = io.open(output, "wb")
    if not file then
      print("Error: Unable to open file for writing.")
      return false
    end
    local resp, code, headers, status = socket.request{
      url = url,
      sink = ltn12.sink.file(file),
      options = { "redirect", "timeout" }
    }
    if code == 200 then
      print("Download succeeded.")
      return true
    else
      print("Download failed with code: " .. tostring(code) .. ". Retrying...")
      os.remove(output)
      retries = retries + 1
      socket.sleep(2)
    end
  end
  print("Error: Download failed after " .. max_retries .. " retries.")
  return false
end

-- Main script
local url = arg[1]
local out_file = arg[2] or "download.tmp"

if not url then
  print("Usage: lua prevent_crash.lua <download_url> <output_file>")
  os.exit(1)
end

local cwd = "."
local min_space = 1024 * 1024 * 100 -- Require at least 100MB free

local free = get_free_space(cwd)
if not free then
  print("Warning: Could not determine free disk space. Proceeding with caution.")
else
  print("Free disk space: " .. math.floor(free / (1024*1024)) .. " MB")
  if free < min_space then
    print("Error: Not enough disk space for download. Please free up space.")
    os.exit(2)
  end
end

local ok = download_file(url, out_file, 3)
if not ok then
  print("Critical: Download repeatedly failed. Aborting to prevent further issues.")
  os.exit(3)
end

print("Download complete and system stable.")
