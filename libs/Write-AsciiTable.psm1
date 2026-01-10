<#

.SYNOPSIS
    Writes an ASCII table to the console.

.DESCRIPTION
 
    Write-AsciiTable is a PowerShell function that writes an ASCII table to the console.

.PARAMETER InputObject

    The input object to write to the table.

.PARAMETER Property

    The properties of the input object to include in the table.

.PARAMETER Format

    A hashtable that specifies the format of the table. The keys are the properties of the input object and the values are the format strings.

.PARAMETER NoHeader

    Specifies that the table header should not be displayed.

.PARAMETER BorderStyle

    Specifies the style of the table border.

.PARAMETER MaxWidth

    Specifies the maximum width of the table.

.PARAMETER TrimContent

    Specifies that the content of the table should be trimmed to the maximum width.

.PARAMETER Alignment
    
    Specifies the alignment of the table content.

.PARAMETER ColorPallet
    
    Specifies the color pallet of the table.

The default color pallet is:
    header = 'white'
    row = 'white'
    border = 'white'
    connectors = 'gray'
    HozLine = 'gray'
    VerLine = 'gray'
    juctions = 'gray'

.EXAMPLE
    PS C:\> Write-AsciiTable -InputObject $data -Property Name, Age, City

    This example writes an ASCII table to the console using the default settings.

.EXAMPLE 
    PS C:\> Write-AsciiTable -InputObject $data -Property Name, Age, City -BorderStyle Single

    This example writes an ASCII table to the console using the Single border style.

.EXAMPLE 
    PS C:\> Write-AsciiTable -InputObject $data -Property Name, Age, City -BorderStyle Single -MaxWidth 50

    This example writes an ASCII table to the console using the Single border style and a maximum width of 50 characters.

.EXAMPLE

    PS C:\> Write-AsciiTable -InputObject $data -Property Name, Age, City -BorderStyle Single -MaxWidth 50 -TrimContent

    This example writes an ASCII table to the console using the Single border style, a maximum width of 50 characters, and trimmed content.

.EXAMPLE

    PS C:\> Write-AsciiTable -InputObject $data -Property Name, Age, City -BorderStyle Single -MaxWidth 50 -TrimContent -Alignment @{Name = "left"; Age = "right"; City = "center"}

    This example writes an ASCII table to the console using the Single border style, a maximum width of 50 characters, trimmed content, and custom alignment.

.EXAMPLE

    PS C:\> Write-AsciiTable -InputObject $data -Property Name, Age, City -BorderStyle Single -MaxWidth 50 -TrimContent -Alignment @{Name = "left"; Age = "right"; City = "center"} -ColorPallet @{ header = 'red'; row = 'blue' }

    This example writes an ASCII table to the console using the Single border style, a maximum width of 50 characters, trimmed content, custom alignment, and custom color pallet.
#>

using module .\New-ColorConsole.psm1 

