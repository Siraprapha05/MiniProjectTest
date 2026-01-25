*** Variables ***
${url}    http://localhost:8080/vegetable/dologout
${browser}    chrome

${DataTable}    ProjectTest65/Excel/Login.xlsx
${sheet}    Login
${row}    12

${locClickLogin}    //a[contains(text(),'เข้าสู่ระบบ')]

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtn}    //input[@type="submit"]
