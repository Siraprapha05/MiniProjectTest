*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    XML
Resource    ../TestCase/approveShiftTest.robot

*** Keywords ***
Launch Browser and Navigate to Url
    Open Browser   ${url}   ${browser}
    Maximize Browser Window

Launch Excel
    Open Excel Document    ${DataTable}    ${sheet}

Input Login Form
    [Arguments]    ${i}
    Input Text    //input[@id="email"]    officer1503@mju.ac.th
    Input Text    //input[@id="pwd"]    1503