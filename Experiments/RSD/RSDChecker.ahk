;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Revision :12/06/2023
;Creator : Naveen Prasad Shankar 
;Description: RSD header comparision tool -- confidential
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
file_path := A_ScriptDir . "\RSD.xlg"
output_file := A_ScriptDir . "\output.txt"
FindAndExtractAll(file_path, output_file)

MsgBox "Extraction complete. Output file updated."



FindAndExtractAll(file_path, output_file) {
    file := FileOpen(file_path, "r")
    output := FileOpen(output_file, "a")

    while (!file.AtEOF()) {
        line := file.ReadLine()

        if (InStr(line, "BAP_REM_FSG_02")) {
            next_line := file.ReadLine()
            next_line := RegExReplace(next_line, ".*<data>|</data>$")
			next_line := RegExReplace(next_line, "[ \t]+(?!\n)", "")
			next_line := StrReplace(next_line, "`n", "")
			  Header_data := ""
            StringLeft, Header_data, next_line, 8
			Actuallen := Floor((StrLen(next_line) - 1)/2)
            
			
			first_two_chars := SubStr(Header_data, 1, 2)
			;MsgBox "first_two_chars=" %first_two_chars%
			
			; Convert the Hexadecimal value to binary
			binary_value := RevHexToBin(first_two_chars)
			;output.WriteLine(binary_value)

			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MSGID
			right_four_chars := SubStr(binary_value, 5,4)
			;msgbox %right_four_chars%
			msg_ID := "MSG_ID = " . BinToDec(right_four_chars)
			
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;bfrist
			bFirst := "bFirst = " . SubStr(binary_value, 4, 1)
			
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;bLast
			bLast := "bLast = " . SubStr(binary_value, 3, 1)
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Pcount
			
			second_set := SubStr(Header_data, 3, 2)
			;output.WriteLine(second_set)
			pcount_bin :=  SubStr(RevHexToBin(second_set) , 5, 4) . SubStr(binary_value, 1, 2)
			Pcount := "Pcount = " . BinToDec(pcount_bin)
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Size
			third_set := SubStr(Header_data, 5, 2)
			;output.WriteLine(third_set)
			size_bin := SubStr(RevHexToBin(third_set) , 1, 8) . SubStr(RevHexToBin(second_set), 1, 4)
			size := BinToDec(size_bin)
			
			if (size = Actuallen) 
				size := "Size = " . size . " - Matching"
			else
				size := "Size = " . size . " - Not Matching"

			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Actual length
			Actuallen := "Actual Size = " . Actuallen
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RSD type
			fourth_set := SubStr(Header_data, 7, 2)
			if (fourth_set = "52") 
				fourth_set := "RSD type = " . fourth_set . " - RSD"
	
			else if (fourth_set = "53")
				fourth_set :=  "RSD type = " . fourth_set . " - Summary"
				
			output.WriteLine(next_line)
			output.WriteLine(Header_data)
			output.WriteLine(msg_ID)
			output.WriteLine(bFirst)
			output.WriteLine(bLast)
			output.WriteLine(Pcount)
			output.WriteLine(size)
			output.WriteLine(Actuallen)
			output.WriteLine(fourth_set)
        }
    }

    file.Close()
    output.Close()

    return
}

; Function to convert a hexadecimal string to 8-bit binary and reverse the LSB to MSB
RevHexToBin(hex) {
    dec := "0x" . hex
    bin := ""
    while (dec > 0) {
        bin := Mod(dec, 2) . bin
        dec := Floor(dec / 2)
    }
    
    ; Pad zeros to make it 8 bits long
    while (StrLen(bin) < 8) {
        bin := "0" . bin
    }
    return bin
}


; Function to convert a binary string to decimal
BinToDec(bin) {
    decimal := 0
    length := StrLen(bin)
    
    for i, bit in StrSplit(bin, "")
        decimal := decimal * 2 + bit
    
    return decimal
}

hex_to_ascii(hex_value) {
    ascii_value := ""

    loop, parse, hex_value, 2
    {
        hex_digits := A_LoopField
        decimal_value := "0x" . hex_digits
        ascii_char := Chr(decimal_value)
        ascii_value .= ascii_char
    }

    return ascii_value
}

