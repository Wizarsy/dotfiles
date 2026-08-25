require("git"):setup()
require("term-cwd"):setup()
require("copy-file-contents"):setup { notification = true }
require("zoxide"):setup { update_db = true }

function Linemode:size_and_mtime()
  local mtime, date
  mtime = math.floor(self._file.cha.mtime or 0)
  if mtime == 0 then
    date = ""
  elseif os.date("%Y", mtime) == os.date("%Y") then
    date = os.date("%m/%d %H:%M", mtime)
  else
    date = os.date("%m/%d  %Y", mtime)
  end
  local size = self._file:size()
  return string.format("%s %s", size and ya.readable_size(size) or "-", date)
end
