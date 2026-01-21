*** Variables ***
${url}    http://localhost:8080/vegetable/goLogin
${browser}    chrome

${DataTable}    ProjectTest65/Excel/ApproveRequest.xlsx
${sheet}    ApproveRequest
${row}    4


${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]

${onclickLink}    //a[contains(text(),'คำขอเข้าร่วมโครงการ')]
${lohbtnCheck}    //button[@type='button'][contains(text(),'ตรวจสอบ')]

${locbtnApprove}    //button[@id='submit']
${locbtnReject}    //a[contains(text(),'ไม่อนุมัติคำขอ')]
