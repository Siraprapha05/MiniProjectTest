**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Resource    ../TestCase/loginTest.robot

*** Keywords ***
Launch Browser and Navigate to Url
    Open Browser   ${url}   ${browser}
    Maximize Browser Window

Launch Excel
    Open Excel Document    ${DataTable}    ${sheet}

Input Form
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
    Wait Until Element Is Visible    ${locbtn}

Button Click 
    Click Button    ${locbtn}
    

# Handle Alert And Validate
#     [Arguments]    ${i}

#     ${Expec}=    Read Excel Cell    ${i}    5 

#     ${email}=    Read Excel Cell    ${i}    3
#     ${password}=    Read Excel Cell    ${i}    4

#     IF    '${email}' == '${NONE}' or '${email}' == '' or '${password}' == '${NONE}' or '${password}' == ''
#         ${alertMsg}=    Set Variable    Please fill out this field.
#         Log    ${alertMsg} (row ${i})
#         Write Excel Cell    ${i}    6    ${alertMsg}   
#         Write Excel Cell    ${i}    7    Fail        
#         RETURN
#     END
#     Sleep    3s
#     ${status}    ${alertMsg}=    Run Keyword And Ignore Error    Handle Alert    accept    4s
#     ${statusMsg}    ${pageMsg}=    Run Keyword And Ignore Error    Get Text    xpath=//div[contains(@class,"bg-light")]/b/p

#     ${statusalert}    ${result}    Run Keyword And Ignore Error    Handle Alert    accept    4s

#     Run Keyword If    '${statusalert}'=='Pass'    Write Excel Cell    ${i}    6    ${result}    

#     IF    '${statusMsg}' == 'Fail'
#         ${alertMsg}=    Set Variable    เข้าสู่ระบบสำเร็จ
#     ELSE
#         ${alertMsg}=    Set Variable    ${pageMsg}
#     END
#     Run Keyword And Ignore Error    Write Excel Cell    ${i}    6    ${alertMsg}

#     IF    $alertMsg == 'เข้าสู่ระบบสำเร็จ'
#         Write Excel Cell    ${i}    7    Pass
#     ELSE IF    '${Expec}' in [$alertMsg, '${statusalert}']
#         Write Excel Cell    ${i}    7    Pass
#     ELSE
#         Write Excel Cell    ${i}    7    Fail
#         Capture Page Screenshot    ProjectTest65\imgLogin/error_${i}.png
#     END

Handle Alert And Validate
    [Arguments]    ${i}

    ${Expec}=       Read Excel Cell    ${i}    5
    ${email}=       Read Excel Cell    ${i}    3
    ${password}=    Read Excel Cell    ${i}    4

    IF    '${email}' == '' or '${password}' == ''
        ${alertMsg}=    Set Variable    Please fill out this field.
        Log    ${alertMsg} (row ${i}-1)
        Write Excel Cell    ${i}    6    ${alertMsg}
    END

    Sleep    3s

    ${alertMsg}=    Set Variable    No message found
    ${status1}=     Set Variable    Fail
    ${locAlert}=    Set Variable    //div[contains(@class,'bg-light')]//p[1]

    ${waitStatus}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${locAlert}    8s

    IF    ${waitStatus}
        ${alertMsg}=    Get Text    ${locAlert}
        ${status1}=     Set Variable    PASS
    END

    Write Excel Cell    ${i}    6    ${alertMsg}

    # -------------------------------
    # 3) เปรียบเทียบผลลัพธ์กับ Expected
    # -------------------------------
    IF    '${Expec}' == '${alertMsg}'
        Write Excel Cell    ${i}    7    Pass
    ELSE
        Write Excel Cell    ${i}    7    Fail
        Capture Page Screenshot    ProjectTest65/imgLogin/error_${i}.png
    END


Browser Close
    Sleep    2s
    Close Browser
    
Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document

