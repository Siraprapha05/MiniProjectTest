**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/loginVar.robot
Resource    ../Keyword/loginKey.robot


*** Test Cases ***
Test Login
    Launch Excel
    FOR    ${i}    IN RANGE    1    ${row}+1
        ${status}    Read Excel Cell    ${i}    1
        IF    '${status}' == 'Y'
            Launch Browser and Navigate to Url
            Click Login Link
            Input Form    ${i}
            Button Click 
            Handle Alert And Validate    ${i}
            Browser Close
        END
    END
     
    Save And Close Excel