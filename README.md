# vim-runner
a) Run current line as commad
b) Run selection as command
# Dependency
none
# Usecase
-quickly run code without the need for copying line from file and pasting it in commandline.
-tremendously useful for debugging.
-line can be commented. Parser strips the comment character and then runs the code.
# Mapping
when .vim filetype is opened/read automapping is done.
<leader><CR>	run current line as vim command
<leader><CR>	run selected lines as vim commands
# Supported
viml
Rscript (minimalistic, fuller alternative is NVIM-R)
