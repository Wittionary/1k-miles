# One Thousand Miles by Vanessa Carlton
# https://www.musicnotes.com/sheetmusic/mtd.asp?ppn=MN0043758
# https://www.hooktheory.com/theorytab/view/vanessa-carlton/a-thousand-miles

Import-Module -Name .\make-music.ps1 -Force

# --------------------------------------- INTRO ---------------------------------------
$measure1 = @(@{note = "b6"; duration = "110" },
    @{note = "b5"; duration = "110" },
    @{note = "b6"; duration = "110" },
    @{note = "asharp6"; duration = "110" },
    @{note = "b5"; duration = "110" },
    @{note = "asharp6"; duration = "110" },
    @{note = "fsharp6"; duration = "600" },
    @{note = "dsharp6"; duration = "200" },
    @{note = "csharp6"; duration = "110" },
    @{note = "b5"; duration = "110" })

$measure2 = @(@{note = "b6"; duration = "110" },
    @{note = "b5"; duration = "110" },
    @{note = "b6"; duration = "110" },
    @{note = "asharp6"; duration = "110" },
    @{note = "b5"; duration = "110" },
    @{note = "asharp6"; duration = "110" },
    @{note = "fsharp6"; duration = "110" },
    @{note = "b5"; duration = "110" },
    @{note = "fsharp6"; duration = "110" },
    @{note = "b5"; duration = "110" },
    @{note = "fsharp6"; duration = "110" },
    @{note = "b5"; duration = "110" },
    @{note = "dsharp6"; duration = "110" },
    @{note = "e6"; duration = "110" },
    @{note = "dsharp6"; duration = "110" },
    @{note = "csharp6"; duration = "110" })

$measure3 = $measure1
$measure4 = @(@{note = "dsharp6"; duration = "110" },
    @{note = "csharp6"; duration = "110" },
    @{note = "b5"; duration = "110" },
    @{note = "dsharp6"; duration = "110" },
    @{note = "csharp6"; duration = "110" },
    @{note = "b5"; duration = "110" },
    @{note = "fsharp6"; duration = "400" },
    @{note = "csharp6"; duration = "400" })


Invoke-Measure -Measure $measure1
Invoke-Measure -Measure $measure2
Invoke-Measure -Measure $measure3
Invoke-Measure -Measure $measure4