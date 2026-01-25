*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../TestCase/approveRequestTest.robot

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
    Input Text    ${locEmail}    officer1503@mju.ac.th
    Input Text    ${locPassword}    1503

Button Click Login
    Click Button    ${locbtnLogin}
    Sleep    3s  

Button Click Check
    
    Click Element    ${onclickLink}
    Wait Until Element Is Visible    ${onclickLink}    3s
    Click Element    ${lohbtnCheck}

Handle Alert And Validate
    [Arguments]    ${i}
    ${ExpectedResult}=    Read Excel Cell    ${i}    4
    ${ActualResult}=      Set Variable    ${EMPTY}

    ${hasApprove}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${locbtnApprove}
    ${hasReject}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${locbtnReject}

    IF    ${hasApprove}
        Click Element    ${locbtnApprove}
        Write Excel Cell    ${i}    5    ${ActualResult}
    ELSE IF    ${hasReject}
        Click Element    ${locbtnReject}
        Write Excel Cell    ${i}    5    ${ActualResult}
    END
    
    
    ${status}    ${alert_text}=    Run Keyword And Ignore Error    Handle Alert    accept    2s

    IF    '${status}' == 'PASS'
        ${ActualResult}=    Set Variable    ${alert_text}
        Write Excel Cell    ${i}    5    ${ActualResult}
    ELSE
        ${ActualResult}=    Set Variable    no message
        Write Excel Cell    ${i}    5    ${ActualResult}
    END

           
    ${ActualResult}=    Read Excel Cell    ${i}    5

    IF    '${ActualResult}' == '${ExpectedResult}'
        Write Excel Cell    ${i}    6    Pass
    ELSE
        Write Excel Cell    ${i}    6    Fail
        Capture Page Screenshot    ProjectTest65/imgApproveRequest/error_${i}.png
    END

Browser Close
    Sleep    2s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document