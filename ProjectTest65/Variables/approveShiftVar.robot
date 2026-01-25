*** Variables ***
${url}    http://localhost:8080/vegetable/dologout
${browser}    chrome

${DataTable}    ProjectTest65/Excel/ApproveShift.xlsx
${sheet}    ApproveShift
${row}    3

${locClickLogin}    //a[contains(text(),'เข้าสู่ระบบ')]

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]

${clickLink}    //a[contains(text(),'รายชื่อสมาชิกโครงการ')]
${clickButton}    //button[@role='button'][contains(text(),'ตรวจสอบ')][1]

${approve}    //input[@value='อนุมัติ']
${reject}    //input[@value='ไม่อนุมัติ']