require("git"):setup()
require("copy-file-contents"):setup({
	append_char = "\n",
	notification = true,
})

function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%m/%d %H:%M", time)
	else
		time = os.date("%m/%d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end