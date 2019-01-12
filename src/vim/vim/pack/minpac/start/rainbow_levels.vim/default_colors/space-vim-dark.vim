if has("gui_running")
	hi default link RainbowLevel0 Identifier
	hi default link RainbowLevel1 Constant
	hi default link RainbowLevel2 Debug
	hi default link RainbowLevel3 String
	hi default link RainbowLevel4 Operator
	hi default link RainbowLevel5 Type
	hi default link RainbowLevel6 Special
	hi default link RainbowLevel7 Character
else
	hi default link RainbowLevel0 Identifier
	hi default link RainbowLevel1 Todo
	hi default link RainbowLevel2 Boolean
	hi default link RainbowLevel3 String
	hi default link RainbowLevel4 Character
	hi default link RainbowLevel5 Type
	hi default link RainbowLevel6 Float
	hi default link RainbowLevel7 Special
endif

for level in range(0, 7)
	exe 'hi! link RainbowLevel'.(level+8).' RainbowLevel'.level
endfor
