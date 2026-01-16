*** Variables ***
${url}    http://localhost:8080/vegetable/goLogin
${browser}    chrome

${DataTable}    ProjectTest65/Excel/SetPermissions.xlsx
${sheet}    SetPermissions
${row}    3

${locbtnLogin}    //input[@value='Login']
${locSetpermission}    //select[@id='setpermission']

${MouseOver}    //a[contains(text(),'ข้อมูลโครงการ')]
${clickLink}    //a[contains(text(),'รายชื่อนักศึกษาโครงการ')]

${lonbtn}    //a[@class='btn btn-warning'][contains(text(),'ดูรายละเอียด')][1]

${locSubmit}    //button[@id='submit']