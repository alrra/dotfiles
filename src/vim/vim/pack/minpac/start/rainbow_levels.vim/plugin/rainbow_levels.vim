com! RainbowLevelsOn     call rainbow_levels#on()
com! RainbowLevelsOff    call rainbow_levels#off()
com! RainbowLevelsToggle call rainbow_levels#toggle()

let s:colors_dir  = resolve(expand('<sfile>:p:h:h').'/default_colors')
let s:colors_file = rainbow_levels#get_colors_file(s:colors_dir)

exe 'source '.s:colors_file
