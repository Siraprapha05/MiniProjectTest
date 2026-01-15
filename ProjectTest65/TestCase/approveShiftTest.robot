*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Keyword/addShiftKey.robot
Resource    ../Variables/addShiftVar.robot

*** Test Cases ***
Test Add Shift 
    Launch Excel
    FOR    ${i}    IN RANGE    2    ${row}+1
       ${status}    Read Excel Cell    ${i}    1 
       IF    '${status}' == 'Y'
            Launch Browser and Navigate to Url
            Login Input    ${i}
            Button Click Login
            Click Link Add Shift

            # Handle Alert And Validate    ${i}
            Browser Close  
       END
    END
    
    Save And Close Excel
    