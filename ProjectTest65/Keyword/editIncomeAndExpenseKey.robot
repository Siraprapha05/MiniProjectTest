*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../TestCase/editIncomeAndExpenseTest.robot

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
    Select From List By Label    ${locType}    รายรับ
    Click Button    ${locBtnSearch}    
    Wait Until Element Is Visible    ${locBtnView}    5s
    Click Button    ${locBtnView}
    Wait Until Element Is Visible    ${locBtnEdit}   3s
    Click Button    ${locBtnEdit}

Input Amount
    [Arguments]    ${i}
    ${amount}    Read Excel Cell    ${i}    3
    IF    '${amount}' == '${NONE}'
        ${amount}    Set Variable                
    END
    Clear Element Text    ${locAmount}
    Wait Until Element Is Visible    ${locSum}    5s
    Input Text    ${locAmount}    ${amount}

    # Click Button    ${locBtnSaveEdit}

Handle Alert And Validate
    [Arguments]    ${i}

    ${ExpectedResult}=    Read Excel Cell    ${i}    4
    # ${ActualResult}=      Read Excel Cell    ${i}    4

    ${hasAmount}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${locSum}

    IF    ${hasAmount}
        ${ActualResult}=    Get Value    ${locSum}
        Write Excel Cell    ${i}    5    ${ActualResult}

        IF    '${ActualResult}' == '0'
            Click Element    //button[@type="submit"]
            Sleep    2s

            # 3) หลัง submit ค่อยเช็ค 500
            ${is500}=    Run Keyword And Return Status
            ...    Page Should Contain    HTTP Status 500

            IF    ${is500}
                ${ActualResult}=    Set Variable    HTTP Status 500 – Internal Server Error
                Write Excel Cell    ${i}    5    ${ActualResult}
            END
        END
    ELSE
        ${ActualResult}=    Set Variable    NOT FOUND
        Write Excel Cell    ${i}    5    ${ActualResult}
    END

    IF    '${ActualResult}' == '${ExpectedResult}'
        Write Excel Cell    ${i}    6    Pass
    ELSE
        Write Excel Cell    ${i}    6    Fail
        Capture Page Screenshot    ProjectTest65/imgEditIncomeAndExpense/error_${i}.png
    END


Browser Close
    Sleep    1s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document