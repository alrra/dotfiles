if has("gui_running")
	hi default link RainbowLevel0 Special
else
	hi default link RainbowLevel0 Todo
endif

hi default link RainbowLevel1 Function
hi default link RainbowLevel2 Type
hi default link RainbowLevel3 String
hi default link RainbowLevel4 Statement
hi default link RainbowLevel5 PreProc
hi default link RainbowLevel6 Number

for level in range(0, 6)
	exe 'hi! link RainbowLevel'.(level+7).' RainbowLevel'.level
endfor
