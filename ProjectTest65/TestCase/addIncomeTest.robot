*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/addIncomeVar.robot
Resource    ../Keyword/addIncomeKey.robot

*** Test Cases ***
Test Add Shift 
    Launch Excel
    FOR    ${i}    IN RANGE    2    ${row}+1
       ${status}    Read Excel Cell    ${i}    1 
       IF    '${status}' == 'Y'
            Launch Browser and Navigate to Url
            Login Input    ${i}
            Button Click Login
            Click Income Link
            Select Ordet name    ${i}
            Input Amount    ${i}            
            Handle Alert And Validate    ${i}
            Button Click
            Browser Close  
       END
    END
    Save And Close Excel 
