

^r::
{
    ; Run the Python script
    ;RunWait "C:\Sean\Python\heidi-scribe\.venv\Scripts\python.exe C:\Sean\Python\heidi-scribe\clipboard-parser.py", ,  "Hide"
    RunWait "clipboard-parser.exe", ,  "Hide"

    ; Get the clipboard contents
    Clip := A_Clipboard

    ; Parse the clipboard contents
    Sections := Map("History", "", "Examination", "", "Impression", "", "Plan", "")

    CurrentSection := ""
    Loop Parse, Clip, "`n", "`r"
    {
        Line := A_LoopField
        if (InStr(Line, "History:") == 1) {
            CurrentSection := "History"
        } else if (InStr(Line, "Examination:") == 1) {
            CurrentSection := "Examination"
        } else if (InStr(Line, "Impression:") == 1) {
            CurrentSection := "Impression"
        } else if (InStr(Line, "Plan:") == 1) {
            CurrentSection := "Plan"
        } else if StrLen(Trim(Line)) > 0 {
            Sections[CurrentSection] .= Line "`n"
        }

    }

    ; Create the GUI
    myGui := Gui()
    
    ogcHistoryCheck := myGui.Add("Checkbox", "vHistoryCheck Checked", "History:")
    ogcHistoryEdit := myGui.Add("Edit", "w400 r5 vHistoryEdit", Sections["History"])
    ogcHistoryCheck.OnEvent("Click", CheckBoxChecked.Bind(ogcHistoryEdit))

    ogcExaminationCheck := myGui.Add("Checkbox", "vExaminationCheck Checked", "Examination:")
    ogcExaminationEdit := myGui.Add("Edit", "w400 r5 vExaminationEdit", Sections["Examination"])
    ogcExaminationCheck.OnEvent("Click", CheckBoxChecked.Bind(ogcExaminationEdit))

    ogcImpressionCheck := myGui.Add("Checkbox", "vImpressionCheck Checked", "Impression:")
    ogcImpressionEdit := myGui.Add("Edit", "w400 r5 vImpressionEdit", Sections["Impression"])
    ogcImpressionCheck.OnEvent("Click", CheckBoxChecked.Bind(ogcImpressionEdit))

    ogcPlanCheck := myGui.Add("Checkbox", "vPlanCheck Checked", "Plan:")
    ogcPlanEdit := myGui.Add("Edit", "w400 r5 vPlanEdit", Sections["Plan"])
    ogcPlanCheck.OnEvent("Click", CheckBoxChecked.Bind(ogcPlanEdit))

    ogcButtonCopySections := myGui.Add("Button", , "Copy Sections To SystmOne")
    ogcButtonCopySections.OnEvent("Click", CopySections.Bind(myGui, ogcHistoryCheck, ogcHistoryEdit, ogcExaminationCheck, ogcExaminationEdit, ogcImpressionCheck, ogcImpressionEdit, ogcPlanCheck, ogcPlanEdit))
    myGui.Show()
    return
}

CheckBoxChecked(GuiCtrlEdit, GuiCtrlCheck, Info2)
{
    
    ; V1toV2: StrReplace() is not case sensitive
    ; check for StringCaseSense in v1 source script
    ; and change the CaseSense param in StrReplace() if necessary
    if (GuiCtrlCheck.Value = 0)
        GuiCtrlEdit.Opt("+Disabled")
    else
        GuiCtrlEdit.Opt("-Disabled")
}

CopySections(myGui, ogcHistoryCheck, ogcHistoryEdit, ogcExaminationCheck, ogcExaminationEdit, ogcImpressionCheck, ogcImpressionEdit, ogcPlanCheck, ogcPlanEdit, Info, Info2)
{
    myGui.Hide()
    KeyWait "MButton", "D"

    clipboardContents := A_Clipboard

    if (ogcHistoryCheck.Value)
    {
        A_Clipboard := RTrim(ogcHistoryEdit.Value, "`r`n")
        Send "^v"
    }
    Send "{Tab}"
    Sleep 400

    if (ogcExaminationCheck.Value)
    {
        A_Clipboard := RTrim(ogcExaminationEdit.Value, "`r`n")
        Send "^v"
    }
    Send "{Tab}"
    Sleep 400

    if (ogcImpressionCheck.Value)
    {
        A_Clipboard := RTrim(ogcImpressionEdit.Value, "`r`n")
        Send "^v"
    }
    Send "{Tab}"
    Sleep 400

    if (ogcPlanCheck.Value)
    {
        A_Clipboard := RTrim(ogcPlanEdit.Value, "`r`n")
        Send "^v"
    }
    ;Sleep 400

    ;A_Clipboard := clipboardContents 
}

GuiClose()
{
	ExitApp()
}

; MButton::
; {
;     Send "^v"
; }