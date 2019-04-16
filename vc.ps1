# First two measures
# HiB B HiB HiA B HiA HiF -- D C B ???
# http://www.words3music.ph/sheets/VanessaCarlton-AThousandMiles.pdf
# https://en.wikipedia.org/wiki/Scientific_pitch_notation#Table_of_note_frequencies
# Going up an octave increases freq by x2
# Going down an octave decreases note freq by .5
# Mathematically, given the number n of semitones above middle C, the fundamental frequency in hertz is given by 440*(2^(n-9)/12)
# How to deal with negative/fraction exponents: https://www.sparknotes.com/math/algebra2/exponentialfunctions/section1/
# Just make function for notes instead of hardcoding

# ----- x4
$C4=261.6
$Cs4=277.2
$Db4=$Cs4
$D4=293
$Ds4=311.1
$Eb4=$Ds4
$E4=329.6
$F4=349.2
$Fs4=370.0
$Gb4=$Fs4
$G4=392.0
$Gs4=415.3
$Ab4=$Gs4
$A4=440
$As4=466.1
$Bb4=$As4
$B4=493.9

# ----- x5
$C5=523.25
$Cs5=554.37
$Db5=$Cs5
$D5=587.33
$Ds5=622.25 
$Eb5=$Ds5
$E5=659.26
$F5=659.26
$Fs5=739.99
$Gb5=$Fs5
$G5=783.99
$Gs5=830.61
$Ab5=$Gs5
$A5=880.00
$As5=932.33
$Bb5=$As5
$B5=987.77

$duration=1000 #1 sec

[console]::beep($C*2,$duration)
[console]::beep($D*2,$duration)

