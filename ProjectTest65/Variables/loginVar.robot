*** Variables ***
${url}    http://localhost:8081/project_vegetable/goLogin
${browser}    chrome

${DataTable}    Excel/Login.xlsx
${sheet}    Login
${row}    12

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtn}    //input[@type="submit"]
