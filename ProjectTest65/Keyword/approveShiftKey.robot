*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../TestCase/approveShiftTest.robot

*** Keywords ***
Launch Browser and Navigate to Url
    Open Browser   ${url}   ${browser}
    Maximize Browser Window

Launch Excel
    Open Excel Document    ${DataTable}    ${sheet}

Click Login Link
    Click Link    ${locClickLogin}

Input Login Form
    [Arguments]    ${i}
    Input Text    ${locEmail}    mju6204106317@mju.ac.th
    Input Text    ${locPassword}    111111


Button Click Login
    Click Button    ${locbtnLogin}
    Sleep    3s    

Click Link Shift
    Click Element    ${clickLink}
    Wait Until Element Is Visible    ${clickButton}     3s
    Click Element    ${clickButton}


Handle Alert And Validate
    [Arguments]    ${i}
    ${ExpectedResult}=    Read Excel Cell    ${i}    4
    ${ActualResult}=      Set Variable    ${EMPTY}

    ${hasApprove}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${approve}

    ${hasReject}=     Run Keyword And Return Status
    ...    Page Should Contain Element    ${reject}

    IF    ${hasApprove}
        Click Element    ${approve}
        Write Excel Cell    ${i}    5    ${ActualResult}
    ELSE IF    ${hasReject}
        Click Element    ${reject}
        Write Excel Cell    ${i}    5    ${ActualResult}
    END

    ${status}    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    accept    5s

    IF    '${status}' == 'PASS'
        ${ActualResult}=    Set Variable    ${alert_text}
        Write Excel Cell    ${i}    5    ${ActualResult}
    ELSE
        ${ActualResult}=    Set Variable    no message
        Write Excel Cell    ${i}    5    ${ActualResult}
    END

       
    ${ActualResult}=    Read Excel Cell    ${i}    5
    Log To Console    Row:${{${row}-1}}
    
    IF    '${ActualResult}' == '${ExpectedResult}'
        Write Excel Cell    ${i}    6    Pass
    ELSE
        Write Excel Cell    ${i}    6    Fail
        Capture Page Screenshot    ProjectTest65/imgApproveShift/error_${i}.png
    END

Browser Close
    Sleep    1s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document