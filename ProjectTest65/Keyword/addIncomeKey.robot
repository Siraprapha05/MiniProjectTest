**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../Variables/addIncomeVar.robot

*** Keywords ***
Launch Browser and Navigate to Url
    Open Browser   ${url}   ${browser}
    Set Selenium Speed    0.3s
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
    Wait Until Element Is Visible    ${clickLink}    10s
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


Button Click
    ${ActualResult1}    Get Value    ${locAssetPrice}
    ${ActualResult2}    Get Value    ${locSum}

    ${submit_button}    Get WebElement    //div[@class="list"]
    Scroll Element Into View    ${submit_button}
    Sleep    1s
    Execute Javascript    document.getElementById("add").click()

    RETURN    ${ActualResult1}    ${ActualResult2}


# กรอกข้อมูลแล้วกดบันทึก
# Handle Alert And Validate
#     [Arguments]    ${i}
#     ${Expec}=    Read Excel Cell    ${i}    7

#     ${sumStatus}    ${sumMsg}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${locSum}    5s
#     IF    '${sumStatus}' == 'PASS'
#         ${sumValue}=    Get Value    ${locSum}
#         Write Excel Cell    ${i}    8    ${sumValue}
#     END

#     ${Actual}=    Read Excel Cell    ${i}    8
#     IF    '${Expec}' == '${Actual}'
#         Write Excel Cell    ${i}    9    Pass
#     ELSE
#         Write Excel Cell    ${i}    9    Fail
#         Capture Page Screenshot    ProjectTest65/imgAddIncome/error_${i}.png
#     END


# Handle Alert And Validate
#     [Arguments]    ${i}
#     ${Expec}=    Read Excel Cell    ${i}    7

#     ${locAssetPrice}=    Set Variable    //input[@id="asset_price"]
#     ${locSum}=           Set Variable    //input[@id="sum"]
#     ${locAlertProduct}=  Set Variable    //label[@id="alertProduct_name"]
#     ${locAlertAmount}=   Set Variable    //label[@id="alertAmount"]

#     # ตรวจ element input ว่ามีไหม
#     ${assetStatus}    ${assetMsg}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${locAssetPrice}    5s
#     ${sumStatus}      ${sumMsg}=      Run Keyword And Ignore Error    Wait Until Element Is Visible    ${locSum}       5s

#     IF    $assetStatus != 'Pass' or ${sumStatus} != 'Pass'
#         ${Alertmsg}=    Set Variable    HTTP Status 500 – Internal Server Error
#         Write Excel Cell    ${i}    8    ${Alertmsg}
#         Write Excel Cell    ${i}    9    Fail
#         Log To Console    Row ${i}: Input elements missing, skipping
#         RETURN
#     END
#     ${ActualAssetPrice}=    Get Value    ${locAssetPrice}

#     IF    '${Expec}' == '${ActualAssetPrice}' 
#         Write Excel Cell    ${i}    9    Pass
#     ELSE
#         Write Excel Cell    ${i}    9    Fail
#         Capture Page Screenshot    ProjectTest65/imgAddIncome/error_${i}.png
#     END


Get Visible Alert
    [Arguments]    ${locators}
    FOR    ${loc}    IN    @{locators}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${loc}    2s
        IF    ${status}
            ${msg}    Get Text    ${loc}
            RETURN     ${msg}
        END
    END
    RETURN     NONE

Handle Alert And Validate
    [Arguments]    ${i}

    ${Expec}=     Read Excel Cell    ${i}    7

    # กำหนด locators ของ alert
    ${locAlertProduct}=  Set Variable    //label[@id="alertProduct_name"]
    ${locAlertAmount}=   Set Variable    //label[@id="alertAmount"]
    ${locators}=    Create List    ${locAlertProduct}    ${locAlertAmount}

    # จับ alert ของ browser
    ${status}    ${result}=    Run Keyword And Ignore Error    Handle Alert    accept    4s
    Run Keyword If    '${status}'=='PASS'    Write Excel Cell    ${i}    8    ${result}

    # ตรวจสอบข้อความ alert element บนหน้า
    ${alert_text}=    Get Visible Alert    ${locators}
    Run Keyword If    '${status}'!='PASS' and '${alert_text}' != 'NONE'    Write Excel Cell    ${i}    8    ${alert_text}

    # ตรวจสอบค่าที่คาดหวัง
    ${match}=    Run Keyword And Return Status    Should Be True    '${Expec}' == '${result}' or '${Expec}' == '${alert_text}'
    IF    ${match}
        Write Excel Cell    ${i}    9    Pass
    ELSE
        Write Excel Cell    ${i}    9    Fail
        Capture Page Screenshot    ProjectTest65/imgAddIncome/error_${i}.png
    END



Browser Close
    Sleep    3s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document
