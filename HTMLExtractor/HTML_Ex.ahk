; Define the path to the input and output HTML files
folderPath := A_ScriptDir
outputFilePath := A_ScriptDir . "\extracted\FinalCombinedReport.html"

; Read the HTML content from the input file
FileRead, htmlContent, %inputFilePath%
FileRead, outputContent, %outputFilePath%
 FileDelete, %outputFilePath% ; Optionally delete the output file if it already exists
 startIndex3 := 0
Loop, Files, % folderPath "\*.html", F
{
		; Read the current HTML file content
		FileRead, htmlContent, %A_LoopFileFullPath%
		if ErrorLevel
		{
			MsgBox, Could not read the file: %A_LoopFileFullPath%
			continue
		}

		startIndex2 := InStr(htmlContent, "<style type=""text/css"">")


		if (startIndex2 > 0 && startIndex3==0)
		{
			startIndex2 := InStr(htmlContent, "<style type=""text/css"">", false, startIndex2)

			endIndex2 := InStr(htmlContent, "</style>", false, startIndex2)		
			
			extractedContent2 := SubStr(htmlContent, startIndex2, endIndex2 - startIndex2 + 10) ; +5 to include the length of "</div>"

			FileAppend, %extractedContent2%, %outputFilePath%
FileAppend, %extractedContent2%, %outputFilePath%
			//MsgBox, % "Extracted content saved to: " . outputFilePath
			startIndex3 := 1
		}
		
		; Find the starting point of the "title" section
		titleIndex := InStr(htmlContent, "<title>")

		if (titleIndex > 0)
		{
			titleIndex := InStr(htmlContent, "<title>", false, titleIndex)

			titleendIndex := InStr(htmlContent, "</title>", false, titleIndex)

			Titleextract := SubStr(htmlContent, titleIndex+7, titleendIndex - (titleIndex+7)) 
			Extract := "<lass=""Heading"">" . Titleextract . "</big>"
			
			
			
			extractedtitle := SubStr(htmlContent, titleIndex, titleendIndex - titleIndex + 10) ;

			FileAppend, %Extract%, %outputFilePath%
			
			
		}
		

		; Find the starting point of the "Statistics" section
		startIndex := InStr(htmlContent, "<div class=""Heading4"">Statistics</div>")


		; If the "Statistics" section is found, try to find the end of the following "Indentation" div
		if (startIndex > 0)
		{
			; Adjust the starting index to the beginning of the "Indentation" div to ensure we include it in the extraction
			startIndex := InStr(htmlContent, "<div class=""Indentation"">", false, startIndex)
			
			; Find the end of the "Indentation" div. This is a naive approach assuming there's no nesting.
			endIndex := InStr(htmlContent, "</div>", false, startIndex)

			extractedContent := SubStr(htmlContent, startIndex, endIndex - startIndex + 6) ; +5 to include the length of "</div>"

   
			FileAppend, %extractedContent%, %outputFilePath%
		
			
		}
	
}

