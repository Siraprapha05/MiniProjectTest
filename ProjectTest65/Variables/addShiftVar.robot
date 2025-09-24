*** Variables ***
${url}    http://localhost:8081/project_vegetable/goLogin
${browser}    chrome

${DataTable}    Excel/AddShift.xlsx
${sheet}    AddShift
${row}    27

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