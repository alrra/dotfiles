hi default link RainbowLevel0 String
hi default link RainbowLevel1 Identifier
hi default link RainbowLevel2 Function
hi default link RainbowLevel3 Comment
hi default link RainbowLevel4 Number
hi default link RainbowLevel5 Float
hi default link RainbowLevel6 Boolean

for level in range(0, 6)
	exe 'hi! link RainbowLevel'.(level+7).' RainbowLevel'.level
endfor
