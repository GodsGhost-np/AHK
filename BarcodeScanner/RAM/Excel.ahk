global clmn:=3
try XL := ComObjActive(Excel.Application)
		catch 
		{
			XL := ComObjCreate("Excel.Application")
			XL.visible := 0
		}
	try
	{
		fn := A_ScriptDir "\RAM.xlsx"
		oWorkbook := XL.Workbooks.Open(fn)
		
		
		loop
		{
		r=F%clmn%
		findBlank=A%clmn%
			if(oWorkbook.Sheets(1).Range(r).Text="")
			{
			
				oWorkbook.Sheets(1).Range(r).Interior.ColorIndex := 3
				oWorkbook.Sheets(1).Range(r).Offset(0,1).Interior.ColorIndex := 3
				oWorkbook.Sheets(1).Range(r).Offset(0,-3).Interior.ColorIndex := 3
				clmn++
				
				
			}
			else
			clmn++
			
			if(oWorkbook.Sheets(1).Range(findBlank).Text="")
			{
			break
			return
			}
		}
		oWorkbook.Save()
					XL.Quit()
					sleep 500
	}catch
	{
		oWorkbook.Save()
		XL.Quit()
	}
