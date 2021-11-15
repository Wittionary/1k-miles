<#
 .Synopsis
  Displays a visual representation of a calendar.

 .Description
  Displays a visual representation of a calendar. This function supports multiple months
  and lets you highlight specific date ranges or days.

 .Parameter Start
  The first month to display.

 .Parameter End
  The last month to display.

 .Parameter FirstDayOfWeek
  The day of the month on which the week begins.

 .Parameter HighlightDay
  Specific days (numbered) to highlight. Used for date ranges like (25..31).
  Date ranges are specified by the Windows PowerShell range syntax. These dates are
  enclosed in square brackets.

 .Parameter HighlightDate
  Specific days (named) to highlight. These dates are surrounded by asterisks.

 .Example
   # Show a default display of this month.
   Show-Calendar

 .Example
   # Display a date range.
   Show-Calendar -Start "March, 2010" -End "May, 2010"

 .Example
   # Highlight a range of days.
   Show-Calendar -HighlightDay (1..10 + 22) -HighlightDate "December 25, 2008"
#>



function Get-NoteFrequency {
    Param (
        [Parameter(Mandatory=$true,Position=0)]
        [string]$LetterAndNumber,
        $A4 = 440 # https://en.wikipedia.org/wiki/Scientific_pitch_notation#Table_of_note_frequencies
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
    $Letter = $LetterAndNumber.Substring(0, ($LetterAndNumber.Length - 1))
    $Number = $LetterAndNumber.Substring(($LetterAndNumber.Length - 1), 1)
    $Number = $Number -as [int]
    $Letter = $Letter -replace '#', 'sharp'
    $Letter = $Letter.ToUpper()
    $Letter = $Letter -replace '\s', ''

    if ($Letter.Length -gt 1) {
        # replace 'b' with 'flat' if it's not the only letter in the string
        $Letter = $Letter -replace 'B', 'flat'
    }
    
    # Did the user enter a valid note letter?
    if (-Not $ValidNoteList.Contains($Letter)) {
        Write-Error "$Letter is not a valid note value."
        return
    } elseif ($Number -lt 0 -or $Number -gt 10 -or $null -eq $Number) {
        Write-Error "The octave number '$Number' is invalid. Use an integer 1 through 10."
        return
    }      
 
    $OctaveDifference = $Number - 4 # num of times and direction to loop
    $SemitonesDifference = 0

    if ($OctaveDifference -gt 0) {
        # count up
        foreach ($Note in $NoteList) {
            $SemitonesDifference++ 
            if ($Note -eq $Letter) {
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

    $Frequency = $A4 * [math]::pow(2, (($SemitonesDifference - 9) / 12))
    return $Frequency
}

function Invoke-Note {
    Param (
        [Parameter(ValueFromPipeline = $true)]
        [int]$Frequency, 
        [int]$Duration = 100
    )
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