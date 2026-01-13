**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/addExpenseVar.robot

*** Keywords ***
Launch Browser and Navigate to Url
    Open Browser   ${url}   ${browser}
    # Set Selenium Speed    1s
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

Click Income Link
    Mouse Over    ${MouseOver}    
    Wait Until Element Is Visible    ${clickLink}    5s
    Click Element    ${clickLink}

Select Order Name
    [Arguments]    ${i}
        ${DeviceName}    Read Excel Cell    ${i}    5
        ${DeviceName}    Evaluate    str("${DeviceName}").strip()
        Wait Until Page Contains    ชื่ออุปกรณ์
        Scroll Element Into View    ${locDeviceName}
        Wait Until Element Is Visible    ${locDeviceName}    1s    
        Run Keyword And Ignore Error    
        ...    Select From List By Label    ${locDeviceName}    ${DeviceName}

Input Price
    [Arguments]    ${i}    
        ${Price}    Read Excel Cell    ${i}    6
        IF    '${Price}' == '${NONE}'
            ${Price}    Set Variable        
        END
        Scroll Element Into View    ${locAssetPrice}
        Input Text    ${locAssetPrice}    ${Price}


Input Amount
    [Arguments]    ${i}    
        ${amount}    Read Excel Cell    ${i}    7
        IF    '${amount}' == '${NONE}'
            ${amount}    Set Variable        
        END
        Scroll Element Into View    ${locAmount}
        Input Text    ${locAmount}    ${amount}

Handle Alert And Validate
    [Arguments]    ${i}    

    ${ExpectedResult}=    Read Excel Cell    ${i}    8
    ${ActualResult}=    Read Excel Cell    ${i}    9
    IF    '${ExpectedResult}' == '${ActualResult}'
        Write Excel Cell    ${i}    10    Pass
    ELSE
        Write Excel Cell    ${i}    10    Fail
        Capture Page Screenshot    ProjectTest65\imgAddExpense\error_${i}.png
    END


Browser Close
    Sleep    2s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document