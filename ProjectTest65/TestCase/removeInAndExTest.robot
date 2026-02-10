*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Keyword/removeInAndExKey.robot
Resource    ../Variables/removeInAndExVar.robot

*** Test Cases ***
Test Remove Income And Expense
    Launch Excel
    FOR    ${i}    IN RANGE    2    ${row}+1
       ${status}    Read Excel Cell    ${i}    1 
       IF    '${status}' == 'Y'
            Launch Browser and Navigate to Url
            Click Login Link
            Input Login Form    ${i}
            Button Click Login
            Button Click Link
            Select Term and Type    ${i}
            Handle Alert And Validate    ${i}
            Browser Close  
       END
    END
    
    Save And Close Excel
    