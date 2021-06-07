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
        [string]$LetterAndNumber
    )

    # add stuff like ESHARP = F etc.
    $ValidNoteList = @("C", "CSHARP", "DFLAT", "D", "DSHARP",
        "EFLAT", "E", "F", "FSHARP", "GFLAT",
        "G", "GSHARP", "AFLAT", "A", "ASHARP",
        "BFLAT", "B")

    $NoteList = @("C", "CSHARP", "D", "DSHARP",
        "E", "F", "FSHARP",
        "G", "GSHARP", "A", "ASHARP", "B")

    #take the number off the end of the string so you can split up the LETTER and NUMBER into two different values
    $letter = $LetterAndNumber.Substring(0, ($LetterAndNumber.Length - 1))
    $Number = $LetterAndNumber.Substring(($LetterAndNumber.Length - 1), 1)
    $Number = $Number -as [int]
    #Write-Host "letter: $letter `nnumber: $Number"

    $letter = $letter -replace '#', 'sharp'

    if ($letter.Length -gt 1) {
        # replace 'b' with 'flat' if it's not the only letter in the string
        $letter = $letter -replace 'b', 'flat'
    }
    
    $letter = $letter.ToUpper()
    $letter = $letter -replace '\s', ''

    # Did the user enter a valid note letter?
    if (-Not $ValidNoteList.Contains($letter)) {
        Write-Error "$Letter is not a valid note value."
        return
    }
    elseif ($Number -lt 0 -or $Number -gt 10) {
        # Write error to console "invalid octave. try 1 through 10"
        Write-Error "$Number is an invalid octave. Use an integer 1 through 10."
        return
    }
    # Add case for non-integer being entered
         
 

    $OctaveDifference = $Number - 4 # num of times and direction to loop
    $semitonesDifference = 0

    if ($OctaveDifference -gt 0) {
        # count up
        foreach ($note in $NoteList) {
            #this doesn't yet account for looping through the array multiple times
            $semitonesDifference++ 
            if ($note -eq $letter) {
                break
            }
        }
    }
    elseif ($OctaveDifference -lt 0) {
        # count down
    }
    else {
        # it's 0
    }

    $Frequency = $A4 * [math]::pow(2, (($semitonesDifference - 9) / 12))
    return $Frequency
}

function Invoke-Note {
    Param (
        [Parameter(ValueFromPipeline = $true)]
        [int]$Frequency, 
        [int]$Duration = 110
    )
    #write-host "Invoke-Note Frequency: $Frequency"
    [console]::beep($Frequency, $Duration)
}

function Invoke-Measure {
    Param (
        [Parameter(Mandatory=$true)]
        [array]
        $Measure
    )

    foreach ($Note in $Measure) {
        Get-NoteFrequency -LetterAndNumber $Note.Note | Invoke-Note -Duration $Note.Duration
    }
}

# https://www.musicnotes.com/sheetmusic/mtd.asp?ppn=MN0043758
# https://www.hooktheory.com/theorytab/view/vanessa-carlton/a-thousand-miles
# --------------------------------------- INTRO ---------------------------------------
$measure1 = @(@{note="b6";duration="110"},
            @{note="b5";duration="110"},
            @{note="b6";duration="110"},
            @{note="asharp6";duration="110"},
            @{note="b5";duration="110"},
            @{note="asharp6";duration="110"},
            @{note="fsharp6";duration="600" },
            @{note="dsharp6";duration="200"},
            @{note="csharp6";duration="110"},
            @{note="b5";duration="110"})

$measure2 = @(@{note="b6";duration="110"},
            @{note="b5";duration="110"},
            @{note="b6";duration="110"},
            @{note="asharp6";duration="110"},
            @{note="b5";duration="110"},
            @{note="asharp6";duration="110"},
            @{note="fsharp6";duration="110"},
            @{note="b5";duration="110"},
            @{note="fsharp6";duration="110"},
            @{note="b5";duration="110"},
            @{note="fsharp6";duration="110"},
            @{note="b5";duration="110"},
            @{note="dsharp6";duration="110"},
            @{note="e6";duration="110"},
            @{note="dsharp6";duration="110"},
            @{note="csharp6";duration="110"})

$measure3 = $measure1
$measure4 = @(@{note="dsharp6";duration="110"},
            @{note="csharp6";duration="110"},
            @{note="b5";duration="110"},
            @{note="dsharp6";duration="110"},
            @{note="csharp6";duration="110"},
            @{note="b5";duration="110"},
            @{note="fsharp6";duration="400"},
            @{note="csharp6";duration="400"})


Invoke-Measure -Measure $measure1
Invoke-Measure -Measure $measure2
Invoke-Measure -Measure $measure3
Invoke-Measure -Measure $measure4