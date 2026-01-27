*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../TestCase/removeInAndExTest.robot

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

Button Click Link
    Click Element     //a[contains(text(),'รายรับรายจ่ายของโครงการ')]

Select Term and Type
    [Arguments]    ${i}
    Wait Until Page Contains    เทอมปีการศึกษา :
    Select From List By Value    ${locTerm}    1-2565
    Select From List By Label    ${locType}    รายจ่าย
    Click Button    ${locBtnSearch}  
    Wait Until Element Is Visible   ${locDelete}    5s


Handle Alert And Validate
    [Arguments]    ${i}

    ${ExpectedResult}=    Read Excel Cell    ${i}    4
    ${ActualResult}=      Set Variable       ${EMPTY}

    Click Element    ${locDelete}
    Wait Until Page Contains    ต้องการลบใช่หรือไม่ ?    5s

    ${condition}=    Read Excel Cell    ${i}    3

    IF    '${condition}' == 'กดลบ'
        ${ActualResult}=    Set Variable    ต้องการลบใช่หรือไม่ ?

    ELSE IF    '${condition}' == 'ไม่ใช่'
        Click Element    ${locCancel}

        ${isDataExist}=    Run Keyword And Return Status
        ...    Page Should Contain    ข้อมูลอยู่ที่เดิม

        IF    ${isDataExist}
            ${ActualResult}=    Set Variable    ข้อมูลจะต้องอยู่ที่เดิม
        END

    ELSE IF    '${condition}' == 'ใช่'
        Click Element    ${locOK}

        ${isDataGone}=    Run Keyword And Return Status
        ...    Page Should Not Contain    ข้อมูลถูกลบ

        IF    ${isDataGone}
            ${ActualResult}=    Set Variable    ข้อมูลรายรับรายจ่ายของโครงการะหายไป
        END
    END
    Write Excel Cell    ${i}    5    ${ActualResult}
    Log To Console    Row:${{${row}-1}}
    
    IF    '${ActualResult}' == '${ExpectedResult}'
        Write Excel Cell    ${i}    6    Pass
    ELSE
        Write Excel Cell    ${i}    6    Fail
        Capture Page Screenshot    ProjectTest65/imgRemoveIncomeAndExpense/error_${i}.png
    END



Browser Close
    Sleep    1s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document