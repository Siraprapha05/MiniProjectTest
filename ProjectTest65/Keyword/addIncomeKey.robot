**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/addIncomeVar.robot

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

Click Income Link
    Mouse Over    ${MouseOver}
    Wait Until Element Is Visible    ${clickLink}    5s
    Click Element    ${clickLink}
    
Select Ordet name
    [Arguments]    ${i}
        ${ProductName}    Read Excel Cell    ${i}    5
        ${ProductName}    Evaluate    str("${ProductName}").strip()
        Wait Until Page Contains    ชื่อสินค้า
        Scroll Element Into View    ${locProductName}
        Wait Until Element Is Visible    ${locProductName}    2s
        Run Keyword And Ignore Error    
        ...    Select From List By Label    ${locProductName}    ${ProductName}
  
Input Amount
    [Arguments]    ${i}    
        ${amount}    Read Excel Cell    ${i}    6
        IF    '${amount}' == '${NONE}'
            ${amount}    Set Variable        
        END
        Scroll Element Into View    ${locAmount}
        Input Text    ${locAmount}    ${amount}




Handle Alert And Validate
    [Arguments]    ${i}
    ${Expec}    Read Excel Cell    ${i}    7
    
    ${ActualResult1}    Get Value    //input[@id="asset_price"]
    ${ActualResult2}    Get Value     //input[@id="sum"]
    Write Excel Cell    ${i}    8    ${ActualResult1}
    Write Excel Cell    ${i}    8    ${ActualResult2}

    IF    '${Expec}' == '${ActualResult1}' or '${Expec}' == '${ActualResult2}'
        Write Excel Cell    ${i}    9    Pass
    ELSE
        Write Excel Cell    ${i}    9    Fail
        Capture Page Screenshot    imgAddIncome/error_${i}.png
    END


Button Click
    # Wait Until Element Is Visible    //div[@class="list"]    5s
    # Wait Until Element Is Enabled    //div[@class="list"]    5s

    ${submit_button}    Get WebElement    //div[@class="list"]
    Scroll Element Into View    ${submit_button}
    Sleep    0.5s    
    Click Button    ${butSubmit}


Browser Close
    Sleep    2s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document
