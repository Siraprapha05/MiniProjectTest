*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/addIncomeVar.robot
Resource    ../Keyword/addIncomeKey.robot

*** Test Cases ***
Test Add Income
   Launch Excel
   
    FOR    ${i}    IN RANGE    2    3     ##${row}+1
       ${status}    Read Excel Cell    ${i}    1 
       IF    '${status}' == 'Y'
           Launch Browser and Navigate to Url
            Login Input    ${i}
            Button Click Login
            Sleep    1s
            Click Income Link
            Select Order Name    ${i}
            Input Amount    ${i}          
            # Handle Alert And Validate    ${i}
            Button Click    
            Get Actual Result    ${i}
            # Error Msg     ${i}
            Verify    ${i}
       END
    END
    Browser Close 
    Save And Close Excel 