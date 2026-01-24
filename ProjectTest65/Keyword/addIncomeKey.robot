**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/addIncomeVar.robot

*** Keywords ***
Launch Browser and Navigate to Url
    Open Browser   ${url}   ${browser}
    # Set Selenium Speed    1s
    Maximize Browser Window

Launch Excel
    Open Excel Document    ${DataTable}    ${sheet}

    
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

Login Input
    [Arguments]    ${i}
    Input Text    ${locEmail}    mju6204106317@mju.ac.th
    Input Text    ${locPassword}    111111


Button Click Login
    Click Button    ${locbtnLogin}
    Sleep    1s

Click Income Link
    Mouse Over    ${MouseOver}    
    Wait Until Element Is Visible    ${clickLink}    5s
    Click Element    ${clickLink}
    
    
Select Order Name
    [Arguments]    ${i}
        ${ProductName}    Read Excel Cell    ${i}    3
        ${ProductName}    Evaluate    str("${ProductName}").strip()
        Wait Until Page Contains    ชื่อสินค้า
        Scroll Element Into View    ${locProductName}
        Wait Until Element Is Visible    ${locProductName}    1s    
        Run Keyword And Ignore Error    
        ...    Select From List By Label    ${locProductName}    ${ProductName}
  
Input Amount
    [Arguments]    ${i}    
        ${amount}    Read Excel Cell    ${i}    4
        IF    '${amount}' == '${NONE}'
            ${amount}    Set Variable        
        END
        Scroll Element Into View    ${locAmount}
        Input Text    ${locAmount}    ${amount}


# Button Click Add
#     ${submit_button}    Get WebElement    //div[@class="list"]
#     Scroll Element Into View    ${submit_button}
#     Sleep    2s
#     Click Element    //input[@id='add']

Handle Alert And Validate
    [Arguments]    ${i}

    ${ExpectedResult}=    Read Excel Cell    ${i}    5

    ${hasSum}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    //input[@id='sum']    5s

    IF    ${hasSum}
        ${sumValue}=    Get Value    //input[@id='sum']

        IF    '${sumValue}' == '0' or '${sumValue}' == '${EMPTY}'
            ${submit_button}=    Get WebElement    //div[@class="list"]
            Scroll Element Into View    ${submit_button}
            Sleep    2s
            Click Element    //input[@id='add']

            ${hasErrorProduct}=    Run Keyword And Return Status
            ...    Wait Until Element Is Visible    //label[@id='alertProduct_name']    2s

            ${hasErrorAmount}=    Run Keyword And Return Status
            ...    Wait Until Element Is Visible    //label[@id='alertAmount']    2s

            IF    ${hasErrorProduct}
                ${ActualResult}=    Get Text    //label[@id='alertProduct_name']
            ELSE IF    ${hasErrorAmount}
                ${ActualResult}=    Get Text    //label[@id='alertAmount']
            ELSE
                ${ActualResult}=    Set Variable    No Error Message
            END
        ELSE
            ${ActualResult}=    Set Variable    ${sumValue}
        END

        Write Excel Cell    ${i}    6    ${ActualResult}
    END

    ${ActualResult}=    Read Excel Cell    ${i}    6

    IF    '${ActualResult}' == '${ExpectedResult}'
        Write Excel Cell    ${i}    7    Pass
    ELSE
        Write Excel Cell    ${i}    7    Fail
        Capture Page Screenshot    ProjectTest65/imgAddIncome/error_${i}.png
    END

Browser Close
    Sleep    2s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document
