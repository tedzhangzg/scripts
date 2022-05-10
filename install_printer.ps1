# Script Printer Install
# Install Printer

# Include

# Include functions.ps1 from GitHub
Invoke-Expression $($(Invoke-WebRequest "https://raw.githubusercontent.com/tedzhangzg/shellscripts/main/functions.ps1" -UseBasicParsing).Content)


"Starting installation ..."


# Initial

# Constants
$printerport_raw_portnumber = "9100"
$printerport_lpr_queuename = "BINARY_P1"
$printerport_snmp_commname = "public"
$printerport_snmp_devind = "1"
$dir_drivers = "$HOME\Downloads\PrinterDrivers"
$path_printerslist = "$HOME\Downloads\printerslist.csv"

# Import
$importedcsv = Import-Csv -Path $path_printerslist
# List
for ( $i = 0 ; $i -lt $importedcsv.count ; $i++ ) {
    "$($i+1) : $($importedcsv[$i].ColAName)"
}
# Ask
Do {
    [int]$input_printer_number = Read-Host -Prompt "Enter number - Known printer (Leave blank if printer not on list): "
} while ( ($input_printer_number -lt 1) -or ($input_printer_number -gt ($importedcsv.count+1)) )
# Populate variables
if ($input_printer_number -ne ($importedcsv.count+1)) {
    $printerport_address = $importedcsv[$input_printer_number-1].PrinterAddress
    $printer_drivername_inf = $importedcsv[$input_printer_number-1].PrinterDrivernameinf
    $org_name = $importedcsv[$input_printer_number-1].PrinterOrgname
    $case_printerport = $importedcsv[$input_printer_number-1].PrinterCase
} else {
    # Ask manual
    $printerport_address = Read-Host -Prompt "Enter IP/Hostname (no space) - Printer IP Address or Hostname: "
    $printer_drivername_inf = Read-Host -Prompt "Enter Phrase - Printer Name (EXACTLY as in inf): "
    $org_name = Read-Host -Prompt "Enter word (no space) - Org prefix/suffix for printer name (visible): "
}



### OLD CODE ###
# List known specific printers
$known_printer = @(
    "GLCCPunggol_Canon5535",
    "GLCCPunggol_Epson355",
    "GLCCPunggol_Canon3010",
    "DM360_HP8020",
    "DM360_Brother2270",
    "ZHANGJIA_Brother2740"
)
# Show list
for ( $i = 0 ; $i -lt $known_printer.count ; $i++ ) {
    "$($i+1) : $($known_printer[$i])"
}
# Choose
if ($null -eq $input_printer_number) {
    [int]$input_printer_number = Read-Host -Prompt "Enter number - Known printer (Leave blank if printer not on list): "
}
# Populate variables for known printer
switch ($input_printer_number)
{
    1 {
        # Option 1
        $org_name = "GLCC"
        $printerport_address = "printer-canon5535.stf.gospellight.sg"
        $printer_drivername_inf = "Canon iR-ADV C5535/5540 UFR II"
        $case_printerport = 1
        break
    }
    2 {
        # Option 2
        $org_name = "GLCC"
        $printerport_address = "printer-epson355.stf.gospellight.sg"
        $printer_drivername_inf = "EPSON L355 Series"
        $case_printerport = 2
        break
    }
    3 {
        # Option 3
        $org_name = "GLCC"
        $printerport_address = "printer-canon3010.stf.gospellight.sg"
        $printer_drivername_inf = "Canon G3010 series"
        $case_printerport = 2
        break
    }
    4 {
        # Option 4
        $org_name = "DM360"
        $printerport_address = "172.22.0.20"
        $printer_drivername_inf = "HP OfficeJet Pro 8020 series PCL-3"
        $case_printerport = 2
        break
    }
    5 {
        # Option 5
        $org_name = "DM360"
        $printerport_address = "172.22.128.20"
        $printer_drivername_inf = "Brother HL-2270DW series"
        $case_printerport = 4
        break
    }
    6 {
        # Option 6
        $org_name = "ZHANGJIA"
        $printerport_address = "192.168.1.250"
        $printer_drivername_inf = "Brother MFC-L2740DW series"
        $case_printerport = 4
        break
    }
    default {
        # Option default
        "Manually key in ..."
        break
    }
}
### OLD CODE ###



