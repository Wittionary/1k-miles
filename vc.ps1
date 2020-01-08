# First two measures
# https://www.musicnotes.com/sheetmusic/mtd.asp?ppn=MN0043758
# http://www.words3music.ph/sheets/VanessaCarlton-AThousandMiles.pdf
# https://en.wikipedia.org/wiki/Scientific_pitch_notation#Table_of_note_frequencies
# Going up an octave increases freq by x2
# Going down an octave decreases note freq by .5
# Mathematically, given the number n of semitones above middle C, the fundamental frequency in hertz is given by 440*(2^(n-9)/12)
# How to deal with negative/fraction exponents: https://www.sparknotes.com/math/algebra2/exponentialfunctions/section1/
# Just make function for notes instead of hardcoding

$C4 = 261.63
$A4 = 440
function Get-NoteFrequency {
    Param (
        [string]$letterAndNumber
    )

    # add stuff like ESHARP = F etc.
    $validNoteList = @("C", "CSHARP", "DFLAT", "D", "DSHARP",
        "EFLAT", "E", "F", "FSHARP", "GFLAT",
        "G", "GSHARP", "AFLAT", "A", "ASHARP",
        "BFLAT", "B")

    $noteList = @("C", "CSHARP", "D", "DSHARP",
        "E", "F", "FSHARP",
        "G", "GSHARP", "A", "ASHARP", "B")

    #take the number off the end of the string so you can split up the LETTER and NUMBER into two different values
    $letter = $letterAndNumber.Substring(0, ($letterAndNumber.Length - 1))
    $number = $letterAndNumber.Substring(($letterAndNumber.Length - 1), 1)
    $number = $number -as [int]
    Write-Host "letter: $letter `nnumber: $number"

    $letter = $letter -replace '#', 'sharp'

    if ($letter.Length -gt 1) {
        # replace 'b' with 'flat' if it's not the only letter in the string
        $letter = $letter -replace 'b', 'flat'
    }
    
    $letter = $letter.ToUpper()
    $letter = $letter -replace '\s', ''

    # Did the user enter a valid note letter?
    if (-Not $validNoteList.Contains($letter)) {
        Write-Error "$Letter is not a valid note value."
        return
    }
    elseif ($number -lt 0 -or $number -gt 10) {
        # Write error to console "invalid octave. try 1 through 10"
        Write-Error "$number is an invalid octave. Use an integer 1 through 10."
        return
    }
    # Add case for non-integer being entered
         
 

    $octaveDifference = $number - 4 # num of times and direction to loop
    $semitonesDifference = 0

    if ($octaveDifference -gt 0) {
        # count up
        foreach ($note in $noteList) {
            #this doesn't yet account for looping through the array multiple times
            $semitonesDifference++ 
            if ($note -eq $letter) {
                break
            }
        }
    }
    elseif ($octaveDifference -lt 0) {
        # count down
    }
    else {
        # it's 0
    }

    write-host "Get-Note semitonesDifference: $semitonesDifference"
    $frequency = $A4 * [math]::pow(2, (($semitonesDifference - 9) / 12))
    write-host "Get-Note Frequency: $frequency"
    return $frequency

}

function Invoke-Note {
    Param (
        [int]$frequency, 
        [int]$duration = 1000
    )
    #add: receive freq from pipeline
    write-host "Invoke-Note Frequency: $frequency"
    [console]::beep($frequency, $duration)
}
$duration = 2000 #in milliseconds

# https://www.musicnotes.com/sheetmusic/mtd.asp?ppn=MN0043758
# https://www.hooktheory.com/theorytab/view/vanessa-carlton/a-thousand-miles
$measure1 = @("b6", "b5", "b6", "asharp6", "b5", "asharp6", "fsharp6" <#long#>, "dsharp6", "csharp6", "b5")
$measure2 = @("b6", "b5", "b6", "asharp6", "b5", "asharp6", "fsharp6", "b5", "fsharp6", "b5", "fsharp6", "b5", "dsharp6", "e6", "dsharp6", "csharp6")
$measure3 = $measure1
$measure4 = @("dsharp6", "csharp6", "b5", "dsharp6", "csharp6", "b5", "fsharp6" <#long#>, "csharp6")
Write-Host "start beeps"
Invoke-Note -frequency (Get-NoteFrequency "dsharp5") -duration $duration

Write-Host "end beeps"
