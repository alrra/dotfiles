hi default link RainbowLevel0 Special
hi default link RainbowLevel1 PreProc
hi default link RainbowLevel2 Type
hi default link RainbowLevel3 Statement
hi default link RainbowLevel4 Constant
hi default link RainbowLevel5 Identifier
hi default link RainbowLevel6 Underlined

for level in range(0, 6)
	exe 'hi! link RainbowLevel'.(level+7).' RainbowLevel'.level
endfor
