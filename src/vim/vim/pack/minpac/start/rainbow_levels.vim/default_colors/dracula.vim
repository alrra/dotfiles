hi default link RainbowLevel0 DraculaRed
hi default link RainbowLevel1 DraculaOrange
hi default link RainbowLevel2 DraculaYellow
hi default link RainbowLevel3 DraculaGreen
hi default link RainbowLevel4 DraculaCyan
hi default link RainbowLevel5 DraculaPurple
hi default link RainbowLevel6 DraculaPink

for level in range(0, 6)
	exe 'hi! link RainbowLevel'.(level+7).' RainbowLevel'.level
endfor
