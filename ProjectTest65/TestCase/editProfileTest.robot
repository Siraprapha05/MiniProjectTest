**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/editProfileVar.robot
Resource    ../Keyword/editProfileKey.robot

*** Test Cases ***
Test Edit Profile
    Launch Excel
    FOR    ${i}    IN RANGE    2    ${row}+1
        ${status}    Read Excel Cell    ${i}    1
        IF    '${status}' == 'Y'
            Launch Browser and Navigate to Url
            Login Input     ${i}
            Button Click Login
            # Alert Login    ${i}
            Click Profile Link
            Click Edit Profile
            Input Form Fullname and Phone    ${i}
            Button Save Edit Profile
            Handle Alert And Validate    ${i}
             
        END
    END
    Browser Close 
    Save And Close Excel