*** Variables ***
${url}    http://localhost:8080/vegetable/dologout
${browser}    chrome

${DataTable}    ProjectTest65/Excel/AddShift.xlsx
${sheet}    AddShift
${row}    27

${locClickLogin}    //a[contains(text(),'เข้าสู่ระบบ')]

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]

${clickLink}    //a[contains(text(), 'บันทึกเวลาการทำงาน')]
${locWorkDate}    //input[@id="date"]
${locStartTime}    //input[@id="startTime"]
${locEndTime}    //input[@id="endTime"]
${locRole}    //input[@id="task_name"]
${btnSave}    //input[@type="submit"]
${alertRole}    //label[@id="alertTask_name"]
${alertText}    //p[text()=' เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง !!!']