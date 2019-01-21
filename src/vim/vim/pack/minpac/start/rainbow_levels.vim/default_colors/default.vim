if &bg == 'dark'
	hi default link RainbowLevel0 Constant
	hi default link RainbowLevel1 Special
	hi default link RainbowLevel2 Statement
	hi default link RainbowLevel3 Type
	hi default link RainbowLevel4 Identifier
	hi default link RainbowLevel5 PreProc
	hi default link RainbowLevel6 NonText
else
	hi default link RainbowLevel0 Comment
	hi default link RainbowLevel1 Constant
	hi default link RainbowLevel2 Special
	hi default link RainbowLevel3 Identifier
	hi default link RainbowLevel4 Statement
	hi default link RainbowLevel5 PreProc
	hi default link RainbowLevel6 Normal
endif

for level in range(0, 6)
	exe 'hi! link RainbowLevel'.(level+7).' RainbowLevel'.level
endfor