# Construct from Answers
$printerport_name = "$printerport_address" + "_" + $org_name
$printer_displayname = $org_name + " " + $printer_drivername_inf

# Case of Printer Port
if ($null -eq $case_printerport) {
    
    # Documentation
    "List of Cases of Printer Ports"
    "Case 1: Raw, no SNMP"
    "Case 2: Raw, with SNMP"
    "Case 3: LPR no ByteCounting, no SNMP"
    "Case 4: LPR no ByteCounting, with SNMP"
    "Case 5: LPR with ByteCounting, no SNMP"
    "Case 6: LPR with ByteCounting, with SNMP"

    " "

    Do {
        [int]$case_printerport = Read-Host -Prompt "Enter number - Case of printer port: "
    } while ( ($case_printerport -lt 1) -or ($case_printerport -gt 6) )
}


" "
" "


# Install

# Add inf files into DriverStore
# Ask if added
Do {
    [char]$drivers_added_into_driverstore = Read-Host -Prompt "Enter letter - Are drivers added into driver store already? y , n "
} while ( ($drivers_added_into_driverstore -ne "y") -and ($drivers_added_into_driverstore -ne "n") )
# Add if no
if ($drivers_added_into_driverstore -eq "n") {
    if (Test-Path -Path $dir_drivers) {
        "Adding inf files into DriverStore ..."
        Get-ChildItem -Path $dir_drivers -Recurse -Filter "*.inf" | % { pnputil.exe /add-driver $_.FullName }
        "... Done"
    } else {
        "No driver folder found"
        "Place drivers in HOME\Downloads\PrinterDrivers"
        exit
    }
}
else {
    "Inf files already added into driver store, proceeding to next step ... "
}

" "

# Install driver from DriverStore
"Installing driver from DriverStore ..."
Add-PrinterDriver -Name $printer_drivername_inf
"... Done"

" "

# Add-PrinterPort to add printer port
"Adding printer port ..."
switch ($case_printerport)
{
    1 {
        # Option 1
        Add-PrinterPort -Name $printerport_name -PrinterHostAddress $printerport_address -PortNumber $printerport_raw_portnumber
        break
    }
    2 {
        # Option 2
        Add-PrinterPort -Name $printerport_name -PrinterHostAddress $printerport_address -PortNumber $printerport_raw_portnumber -SNMP $printerport_snmp_devind -SNMPCommunity $printerport_snmp_commname
        break
    }
    3 {
        # Option 3
        Add-PrinterPort -Name $printerport_name -LprHostAddress $printerport_address -LprQueueName $printerport_lpr_queuename
        break
    }
    4 {
        # Option 4
        Add-PrinterPort -Name $printerport_name -LprHostAddress $printerport_address -LprQueueName $printerport_lpr_queuename -SNMP $printerport_snmp_devind -SNMPCommunity $printerport_snmp_commname
        break
    }
    5 {
        # Option 5
        Add-PrinterPort -Name $printerport_name -LprHostAddress $printerport_address -LprQueueName $printerport_lpr_queuename -LprByteCounting
        break
    }
    6 {
        # Option 6
        Add-PrinterPort -Name $printerport_name -LprHostAddress $printerport_address -LprQueueName $printerport_lpr_queuename -LprByteCounting -SNMP $printerport_snmp_devind -SNMPCommunity $printerport_snmp_commname
        break
    }
    default {
        # Option default
        "Error"
        break
    }
}
"... Done"

" "

# Add-Printer into Printers list
"Adding printer ..."
Add-Printer -Name $printer_displayname -DriverName $printer_drivername_inf -PortName $printerport_name
"... Done"

" "

# Delete temp drivers dir
# "Deleting temp drivers dir ..."
Invoke-Item -Path (Split-Path -Path $dir_drivers -Parent)
if (Test-Path -Path $dir_drivers) {
    Remove-Item $dir_drivers -Force -Recurse
}
# "... Done"

" "

# Show Devices and Printers
Show-ControlPanelItem -CanonicalName "Microsoft.DevicesAndPrinters"
"... Done"


" "
" "


# Final

# Clear
# Clear-RecycleBin -Force
Clear-PSHistory


" "
" "


"All done."


