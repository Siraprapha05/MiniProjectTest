*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Keyword/editIncomeAndExpenseKey.robot
Resource    ../Variables/editIncomeAndExpenseVar.robot

*** Test Cases ***
Test Edit Income And Expense 
    Launch Excel
    FOR    ${i}    IN RANGE    2    ${row}+1
       ${status}    Read Excel Cell    ${i}    1 
       IF    '${status}' == 'Y'
            Launch Browser and Navigate to Url
            Input Login Form    ${i}
            Button Click Login
            Button Click Link
            Select Term and Type    ${i}
            Input Amount    ${i}
            Handle Alert And Validate    ${i}
            Browser Close  
       END
    END
    
    Save And Close Excel
    