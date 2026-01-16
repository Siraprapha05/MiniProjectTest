**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../TestCase/SetPermissionsTest.robot

*** Keywords ***
Launch Browser and Navigate to Url
    Open Browser   ${url}   ${browser}
    Maximize Browser Window

Launch Excel
    Open Excel Document    ${DataTable}    ${sheet}

Input Login Form
    [Arguments]    ${i}
    Input Text    //input[@id="email"]    officer1503@mju.ac.th
    Input Text    //input[@id="pwd"]    1503


Button Click Login
    Click Button    ${locbtnLogin}


Click Permissions Link
    Mouse Over    ${MouseOver}
    Wait Until Element Is Visible    ${clickLink}    10s
    Click Element    ${clickLink}
    

Button Click Go SetPermissions
    Click Element    ${lonbtn}
    Sleep    2s

Select Set Permission
    [Arguments]    ${i}
    ${permission}    Read Excel Cell    ${i}    3
    ${permission}    Evaluate    str("${permission}").strip()
    Log    Permission from Excel: ${permission}
    Run Keyword And Ignore Error    
    ...    Select From List By Label    ${locSetpermission}    ${permission}
    Click Element    ${locSubmit}


Handle Alert And Validate
    [Arguments]    ${i}

    ${ExpectedResult}=    Read Excel Cell    ${i}    4
    ${ActualResult}=    Set Variable    ${EMPTY}

    ${ActualResult}=    Set Variable    บันทึกข้อมูลสำเร็จ
    Write Excel Cell    ${i}    5    ${ActualResult}
    
    IF    '${ActualResult}' == '${ExpectedResult}'
        Write Excel Cell    ${i}    6    Pass
    ELSE
        Write Excel Cell    ${i}    6    Fail
        Capture Page Screenshot    ProjectTest65/imgSetPermission/error_${i}.png
    END

Browser Close
    Sleep    2s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document

