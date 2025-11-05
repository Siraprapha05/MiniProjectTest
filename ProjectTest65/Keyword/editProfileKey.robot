**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../TestCase/editProfileTest.robot

*** Keywords ***
Launch Browser and Navigate to Url
    Open Browser   ${url}   ${browser}
    Maximize Browser Window

Launch Excel
    Open Excel Document    ${DataTable}    ${sheet}

    
Login Input
    [Arguments]    ${i}

        ${email}    Read Excel Cell    ${i}    3
        IF    '${email}' == '${NONE}'
            ${email}    Set Variable                
        END
        Scroll Element Into View    ${locemail}
        Input Text    ${locemail}    ${email}

        ${password}    Read Excel Cell    ${i}    4
        IF    '${password}' == '${NONE}'
            ${password}    Set Variable                
        END
        Scroll Element Into View    ${locPassword}
        Input Password    ${locPassword}    ${password}

Button Click Login
    Click Button    ${locbtnLogin}
    Sleep    1s

# Alert Login
#     [Arguments]    ${i}
#     ${Expec}     Read Excel Cell    ${i}    7
#     Sleep    2s

#     # Handle alert
#     ${statusLogin}    ${resultLogin}=    Run Keyword And Ignore Error     Handle Alert    accept    4s
#     Run Keyword If    '${statusLogin}' == 'PASS'    Write Excel Cell    ${i}    8    ${resultLogin} 

#     # Check Pass/Fail
#     IF    '${Expec}' in '${resultLogin}'
#         Write Excel Cell    ${i}    9    Pass
#     ELSE
#         Write Excel Cell    ${i}    9    Fail
#         Capture Page Screenshot    imgEditProfile/error_${i}.png
#     END


Click Profile Link
    Mouse Over    ${MouseOverProfile}
    Wait Until Element Is Visible    ${clickLinkProfile}    4s
    Click Element    ${clickLinkProfile}
    
Click Edit Profile
    Sleep    2s
    Click Button    ${btnEditProfile}
    
    
Input Form Fullname and Phone
    [Arguments]    ${i}
        ${name}    Read Excel Cell    ${i}    5
        IF    '${name}' == '${NONE}'
            ${name}    Set Variable
        END
        Wait Until Element Is Visible    ${locName}    4s
        Input Text    ${locName}    ${name}
        
        
        ${Phone}    Read Excel Cell    ${i}    6
        IF    '${Phone}' == '${NONE}'
            ${Phone}    Set Variable
        END
        Wait Until Element Is Visible    ${locPhone}    2s
        Input Text    ${locPhone}    ${Phone}


Button Save Edit Profile
    Sleep    2s
    Click Button    ${btnSaveEdit}


Get Visible Alert
    [Arguments]    ${locators}
    FOR    ${loc}    IN    @{locators}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${loc}    2s
        IF    ${status}
            ${msg}    Get Text    ${loc}
            RETURN     ${msg}
        END
    END
    RETURN     NONE


Handle Alert And Validate
    [Arguments]    ${i}
    ${Expec}     Read Excel Cell    ${i}    7

    Sleep    2s
    ${status}    ${result}=    Run Keyword And Ignore Error     Handle Alert    accept    4s
    Run Keyword If    '${status}' == 'Pass'    Write Excel Cell    ${i}    8    ${result} 
    
    ${locators}=    Create List
    ...    ${alertName}    ${alertPhone}
    ${alert_text}=    Get Visible Alert    ${locators}
    Run Keyword If    '${status}' != 'Pass'    Write Excel Cell    ${i}    8    ${alert_text}

    IF    '${Expec}' in ['${result}', '${alert_text}']
        Write Excel Cell    ${i}    9    Pass
    ELSE
        Write Excel Cell    ${i}    9    Fail
        Capture Page Screenshot    ProjectTest65/imgEditProfile/error_${i}.png
    END


Browser Close
    Sleep    1s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document
