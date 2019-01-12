if has("gui_running")
	hi default link RainbowLevel0 PreProc
	hi default link RainbowLevel1 Type
	hi default link RainbowLevel2 Statement
	hi default link RainbowLevel3 Identifier
	hi default link RainbowLevel4 Comment
	hi default link RainbowLevel5 Constant
else
	hi default link RainbowLevel0 Constant
	hi default link RainbowLevel1 Statement
	hi default link RainbowLevel2 Type
	hi default link RainbowLevel3 Identifier
	hi default link RainbowLevel4 Comment
	hi default link RainbowLevel5 Special
endif

for level in range(0, 5)
	exe 'hi! link RainbowLevel'.(level+6).' RainbowLevel'.level
endfor
