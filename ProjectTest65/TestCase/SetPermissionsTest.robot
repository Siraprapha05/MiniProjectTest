**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/SetPermissionsVar.robot
Resource    ../Keyword/SetPermissionsKey.robot

*** Test Cases ***
Test Set Permissions
    Launch Excel
    FOR    ${i}    IN RANGE    1    ${row}+1
        ${status}    Read Excel Cell    ${i}    1
        IF    '${status}' == 'Y'
            Launch Browser and Navigate to Url
            Input Login Form    ${i}
            Button Click Login
            Click Permissions Link
            Button Click Go SetPermissions
            Select Set Permission    ${i}
            # Input Form    ${i}
            # Button Click 
            Handle Alert And Validate    ${i}
            Browser Close
        END
    END
     
    Save And Close Excel