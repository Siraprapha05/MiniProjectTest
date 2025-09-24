*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../TestCase/addShiftTest.robot

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
    Sleep    3s    

Click Link Add Shift
    Click Element    ${clickLink}


Input Work Date
    [Arguments]    ${i}
        ${birthdate}    Read Excel Cell    ${i}    5
        IF    '${birthdate}' != '${NONE}'
            ${date}    Evaluate    "${birthdate}".replace("/", "-")        
        ELSE
            ${date}    Set Variable    ""
        END
        Wait Until Element Is Visible    ${locWorkDate}    3s
        Clear Element Text    ${locWorkDate}
        Input Text    ${locWorkDate}    ${date}


Input Start Time
    [Arguments]    ${i}
        ${StartTime}    Read Excel Cell    ${i}    6
        IF    '${StartTime}' == '${NONE}'
            ${StartTime}    Set Variable
        END
        Input Text    ${locStartTime}    ${StartTime}
        Sleep    2s

Input End Time
    [Arguments]    ${i}
        ${EndTime}    Read Excel Cell    ${i}    7
        IF    '${EndTime}' == '${NONE}'
            ${EndTime}    Set Variable
        END
        Input Text    ${locEndTime}    ${EndTime}

Input Role
    [Arguments]    ${i}
        ${Role}    Read Excel Cell    ${i}    8
        IF    '${Role}' == '${NONE}'
            ${Role}    Set Variable
        END
        Input Text    ${locRole}    ${Role}

Button Click
    Click Button    ${btnSave}
    Sleep    5s


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

# Handle Alert And Validate
#     [Arguments]    ${i}
#     ${Expec}     Read Excel Cell    ${i}    9
#     ${role}     Read Excel Cell    ${i}    8

#     Sleep    2s
#     ${status}    ${result}=    Run Keyword And Ignore Error    Handle Alert    accept    3s
#     Run Keyword If    '${status}'=='PASS'    Write Excel Cell    ${i}    10    ${result}  

#     ${locators}=    Create List
#     ...    ${alertRole}    ${alertText}
#     ${alert_text}=    Get Visible Alert    ${locators}   

#     Run Keyword If    '${status}'!='PASS'     Write Excel Cell    ${i}    10    ${alert_text}

#     IF    '${Expec}' in ['${result}', '${alert_text}']
#         Write Excel Cell    ${i}    11    Pass
#     ELSE
#         Write Excel Cell    ${i}    11    Fail
#         Capture Page Screenshot    imgAddShift/error_${i}.png
#     END


Handle Alert And Validate
    [Arguments]    ${i}
        ${Expec}     Read Excel Cell    ${i}    9
        ${role}     Read Excel Cell    ${i}    8
        IF    '${role}' == '' or '${role}' == 'None' or '${role}' == '${None}' 
            ${alertMsg}=    Set Variable    Please fill out this field.
            Log    ${alertMsg} (row ${i})
            Write Excel Cell    ${i}    10    ${alertMsg}   
            Write Excel Cell    ${i}    11    Fail        
            RETURN
        END
        Sleep    2s
        ${status}    ${result}=    Run Keyword And Ignore Error    Handle Alert    accept    3s
        Run Keyword If    '${status}'=='PASS'    Write Excel Cell    ${i}    10    ${result}  

        ${locators}=    Create List
        ...    ${alertRole}    ${alertText}
        ${alert_text}=    Get Visible Alert    ${locators}   

        Run Keyword If    '${status}'!='PASS'     Write Excel Cell    ${i}    10    ${alert_text}

        IF    '${Expec}' == '${result}' or '${Expec}' == '${alert_text}'

            Write Excel Cell    ${i}    11    Pass
        ELSE
            Write Excel Cell    ${i}    11    Fail
            Capture Page Screenshot    imgAddShift/error_${i}.png
        END


Browser Close
    Sleep    1s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document