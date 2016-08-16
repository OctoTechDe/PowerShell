#---------------------
# Anlage der Mandanten
#---------------------

# Mandant Eins 
    $mandantNameEins = "ACME" 
    $mandantBenutzerEins = "admin@acme.de"
# Mandant Zwei
    $mandantNameZwei = "Contoso"
    $mandantBenutzerZwei = "admin@contoso.de"

#-------------------------------------------------
# Funktion zur Verbindung zu Office 365 | Exchange 
#-------------------------------------------------
function Verbindung
    { 
        Import-Module MSOnline
         
        $passwort = Read-Host -AsSecureString -Prompt "Passwort fuer Mandant $mandantName eingeben"
         
        $authentifizierung = New-Object System.Management.Automation.PSCredential($mandantBenutzer,$passwort) 

        Connect-MSolService -credential $authentifizierung
        $sitzung = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $authentifizierung -Authentication Basic -AllowRedirection 
        Import-PSSession $sitzung
        Write-Output "Verbindung zu Office 365 hergestellt" 
    }


#-----------------------------------
# Funktion zur Auswahl des Mandanten
#-----------------------------------
function Auswahl
    { 
        Write-Host "-----------------------------" -ForegroundColor Green
        Write-Host "Office 365 Mandant auswaehlen" -ForegroundColor Green
        Write-Host "-----------------------------" -ForegroundColor Green
        Write-Host "[1]" $mandantNameEins
        Write-Host "[2]" $mandantNameZwei
        Write-Host "[E] Exit"
        $abfrage = Read-Host 

        if (($abfrage) -eq "1") 
            { 
                $mandantName = $mandantNameEins
                $mandantBenutzer = $mandantBenutzerEins
                Verbindung
            }
             
        if (($abfrage) -eq "2") 
            { 
                $mandantName = $mandantNameZwei
                $mandantBenutzer = $mandantBenutzerZwei
                Verbindung
            } 
        }

#------------------------
# Starten der Auswahl
#------------------------
Auswahl
