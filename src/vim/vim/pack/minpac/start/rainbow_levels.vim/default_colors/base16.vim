hi default link RainbowLevel0 Character
hi default link RainbowLevel1 Number
hi default link RainbowLevel2 PreProc
hi default link RainbowLevel3 String
hi default link RainbowLevel4 Special
hi default link RainbowLevel5 Function
hi default link RainbowLevel6 Conditional

for level in range(0, 6)
	exe 'hi! link RainbowLevel'.(level+7).' RainbowLevel'.level
endfor
