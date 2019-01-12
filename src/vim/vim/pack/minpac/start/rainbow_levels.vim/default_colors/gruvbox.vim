hi default link RainbowLevel0 GruvboxRed
hi default link RainbowLevel1 GruvboxOrange
hi default link RainbowLevel2 GruvboxYellow
hi default link RainbowLevel3 GruvboxGreen
hi default link RainbowLevel4 GruvboxAqua
hi default link RainbowLevel5 GruvboxBlue
hi default link RainbowLevel6 GruvboxPurple

for level in range(0, 6)
	exe 'hi! link RainbowLevel'.(level+7).' RainbowLevel'.level
endfor
