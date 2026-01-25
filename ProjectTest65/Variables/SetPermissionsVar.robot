*** Variables ***
${url}    http://localhost:8080/vegetable/dologout
${browser}    chrome

${DataTable}    ProjectTest65/Excel/SetPermissions.xlsx
${sheet}    SetPermissions
${row}    3

${locClickLogin}    //a[contains(text(),'เข้าสู่ระบบ')]

${locbtnLogin}    //input[@value='Login']
${locSetpermission}    //select[@id='setpermission']

${MouseOver}    //a[contains(text(),'ข้อมูลโครงการ')]
${clickLink}    //a[contains(text(),'รายชื่อนักศึกษาโครงการ')]

${lonbtn}    //a[@class='btn btn-warning'][contains(text(),'ดูรายละเอียด')][1]

${locSubmit}    //button[@id='submit']