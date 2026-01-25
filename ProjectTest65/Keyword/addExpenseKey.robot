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
    Sleep    1s

Click Income Link
    Mouse Over    ${MouseOver}    
    Wait Until Element Is Visible    ${clickLink}    10s
    Click Element    ${clickLink}

Select Order Name
    [Arguments]    ${i}
        ${DeviceName}    Read Excel Cell    ${i}    3
        ${DeviceName}    Evaluate    str("${DeviceName}").strip()
        Wait Until Page Contains    ชื่ออุปกรณ์
        Scroll Element Into View    ${locDeviceName}
        Wait Until Element Is Visible    ${locDeviceName}    1s    
        Run Keyword And Ignore Error    
        ...    Select From List By Label    ${locDeviceName}    ${DeviceName}

Input Price
    [Arguments]    ${i}    
        ${Price}    Read Excel Cell    ${i}    4
        IF    '${Price}' == '${NONE}'
            ${Price}    Set Variable        
        END
        Scroll Element Into View    ${locAssetPrice}
        Input Text    ${locAssetPrice}    ${Price}


Input Amount
    [Arguments]    ${i}    
        ${amount}    Read Excel Cell    ${i}    5
        IF    '${amount}' == '${NONE}'
            ${amount}    Set Variable        
        END
        Scroll Element Into View    ${locAmount}
        Input Text    ${locAmount}    ${amount}

Handle Alert And Validate
    [Arguments]    ${i}    
    ${ExpectedResult}=    Read Excel Cell    ${i}    6
    

    ${hasSum}   Run Keyword And Return Status    
    ...    Wait Until Element Is Visible    //input[@id='sum']    3s
    
    IF    ${hasSum}
        ${sumValue}=    Get Value    //input[@id='sum']
        ${submit_button}=    Get WebElement    //div[@class="list"]
            Scroll Element Into View    ${submit_button}
            Sleep    2s
            Click Element    //input[@id='add']
            
            ${hasErrorProduct}    Run Keyword And Return Status    
            ...    Wait Until Element Is Visible    ${alertProduct_name}   3s

            ${hasErrorPrice}    Run Keyword And Return Status    
            ...    Wait Until Element Is Visible    ${alertAssetPrice}   3s        

            ${hasErrorAmount}    Run Keyword And Return Status
            ...    Wait Until Element Is Visible    ${alertAmount}   3s
            
        # HTTP Status 500 – Internal Server Error
        # ${is500}=    Run Keyword And Return Status    Page Should Contain    HTTP Status 500

        # IF    ${is500}
        #     ${ActualResult}=    Set Variable    HTTP Status 500 – Internal Server Error
        # ELSE
            IF    ${hasErrorProduct}
                ${ActualResult}=    Get Text    ${alertProduct_name}
            ELSE IF    ${hasErrorPrice}
                ${ActualResult}=    Get Text    ${alertAssetPrice}
            ELSE IF    ${hasErrorAmount}
                ${ActualResult}=    Get Text    ${alertAmount}
            ELSE
            ${ActualResult}=    Set Variable    ${sumValue}
        # END  
        END      
        Write Excel Cell    ${i}    7    ${ActualResult}  
    END

    ${ActualResult}=    Read Excel Cell    ${i}    7
    Log To Console    Row:${{${row}-1}}

    IF    '${ExpectedResult}' == '${ActualResult}'
        Write Excel Cell    ${i}    8    Pass
    ELSE
        Write Excel Cell    ${i}    8    Fail
        Sleep    2s
        Capture Page Screenshot    ProjectTest65/imgAddExpense/error_${i}.png
    END


Browser Close
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document