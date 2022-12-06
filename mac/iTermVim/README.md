# iTermVim

Applescript to open a file with iTerm2 and vim.

[iTermVim](itermvim.png)

Run to associate filetypes
```
awk ' { printf("duti -s com.apple.automator.iTermVim %s all\n", $1) } ' filetypes.txt | xargs -I {} sh -c "{}"
```
