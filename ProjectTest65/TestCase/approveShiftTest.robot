*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Keyword/approveShiftKey.robot
Resource    ../Variables/approveShiftVar.robot

*** Test Cases ***
Test Approve ShiftVar
    Launch Excel
    FOR    ${i}    IN RANGE    2    ${row}+1
       ${status}    Read Excel Cell    ${i}    1 
       IF    '${status}' == 'Y'
            Launch Browser and Navigate to Url
            Input Login Form    ${i}
            Button Click Login
            Click Link Shift

            Handle Alert And Validate    ${i}
            Browser Close  
       END
    END
    
    Save And Close Excel
    