*** Variables ***
${url}    http://localhost:8081/project_vegetable/goLogin
${browser}    chrome

${DataTable}    Excel/AddShift.xlsx
${sheet}    AddShift
${row}    27

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]