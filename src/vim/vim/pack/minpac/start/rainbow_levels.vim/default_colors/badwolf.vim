hi default link RainbowLevel0 clojureSpecial
hi default link RainbowLevel1 level5c
hi default link RainbowLevel2 level7c
hi default link RainbowLevel3 level3c
hi default link RainbowLevel4 level1c
hi default link RainbowLevel5 level4c
hi default link RainbowLevel6 level6c

for level in range(0, 6)
	exe 'hi! link RainbowLevel'.(level+7).' RainbowLevel'.level
endfor
