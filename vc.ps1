# First two measures
# HiB B HiB HiA B HiA HiF -- D C B ???
# http://www.words3music.ph/sheets/VanessaCarlton-AThousandMiles.pdf
# https://en.wikipedia.org/wiki/Scientific_pitch_notation#Table_of_note_frequencies
# Going up an octave increases freq by x2
# Going down an octave decreases note freq by .5
# Mathematically, given the number n of semitones above middle C, the fundamental frequency in hertz is given by 440*(2^(n-9)/12)
# How to deal with negative/fraction exponents: https://www.sparknotes.com/math/algebra2/exponentialfunctions/section1/
# Just make function for notes instead of hardcoding

$C4 = 261.63
$A4 = 440
function Get-Distance { }
function Get-NoteFrequency {
    Param ([string]$letter, [int]$number)

    Write-Host "start func"
    # add stuff like ESHARP = F etc.
    $validNoteList = @("C","CSHARP", "DFLAT", "D", "DSHARP",
                "EFLAT", "E", "F", "FSHARP", "GFLAT",
                "G", "GSHARP", "AFLAT", "A", "ASHARP",
                "BFLAT", "B")

    $noteList = @("C","CSHARP", "D", "DSHARP",
     "E", "F", "FSHARP",
    "G", "GSHARP", "A", "ASHARP", "B")

    $letter = $letter -replace '#', 'sharp'

    Write-Host "30"
    if ($letter.Length -gt 1){ # replace 'b' with 'flat' if it's not the only letter in the string
        $letter = $letter -replace 'b', 'flat'
    }
    
    $letter = $letter.ToUpper()
    $letter = $letter -replace '\s', ''

    Write-Host "38"
    # Did the user enter a valid note letter?
    if (-Not $validNoteList.Contains($letter)){
        # Write error to console "not a valid note value"
        return
    } elseif ($number -lt 0 -or $number -gt 10) {
        # Write error to console "invalid octave. try 1 through 10"
        return
    }
         
 

    $octaveDifference = $number - 4 # num of times to loop
    $semitonesDifference = 0

    Write-Host "53"
    if ($octaveDifference -gt 0){
        # count up
        foreach ($note in $noteList){#this doesn't yet account for looping through the array multiple times
            $semitonesDifference++ 
            if ($note -eq $letter){
                break
            }
        }
    } elseif ($octaveDifference -lt 0) {
        # count down
    } else {
        # it's 0
    }
    Write-Host "start calc"
    $frequency = 440 * [math]::pow(2,(($semitonesDifference - 9)/12))
    Write-Host "end func"
    return $frequency

}
# ----- x4
$C4=261.63
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


$duration=2000 #1 sec

Write-Host "start beeps"
[console]::beep((Get-NoteFrequency "d" 5),$duration)
[console]::beep((Get-NoteFrequency "b" 5), $duration)
Write-Host "end beeps"