function Write-AsciiTable {
    [CmdletBinding()]
    [OutputType([void])]
    [Alias('watw')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Object[]]$InputObject,
        
        [Parameter(Mandatory = $false)]
        [string[]]$Property,
        
        [Parameter(Mandatory = $false)]
        [hashtable]$Format = @{},
        
        [Parameter(Mandatory = $false)]
        [switch]$NoHeader,

        [Parameter(Mandatory = $false)]
        [string]$Title,

        [Parameter(Mandatory = $false)]
        [string]$SummaryTitle,
        
        [Parameter(Mandatory = $false)]
        [ValidateSet(
            "Default", 
            "Single", 
            "Double", 
            "Rounded", 
            "Minimal", 
            "Bold", 
            "Dotted", 
            "Dashed", 
            "ASCII", 
            "Stars", 
            "Block", 
            "LightBlock", 
            "MediumBlock", 
            "DarkBlock", 
            "HeavyBlock")]
        [string]$BorderStyle = "Default",
        
        [Parameter(Mandatory = $false)]
        [int]$MaxWidth = 0,
        
        [Parameter(Mandatory = $false)]
        [switch]$TrimContent,
        
        [Parameter(Mandatory = $false)]
        [hashtable]$Alignment = @{},

        [Parameter(Mandatory = $false)]
        [hashtable]$colorPallet
    )

    begin {
        $items = @()
        
        if (!$colorPallet) {
            [hashtable]$colors = @{}
            # if param is not passed
            $colors.header              = 'white'
            $colors.row                 = 'white'
            $colors.connectors          = 'gray'
            $colors.hozline             = 'white'
            $colors.verline             = 'white'
            $colors.juctions            = 'gray'
            $colors.title               = 'gray'
            $colors.title_indicator     = 'cyan'
            $colors.summary_title       = 'yellow'
        }else{
            # if param is passed but not all colors are defined
            [hashtable]$colors = $colorPallet
            if ($colors.ContainsKey('header') -eq $false) { $colors.header = 'white' }
            if ($colors.ContainsKey('row') -eq $false) { $colors.row = 'white' }
            if ($colors.ContainsKey('connectors') -eq $false) { $colors.connectors = 'gray' }
            if ($colors.ContainsKey('hozline') -eq $false) { $colors.hozline = 'white' }
            if ($colors.ContainsKey('verline') -eq $false) { $colors.VerLine = 'white' }
            if ($colors.ContainsKey('juctions') -eq $false) { $colors.juctions = 'gray' }
            if ($colors.ContainsKey('title') -eq $false) { $colors.title = 'gray' }
            if ($colors.ContainsKey('title_indicator') -eq $false) { $colors.title_indicator = 'cyan' }
            if ($colors.ContainsKey('summary_title') -eq $false) { $colors.summary_title = 'yellow' } 
        }

        # Border style definitions
        # Border style definitions with console coloring support
        $borderStyles = @{
            Default = @{
                TopLeft        = "$(csole -s "+" -c $colors.connectors)";
                TopRight       = "$(csole -s "+" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "+" -c $colors.connectors)";  
                BottomRight    = "$(csole -s "+" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "-" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "|" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "+" -c $colors.juctions)";
                BottomJunction = "$(csole -s "+" -c $colors.juctions)";
                LeftJunction   = "$(csole -s "+" -c $colors.juctions)";
                RightJunction  = "$(csole -s "+" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "+" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⇉" -c $colors.title_indicator)";
            }
            Single = @{
                TopLeft        = "$(csole -s "┌" -c $colors.connectors)";
                TopRight       = "$(csole -s "┐" -c $colors.connectors)";  
                BottomLeft     = "$(csole -s "└" -c $colors.connectors)";
                BottomRight    = "$(csole -s "┘" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "─" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "│" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "┬" -c $colors.juctions)";
                BottomJunction = "$(csole -s "┴" -c $colors.juctions)";  
                LeftJunction   = "$(csole -s "├" -c $colors.juctions)";
                RightJunction  = "$(csole -s "┤" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "┼" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            Double = @{
                TopLeft        = "$(csole -s "╔" -c $colors.connectors)";
                TopRight       = "$(csole -s "╗" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "╚" -c $colors.connectors)";
                BottomRight    = "$(csole -s "╝" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "═" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "║" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "╦" -c $colors.juctions)";
                BottomJunction = "$(csole -s "╩" -c $colors.juctions)";
                LeftJunction   = "$(csole -s "╠" -c $colors.juctions)";
                RightJunction  = "$(csole -s "╣" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "╬" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            Rounded = @{
                TopLeft        = "$(csole -s "╭" -c $colors.connectors)";
                TopRight       = "$(csole -s "╮" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "╰" -c $colors.connectors)";
                BottomRight    = "$(csole -s "╯" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "─" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "│" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "┬" -c $colors.juctions)";
                BottomJunction = "$(csole -s "┴" -c $colors.juctions)";
                LeftJunction   = "$(csole -s "├" -c $colors.juctions)";
                RightJunction  = "$(csole -s "┤" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "┼" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            Minimal = @{
                TopLeft        = "$(csole -s " " -c $colors.connectors)";
                TopRight       = "$(csole -s " " -c $colors.connectors)";
                BottomLeft     = "$(csole -s " " -c $colors.connectors)";
                BottomRight    = "$(csole -s " " -c $colors.connectors)";
                HorizontalLine = "$(csole -s " " -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "│" -c $colors.VerLine)";
                TopJunction    = "$(csole -s " " -c $colors.juctions)";
                BottomJunction = "$(csole -s " " -c $colors.juctions)";
                LeftJunction   = "$(csole -s "│" -c $colors.juctions)";
                RightJunction  = "$(csole -s "│" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "│" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            Bold = @{
                TopLeft        = "$(csole -s "┏" -c $colors.connectors)";
                TopRight       = "$(csole -s "┓" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "┗" -c $colors.connectors)";
                BottomRight    = "$(csole -s "┛" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "━" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "┃" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "┳" -c $colors.juctions)";
                BottomJunction = "$(csole -s "┻" -c $colors.juctions)";
                LeftJunction   = "$(csole -s "┣" -c $colors.juctions)";
                RightJunction  = "$(csole -s "┫" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "╋" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            Dotted = @{
                TopLeft        = "$(csole -s "┌" -c $colors.connectors)";
                TopRight       = "$(csole -s "┐" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "└" -c $colors.connectors)";
                BottomRight    = "$(csole -s "┘" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "┈" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "┊" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "┬" -c $colors.juctions)";
                BottomJunction = "$(csole -s "┴" -c $colors.juctions)";
                LeftJunction   = "$(csole -s "├" -c $colors.juctions)";
                RightJunction  = "$(csole -s "┤" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "┼" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            Dashed = @{
                TopLeft        = "$(csole -s "┌" -c $colors.connectors)";
                TopRight       = "$(csole -s "┐" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "└" -c $colors.connectors)";
                BottomRight    = "$(csole -s "┘" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "╌" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "╎" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "┬" -c $colors.juctions)";
                BottomJunction = "$(csole -s "┴" -c $colors.juctions)";
                LeftJunction   = "$(csole -s "├" -c $colors.juctions)";
                RightJunction  = "$(csole -s "┤" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "┼" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            ASCII = @{
                TopLeft        = "$(csole -s "/" -c $colors.connectors)";
                TopRight       = "$(csole -s "\\" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "\\" -c $colors.connectors)";
                BottomRight    = "$(csole -s "/" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "-" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "|" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "v" -c $colors.juctions)";
                BottomJunction = "$(csole -s "^" -c $colors.juctions)";
                LeftJunction   = "$(csole -s ">" -c $colors.juctions)";
                RightJunction  = "$(csole -s "<" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "+" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            Stars = @{
                TopLeft        = "$(csole -s "*" -c $colors.connectors)";
                TopRight       = "$(csole -s "*" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "*" -c $colors.connectors)";
                BottomRight    = "$(csole -s "*" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "*" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "*" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "*" -c $colors.juctions)";
                BottomJunction = "$(csole -s "*" -c $colors.juctions)";
                LeftJunction   = "$(csole -s "*" -c $colors.juctions)";
                RightJunction  = "$(csole -s "*" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "*" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            Block = @{
                TopLeft        = "$(csole -s "█" -c $colors.connectors)";
                TopRight       = "$(csole -s "█" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "█" -c $colors.connectors)";
                BottomRight    = "$(csole -s "█" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "█" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "█" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "█" -c $colors.juctions)";
                BottomJunction = "$(csole -s "█" -c $colors.juctions)";
                LeftJunction   = "$(csole -s "█" -c $colors.juctions)";
                RightJunction  = "$(csole -s "█" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "█" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            LightBlock = @{
                TopLeft        = "$(csole -s "▓" -c $colors.connectors)";
                TopRight       = "$(csole -s "▓" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "▓" -c $colors.connectors)";
                BottomRight    = "$(csole -s "▓" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "▓" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "▓" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "▓" -c $colors.juctions)";
                BottomJunction = "$(csole -s "▓" -c $colors.juctions)";
                LeftJunction   = "$(csole -s "▓" -c $colors.juctions)";
                RightJunction  = "$(csole -s "▓" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "▓" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            MediumBlock = @{
                TopLeft        = "$(csole -s "▒" -c $colors.connectors)";
                TopRight       = "$(csole -s "▒" -c $colors.connectors)";
                BottomLeft     = "$(csole -s "▒" -c $colors.connectors)";
                BottomRight    = "$(csole -s "▒" -c $colors.connectors)";
                HorizontalLine = "$(csole -s "▒" -c $colors.HozLine)";
                VerticalLine   = "$(csole -s "▒" -c $colors.VerLine)";
                TopJunction    = "$(csole -s "▒" -c $colors.juctions)";
                BottomJunction = "$(csole -s "▒" -c $colors.juctions)";
                LeftJunction   = "$(csole -s "▒" -c $colors.juctions)";
                RightJunction  = "$(csole -s "▒" -c $colors.juctions)";
                CrossJunction  = "$(csole -s "▒" -c $colors.juctions)";
                titleIndicator = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            DarkBlock = @{
                TopLeft         = "$(csole -s "░" -c $colors.connectors)";
                TopRight        = "$(csole -s "░" -c $colors.connectors)";
                BottomLeft      = "$(csole -s "░" -c $colors.connectors)";
                BottomRight     = "$(csole -s "░" -c $colors.connectors)";
                HorizontalLine  = "$(csole -s "░" -c $colors.HozLine)";
                VerticalLine    = "$(csole -s "░" -c $colors.VerLine)";
                TopJunction     = "$(csole -s "░" -c $colors.juctions)";
                BottomJunction  = "$(csole -s "░" -c $colors.juctions)";
                LeftJunction    = "$(csole -s "░" -c $colors.juctions)";
                RightJunction   = "$(csole -s "░" -c $colors.juctions)";
                CrossJunction   = "$(csole -s "░" -c $colors.juctions)";
                titleIndicator  = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
            HeavyBlock = @{
                TopLeft         = "$(csole -s "█" -c $colors.connectors)";
                TopRight        = "$(csole -s "█" -c $colors.connectors)";
                BottomLeft      = "$(csole -s "█" -c $colors.connectors)";
                BottomRight     = "$(csole -s "█" -c $colors.connectors)";
                HorizontalLine  = "$(csole -s "█" -c $colors.HozLine)";
                VerticalLine    = "$(csole -s "█" -c $colors.VerLine)";
                TopJunction     = "$(csole -s "█" -c $colors.juctions)";
                BottomJunction  = "$(csole -s "█" -c $colors.juctions)";
                LeftJunction    = "$(csole -s "█" -c $colors.juctions)";
                RightJunction   = "$(csole -s "█" -c $colors.juctions)";
                CrossJunction   = "$(csole -s "█" -c $colors.juctions)";
                titleIndicator  = "$(csole -s "⬡" -c $colors.title_indicator)";
            }
        }
        
        $borders = $borderStyles[$BorderStyle]
    }
    
    process {
        $items += $InputObject
    }
    
    end {
        if ($items.Count -eq 0) {
            Write-Warning "No items to display"
            return
        }
        
        if (-not $Property) {
            $Property = $items[0].PSObject.Properties.Name
        }
        
        # Calculate column widths
        $columnWidths = @{}
        foreach ($prop in $Property) {
            $headerWidth = ($prop).Length
            $maxContentWidth = ($items | ForEach-Object {
                    
                    $value = "$($_.$prop)"
                    
                    if ($Format.ContainsKey($prop)) {
                        $value = Invoke-Command -ScriptBlock $Format[$prop] -ArgumentList $_.$prop
                    }
                    "$($value)".Length 
                } | Measure-Object -Maximum).Maximum
            
            $width = [Math]::Max($headerWidth, $maxContentWidth)
            
            # Apply MaxWidth if specified
            if ($MaxWidth -gt 0 -and $width -gt $MaxWidth) {
                $width = $MaxWidth
            }
            
            $columnWidths[$prop] = $width
        }
        
        # Helper function to create horizontal line
        function Get-HorizontalLine {
            param (
                [string]$Left,
                [string]$Middle,
                [string]$Right,
                [string]$Line,
                [string]$Junction
            )
            
            $result = $Left
            $first = $true
            
            foreach ($prop in $Property) {
                if (-not $first) {
                    $result += $Junction
                }
                $result += $Line * ($columnWidths[$prop] + 2)
                $first = $false
            }
            
            $result += $Right
            return $result
        }

        # Top border
        $topLine = Get-HorizontalLine -Left $borders.TopLeft -Middle $borders.HorizontalLine -Right $borders.TopRight -Line $borders.HorizontalLine -Junction $borders.TopJunction
        
        # Middle border
        $middleLine = Get-HorizontalLine -Left $borders.LeftJunction -Middle $borders.HorizontalLine -Right $borders.RightJunction -Line $borders.HorizontalLine -Junction $borders.CrossJunction
        
        # Bottom border
        $bottomLine = Get-HorizontalLine -Left $borders.BottomLeft -Middle $borders.HorizontalLine -Right $borders.BottomRight -Line $borders.HorizontalLine -Junction $borders.BottomJunction
        
        # title Border
        $titleLine = Get-HorizontalLine -Left $borders.TopLeft -Middle $borders.HorizontalLine -Right $borders.TopRight -Line $borders.HorizontalLine -Junction $borders.TopJunction

        # input object items arrays
        $ObjectCount = $items.Count
        if($title){
            # title string
            $titleString = "  $(csole -s "⬡" -c $($colors.title_indicator)) $(csole -s "$($title.ToUpper())" -c $($colors.title))"
            
            if($SummaryTitle){
                $titleString += "  $(csole -s "⬡" -c $($colors.title_indicator)) $(csole -s "$($SummaryTitle.ToUpper())" -c $($colors.summary_title)) $(csole -s "$ObjectCount" -color $($colors.title))"
            }
            # Output table
            $titleLine
            $titleString
        }
        $topLine
        
        # Header row
        if (-not $NoHeader) {
            $headerRow = $borders.VerticalLine
            foreach ($prop in $Property) {
                $headerText = $prop.ToString()
                if ($headerText.Length -gt $columnWidths[$prop] -and $TrimContent) {
                    $headerText = $headerText.Substring(0, $columnWidths[$prop] - 3) + "..."
                }
                
                $alignmentValue = "left"  # Default alignment
                if ($Alignment.ContainsKey($prop)) {
                    $alignmentValue = $Alignment[$prop]
                }
                
                switch ($alignmentValue.ToLower()) {
                    "right" { $headerText = $headerText.PadLeft($columnWidths[$prop]) }
                    "center" { 
                        $spaces = $columnWidths[$prop] - $headerText.Length
                        $leftPad = [math]::Floor($spaces / 2)
                        $rightPad = $spaces - $leftPad
                        $headerText = (" " * $leftPad) + $headerText + (" " * $rightPad)
                    }
                    default { $headerText = $headerText.PadRight($columnWidths[$prop]) }
                }
                
                $headerRow += " " + "$(csole -s $headerText -c $colors.header -format italic)" + " " + $borders.VerticalLine
            }
            $headerRow
            $middleLine
        }
        
        # Data rows
        for ($i = 0; $i -lt $items.Count; $i++) {
            $item = $items[$i]
            $row = $borders.VerticalLine
            
            foreach ($prop in $Property) {
                $value = $item.$prop
                
                $displayValue = "$value"
                
                # Trim if necessary
                if ($displayValue.Length -gt $columnWidths[$prop] -and $TrimContent) {
                    $displayValue = $displayValue.Substring(0, $columnWidths[$prop] - 3) + "..."
                }
                elseif ($displayValue.Length -gt $columnWidths[$prop]) {
                    $displayValue = $displayValue.Substring(0, $columnWidths[$prop])
                }
                
                # Apply alignment
                $alignmentValue = "left"  # Default alignment
                if ($Alignment.ContainsKey($prop)) {
                    $alignmentValue = $Alignment[$prop]
                }
                
                switch ($alignmentValue.ToLower()) {
                    "right" { $displayValue = $displayValue.PadLeft($columnWidths[$prop]) }
                    "center" { 
                        $spaces = $columnWidths[$prop] - $displayValue.Length
                        $leftPad = [math]::Floor($spaces / 2)
                        $rightPad = $spaces - $leftPad
                        $displayValue = (" " * $leftPad) + $displayValue + (" " * $rightPad)
                    }
                    default { $displayValue = $displayValue.PadRight($columnWidths[$prop]) }
                }
                
                # Apply format if specified
                if ($Format.ContainsKey($prop)) {
                    $displayValue = Invoke-Command -ScriptBlock $Format[$prop] -ArgumentList $displayValue
                }

                $row += " " + "$(csole -s $displayValue -c $colors.row)" + " " + $borders.VerticalLine
            }
            
            $row
        }
        
        # Close table
        $bottomLine
    }
}

$cmdlet_config = @{
    function = 'Write-AsciiTable'
    Alias = @('watw')
}

Export-ModuleMember @cmdlet_config