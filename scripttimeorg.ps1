param (
   [string] $SiteName,
   [string] $ClientName,
   [string] $PublicIp,
   [string] $CustomField,
   [string] $Global
)

# $resultFromProcess = Get-Process TO-Trans1 | Select-Object ProcessName
 
 
$resultFromProcess = $null
#Check if the process exists and try to silently catch an error within the build in command get-process
if ( [bool](Get-Process  TO-Trans1 -EA SilentlyContinue) ) {
    $resultFromProcess = Get-Process  TO-Trans1 | Select-Object ProcessName
    $resultFromProcess =  $resultFromProcess.ProcessName
}

#If the process is started, enter the success code
if( -not ([string]::IsNullOrEmpty($resultFromProcess)) -And $resultFromProcess -eq "TO-Trans1"){
    Write-Output "Zeiterfassung laeuft"; 
    $exitcode = 0
    $host.SetShouldExit($exitcode)
    exit 0
}
#if the process is not started try to start it from ps with user context
else{
    Write-Output "Zeiterfassung laeuft nicht!";
    #Versuche die Zeiterfassung erneut zu starten! 
    try{
        # Pfad des zu startenden Programms 
        $Program1 = "C:\Program Files (x86)\Time-Organizer\TO-Trans1.exe"
        
        # Programm TO-Trans1.exe starten 
        $Process1 = Start-Process $Program1 -PassThru 
         
        # 30 Sekunden lang warten 
        #Start-Sleep -Seconds 30 
        
        #$resultFromProcess = $null
        #Check if the process exists and try to silently catch an error within the build in command get-process
        if ( [bool](Get-Process  TO-Trans1 -EA SilentlyContinue) ) {
            $resultFromProcess = Get-Process  TO-Trans1 | Select-Object ProcessName
            $resultFromProcess =  $resultFromProcess.ProcessName
        }

        #If the process is started, enter the success code
        if( -not ([string]::IsNullOrEmpty($resultFromProcess)) -And $resultFromProcess -eq "TO-Trans1"){
            Write-Output "Restart Zeiterfassung erfolgreich"; 
            $exitcode = 0
            $host.SetShouldExit($exitcode)
            exit 0
        }
        else{
            Write-Output "Restart Zeiterfassung war nicht erfolgreich"; 
            $exitcode = 1
            $host.SetShouldExit($exitcode)
        }
        
    }
    catch{
        Write-Output "Fehler beim Versuch den Process zu starten"; 
        $exitcode = 1
        $host.SetShouldExit($exitcode)
    }
    
    exit 1
}