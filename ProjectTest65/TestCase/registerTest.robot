**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/registerVar.robot
Resource    ../Keyword/registerKey.robot

*** Test Cases ***
Test Register
    Launch Excel
    FOR    ${i}    IN RANGE    1    ${row}+1
        ${status}    Read Excel Cell    ${i}    1
        IF    '${status}' == 'Y'
            Launch Browser and Navigate to Url
            Input Form Fullname and Phone      ${i}
            Input Birthdate    ${i}
            Select Term    ${i}
            Input Form stucode and Major    ${i}
            Select Faculty    ${i}
            Input Form     ${i}
            Button Click
            Handle Alert And Validate    ${i}
            
        END
    END
    Browser Close  
    Save And Close Excel