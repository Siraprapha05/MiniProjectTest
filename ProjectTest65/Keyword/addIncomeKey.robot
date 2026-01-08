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
        Wait Until Element Is Visible    ${locProductName}    1s    
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


# Button Click
#     # ${ActualResult1}    Get Value    ${locAssetPrice}
#     ${ActualResult1}    Get Value    ${locSum}

#     ${submit_button}    Get WebElement    //div[@class="list"]
#     Scroll Element Into View    ${submit_button}
#     Sleep    1s
#     # Execute Javascript    document.getElementById("add").click()
#     Click Element    //input[@id='add']

#     RETURN    ${ActualResult1}

Button Click
    ${submit_button}    Get WebElement    //div[@class="list"]
    Scroll Element Into View    ${submit_button}
    Sleep    2s
    Click Element    //input[@id='add']


Handle Alert And Validate
    [Arguments]    ${i}
    ${Expec}    Read Excel Cell    ${i}    7
    ${ActualResult1}    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    //input[@id='sum']    timeout=5s
    
    IF    ${ActualResult1}
        ${ActualResult1}    Get Value    //input[@id='sum']
        Write Excel Cell    ${i}    8    ${ActualResult1}
    END

# แก้ไขตรง Write Excel Cell มันเขียนทับ Error Msg
Error Msg
    [Arguments]    ${i}
    ${ExpectedResult}=    Read Excel Cell    ${i}    7
    ${ActualResult}=    Set Variable    ${EMPTY}

    ${is_error_product}=    Run Keyword And Return Status
    ...    Page Should Contain Element    css:#alertProduct_name
    Scroll Element Into View    //input[@id='add']
    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    css:#alertProduct_name    5s
    IF     ${is_error_product}
        ${ActualResult}    Get Text    css:#alertProduct_name
        Write Excel Cell    ${i}    8    ${ActualResult}
    END

    # ${is_error_amount}=    Run Keyword And Return Status
    # ...    Page Should Contain Element    //label[@id='alertAmount']

    # IF    '${ExpectedResult}' == 'กรุณาเลือกสินค้า, กรุณากรอกจำนวน'
    #     IF    ${is_error_product} and ${is_error_amount}
    #         ${ActualResult}=    Set Variable    กรุณาเลือกสินค้า, กรุณากรอกจำนวน
    #     END
    # ELSE IF    '${ExpectedResult}' == 'กรุณาเลือกสินค้า'
    #     IF    ${is_error_product}
    #         ${ActualResult}=    Set Variable    กรุณาเลือกสินค้า
    #     END
    # ELSE IF    '${ExpectedResult}' == 'กรุณากรอกจำนวน'
    #     IF    ${is_error_amount}
    #         ${ActualResult}=    Set Variable    กรุณากรอกจำนวน
    #     END
    # END

    # Write Excel Cell    ${i}    8    ${ActualResult}



Get Actual Result
    [Arguments]    ${i}

    ${ActualResult}=    Set Variable    ${EMPTY}

    # กรณี Success (มี sum)
    ${is_success}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    //input[@id='sum']    3s

    IF    ${is_success}
        ${ActualResult}=    Get Value    //input[@id='sum']
    ELSE
        # ตรวจ error สินค้า
        ${is_error_product}=    Run Keyword And Return Status
        ...    Page Should Contain Element    css:#alertProduct_name

        # ตรวจ error จำนวน
        ${is_error_amount}=    Run Keyword And Return Status
        ...    Page Should Contain Element    css:#alertAmount

        IF    ${is_error_product} and ${is_error_amount}
            ${ActualResult}=    Set Variable    กรุณาเลือกสินค้า, กรุณากรอกจำนวน
        ELSE IF    ${is_error_product}
            ${ActualResult}=    Get Text    css:#alertProduct_name
        ELSE IF    ${is_error_amount}
            ${ActualResult}=    Get Text    css:#alertAmount
        END
    END

    Write Excel Cell    ${i}    8    ${ActualResult}

Verify
    [Arguments]    ${i}    
    ${ActualResult}    Read Excel Cell    ${i}    8
    ${ExpectedResult}=    Read Excel Cell    ${i}    7    
    
    IF    '${ActualResult}' == '${ExpectedResult}'

        Write Excel Cell    ${i}    9    Pass
    ELSE
        Write Excel Cell    ${i}    9    Fail
        Capture Page Screenshot    ProjectTest65/imgAddIncome/error_${i}.png
    END


Browser Close
    Sleep    2s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document
