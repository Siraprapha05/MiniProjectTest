*** Variables ***
${url}    http://localhost:8080/vegetable/goLogin
${browser}    chrome

${DataTable}    ProjectTest65/Excel/ApproveShift.xlsx
${sheet}    ApproveShift
${row}    2

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]

${clickLink}    //a[contains(text(),'รายชื่อสมาชิกโครงการ')]
${clickButton}    //button[@role='button'][contains(text(),'ตรวจสอบ')][1]

${approve}    //input[@value='อนุมัติ']
${reject}    //input[@value='ไม่อนุมัติ']