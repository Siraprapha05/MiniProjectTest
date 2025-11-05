**** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    Collections
Library    String
Library    DateTime
Resource    ../Variables/registerVar.robot

*** Keywords ***
Launch Browser and Navigate to Url
    Open Browser   ${url}   ${browser}
    Maximize Browser Window

Launch Excel
    Open Excel Document    ${DataTable}    ${sheet}

Input Form Fullname and Phone
    [Arguments]    ${i}
        ${name}    Read Excel Cell    ${i}    3
        IF    '${name}' == '${NONE}'
            ${name}    Set Variable
        END
        Input Text    ${locFullname}    ${name}    5s
        ${tel}    Read Excel Cell    ${i}    4
        IF    '${tel}' == '${NONE}'
            ${tel}    Set Variable
        END
        Input Text    ${locTel}    ${tel}

Input Birthdate
    [Arguments]    ${i}
        ${birthdate}    Read Excel Cell    ${i}    5
        IF    '${birthdate}' != '${NONE}'
            ${date}    Evaluate    "${birthdate}".replace("/", "-")        
        ELSE
            ${date}    Set Variable    ""
        END
        Wait Until Element Is Visible    ${locbirthday}    3s
        Clear Element Text    ${locbirthday}
        Input Text    ${locbirthday}    ${date}


Select Term
    [Arguments]    ${i}
    ${term}    Read Excel Cell    ${i}    6
    ${term}    Evaluate    str("${term}").strip()
    Log    Term from Excel: ${term}
    Wait Until Page Contains    ปีการศึกษา/เทอม:
    Scroll Element Into View    ${locTerm}
    Wait Until Element Is Visible    ${locTerm}    2s
    Run Keyword And Ignore Error    
    ...    Select From List By Label    ${locTerm}    ${term}

 Input Form stucode and Major
    [Arguments]    ${i}    
        Run Keyword And Ignore Error
        ...    Wait Until Element Is Visible    ${locStudentid}
        ${stucode}    Read Excel Cell    ${i}    7
        IF    '${stucode}' == '${NONE}'
            ${stucode}    Set Variable        
        END
        Scroll Element Into View    ${locStudentid}
        Input Text    ${locStudentid}    ${stucode}

        ${Major}    Read Excel Cell    ${i}    8
        IF    '${Major}' == '${NONE}'
            ${Major}    Set Variable        
        END
        Scroll Element Into View    ${locMajor}
        Input Text    ${locMajor}    ${Major} 


Select Faculty
    [Arguments]    ${i}
    ${faculty}    Read Excel Cell    ${i}    9
    ${faculty}    Evaluate    str("${faculty}").strip()
    Log    Faculty from Excel: ${faculty}
    Scroll Element Into View    ${locFaculty}
    Wait Until Element Is Visible    ${locFaculty}    5s
    ${options}=    Get List Items    ${locFaculty}
    Log List    ${options}
    Run Keyword And Ignore Error    Select From List By Label    ${locFaculty}    ${faculty}


Input Form 
    [Arguments]    ${i}  
    ${reason}    Read Excel Cell    ${i}    10
    IF    '${reason}' == '${NONE}'
        ${reason}    Set Variable        
    END
    Scroll Element Into View    ${locReason}
    Input Text    ${locReason}    ${reason}

    ${email}    Read Excel Cell    ${i}    11
    IF    '${email}' == '${NONE}'
        ${email}    Set Variable                
    END
    Scroll Element Into View    ${locemail}
    Input Text    ${locemail}    ${email}

    ${password}    Read Excel Cell    ${i}    12
    IF    '${password}' == '${NONE}'
        ${password}    Set Variable                
    END
    Scroll Element Into View    ${locPassword}
    Input Password    ${locPassword}    ${password}
    Wait Until Element Is Visible    ${locbtn}


Button Click 
    Execute JavaScript    document.getElementById('footer').style.display='none';
    Click Button    ${locbtn}


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
    ${Expec}     Read Excel Cell    ${i}    13
    Sleep    4s
    ${status}    ${result}    Run Keyword And Ignore Error    Handle Alert    accept    4s
    Run Keyword If    '${status}'=='PASS'    Write Excel Cell    ${i}    14    ${result}    

    ${locators}=    Create List
    ...    ${alertName}    ${alertPhone}    ${alertBirthday}    ${alertTerm}    ${alertStuID}
    ...    ${alertMajor}    ${alertFaculty}    ${alertReason}    ${alertEmail}    ${alertPassword}
    ${alert_text}    Get Visible Alert    ${locators}   

    Run Keyword If    '${status}'!='PASS'    Write Excel Cell    ${i}    14    ${alert_text}

    IF    '${Expec}' in ['${result}', '${alert_text}']
        Write Excel Cell    ${i}    15    Pass
    ELSE
        Write Excel Cell    ${i}    15    Fail
        Capture Page Screenshot    ProjectTest65/imgRegister/error_${i}.png
    END

Browser Close
    Sleep    2s
    Close Browser
    

Save And Close Excel
    Save Excel Document    ${DataTable}    
    Close Current Excel Document