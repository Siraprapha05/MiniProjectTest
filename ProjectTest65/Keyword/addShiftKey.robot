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


Click Login Link
    Click Link    ${locClickLogin}

Login Input
    [Arguments]    ${i}
    Input Text    ${locEmail}    mju6204106317@mju.ac.th
    Input Text    ${locPassword}    111111

# Login Input
#     [Arguments]    ${i}

#         ${email}    Read Excel Cell    ${i}    3
#         IF    '${email}' == '${NONE}'
#             ${email}    Set Variable                
#         END
#         Scroll Element Into View    ${locemail}
#         Input Text    ${locemail}    ${email}

#         ${password}    Read Excel Cell    ${i}    4
#         IF    '${password}' == '${NONE}'
#             ${password}    Set Variable                
#         END
#         Scroll Element Into View    ${locPassword}
#         Input Password    ${locPassword}    ${password}


Button Click Login
    Click Button    ${locbtnLogin}
    Sleep    3s    

Click Link Add Shift
    Click Element    ${clickLink}


Input Work Date
    [Arguments]    ${i}
        ${birthdate}    Read Excel Cell    ${i}    3
        IF    '${birthdate}' != '${NONE}'
            ${date}    Evaluate    "${birthdate}".replace("/", "-")        
        ELSE
            ${date}    Set Variable    ""
        END
        # Wait Until Element Is Visible    ${locWorkDate}    3s
        Clear Element Text    ${locWorkDate}
        Input Text    ${locWorkDate}    ${date}


Input Start Time
    [Arguments]    ${i}
        ${StartTime}    Read Excel Cell    ${i}    4
        IF    '${StartTime}' == '${NONE}'
            ${StartTime}    Set Variable
        END
        Input Text    ${locStartTime}    ${StartTime}
        Sleep    2s

Input End Time
    [Arguments]    ${i}
        ${EndTime}    Read Excel Cell    ${i}    5
        IF    '${EndTime}' == '${NONE}'
            ${EndTime}    Set Variable
        END
        Input Text    ${locEndTime}    ${EndTime}

Input Role
    [Arguments]    ${i}
        ${Role}    Read Excel Cell    ${i}    6
        IF    '${Role}' == '${NONE}'
            ${Role}    Set Variable
        END
        Input Text    ${locRole}    ${Role}

Button Click
    Click Button    ${btnSave}
    Sleep    2s


Handle Alert And Validate
    [Arguments]    ${i}

    ${ExpectedResult}=    Read Excel Cell    ${i}    7
    ${ActualResult}=      Set Variable    ${EMPTY}

    ${status}    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    leave    
    Run Keyword If    '${status}'=='PASS'    Write Excel Cell    ${i}    8    ${alert_text}

        ${is500}=    Run Keyword And Return Status    Page Should Contain    HTTP Status 500

        IF    ${is500}
            ${ActualResult}=    Set Variable    HTTP Status 500 – Internal Server Error
            Write Excel Cell     ${i}    8    ${ActualResult}
        ELSE

            ${start}=    Read Excel Cell    ${i}    4
            ${end}=    Read Excel Cell    ${i}    5
            
            ${hasalertRole}=    Run Keyword And Return Status
            ...    Wait Until Element Is Visible    //label[@id="alertTask_name"]    2s
            
            ${hasalertText}=    Run Keyword And Return Status
            ...    Wait Until Element Is Visible    //p[text()=' เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง !!!']    2s

            IF    '${start}' == '' or '${start}' == 'None' or '${end}' == '' or '${end}' == 'None'
                ${ActualResult}=    Set Variable    Please fill out this field.
                Write Excel Cell    ${i}    8    ${ActualResult}
            ELSE IF    ${hasalertRole}
                ${ActualResult}=    Get Text    //label[@id="alertTask_name"] 
                Write Excel Cell     ${i}    8    ${ActualResult}
            ELSE IF    ${hasalertText}
                ${ActualResult}=    Get Text    //p[text()=' เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง !!!']
                Write Excel Cell     ${i}    8    ${ActualResult}
            ELSE
                ${ActualResult}=    Set Variable    ${EMPTY} 
            END
        END
        
    IF    '${ExpectedResult}' == '${ActualResult}' or '${ExpectedResult}' == '${alert_text}'
        Write Excel Cell    ${i}    9    Pass
    ELSE
        Write Excel Cell    ${i}    9    Fail
        Capture Page Screenshot    ProjectTest65/imgAddShift/error_${i}.png
    END


Browser Close
    Sleep    1s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document