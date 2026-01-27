**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../TestCase/loginTest.robot

*** Keywords ***
Launch Browser and Navigate to Url
    Open Browser   ${url}   ${browser}
    Maximize Browser Window

Launch Excel
    Open Excel Document    ${DataTable}    ${sheet}

Click Login Link
    Click Link    ${locClickLogin}

Input Form
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
    Wait Until Element Is Visible    ${locbtn}

Button Click 
    Click Button    ${locbtn}
    

Handle Alert And Validate
    [Arguments]    ${i}

    ${Expec}=        Read Excel Cell    ${i}    5
    ${email}=        Read Excel Cell    ${i}    3
    ${password}=     Read Excel Cell    ${i}    4

    ${ActualMsg}=    Set Variable    ${EMPTY}
    # ถ้าไม่กรอก
    IF    '${email}' in ['${NONE}',''] or '${password}' in ['${NONE}','']
        ${ActualMsg}=    Set Variable    Please fill out this field.
        Write Excel Cell    ${i}    6    ${ActualMsg}
        Write Excel Cell    ${i}    7    Fail
        RETURN
    END

    Sleep    3s

    # JS Alert
    ${jsStatus}    ${jsAlert}=    Run Keyword And Ignore Error
    ...    Handle Alert    ACCEPT    2s

    IF    '${jsStatus}' == 'PASS'
        ${ActualMsg}=    Set Variable    ${jsAlert}
    END

    # Alert
    IF    '${ActualMsg}' == ''
        ${hasPage}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible
        ...    xpath=//div[contains(@class,"bg-light")]//p[1]    2s
        IF    ${hasPage}
            ${ActualMsg}=    Get Text    xpath=//div[contains(@class,"bg-light")]//p[1]
        END
    END

    IF    '${ActualMsg}' == ''
        ${ActualMsg}=    Set Variable    เข้าสู่ระบบสำเร็จ
    END

    Write Excel Cell    ${i}    6    ${ActualMsg}
    Log To Console    Row:${{${row}-1}}
    
    IF    '${Expec}' == '${ActualMsg}'
        Write Excel Cell    ${i}    7    Pass
    ELSE
        Write Excel Cell    ${i}    7    Fail
        Capture Page Screenshot    ProjectTest65/imgLogin/error_${i}.png
    END


Browser Close
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document

