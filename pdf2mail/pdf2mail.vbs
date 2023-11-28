FOLDER_PDF = "C:\temp\source"  
FOLDER_MOVE = "C:\Temp\target"  
PATH_BLAT = "D:\Download\Blat\blat.exe"  

Set fso = WScript.CreateObject("Scripting.Filesystemobject")  
strPDFs = ""  
For Each file In fso.GetFolder(FOLDER_PDF).Files
	If LCase(fso.GetExtensionName(file.Path)) = "pdf" Then  
		If strPDFs <> "" Then  
			strPDFs = strPDFs & ",""" & file.Path & """"   
		Else
			strPDFs = """" & file.Path & """"   
		End If
	End If
Next
If strPDFs <> "" Then  
	'sendNewMailViaBlat "sender@mail.de","empfänger@mail.de","Neue PDFs eingetroffen","Im Anhang Ihre PDFs",strPDFs,"smtp.mailserver.de","SMTP-USERNAME","SMTP-PASSWORD"
	'---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	'sendNewMailViaBlat "rechnungen@mieterverein-muenchen.de","rechnungen@mieterverein-muenchen.de","Neue Rechnungen eingetroffen","Im Anhang Ihre PDFs",strPDFs,"webmail.mieterverein-muenchen.de","rechnungen","MvM-2017!"  
	sendNewMailViaBlat "rechnungen@mieterverein-muenchen.de","bloebaum@mieterverein-muenchen.de","Neue Rechnungen eingetroffen","Im Anhang Ihre PDFs",strPDFs,"webmail.mieterverein-muenchen.de","huber","CP180877!2"  
	
	'PDFs in einen anderen Ordner verschieben  
	' For Each pdf In Split(strPDFs,",",-1,1)  
		' pdf = Replace(pdf,"""","",1,-1,1)  
		' fso.MoveFile pdf , FOLDER_MOVE & "\"  
	' Next
	'Alternativ Wenn die Dateien gelöscht werden sollen:  
	For Each pdf In Split(strPDFs,",",-1,1)  
		pdf = Replace(pdf,"""","",1,-1,1)  
		fso.DeleteFile pdf,True  
	Next  
End If

Function sendNewMailViaBlat(strFrom,strTo,strSubject,strBody,strAttachments,strSMTPServer,strSMTP_USER,strSMTP_PASS)
    Set objShell = CreateObject("WScript.Shell")  
    objShell.Run """" & PATH_BLAT & """" & " -subject """ & strSubject & """ -body """ & strBody & """ -to " & strTo & " -f " & strFrom & " -server " & strSMTPServer & " -u """ & strSMTP_USER & """ -pw """ & strSMTP_PASS & """ -attach " & strAttachments ,0,True  
    set objShell = Nothing
End Function