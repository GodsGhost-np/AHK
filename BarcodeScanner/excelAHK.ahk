XL := ComObjCreate("Excel.Application")
XL.Workbooks.Open("C:\Users\uidn8279\Desktop\RAM1.xlsx") ;open an existing file
XL.Visible := True


Row := "1"
Columns := Object(1,"A",2,"B",3,"C",4,"D",5,"E",6,"F",7,"G",8,"H",9,"I",10,"J",11,"K",12,"L",13,"M",14,"N",15,"O",16,"P",17,"Q") ;array of column letters
For Key, Value In Columns
XL.Range(Value . Row).Value := value ;set values of each cell in a row
XL.Save()
XL.Quit()