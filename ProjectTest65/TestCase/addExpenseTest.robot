*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/addExpenseVar.robot
Resource    ../Keyword//addExpenseKey.robot

*** Test Cases ***
Test Add Expense
   Launch Excel
    FOR    ${i}    IN RANGE    2     ${row}+1
       ${status}    Read Excel Cell    ${i}    1 
       IF    '${status}' == 'Y'
            Launch Browser and Navigate to Url
            Login Input    ${i}
            Button Click Login
            Sleep    1s
            Click Income Link
            Select Order Name    ${i}
            Input Price    ${i}
            Input Amount    ${i}  

            Handle Alert And Validate    ${i}

       END
    END
    Browser Close 
    Save And Close Excel 