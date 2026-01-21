*** Variables ***
${url}    http://localhost:8080/vegetable/goLogin
${browser}    chrome

${DataTable}    ProjectTest65/Excel/EditIncomeAndExpense.xlsx
${sheet}    EditIncomeAndExpense
${row}    6

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]

${locTerm}    //select[@name='term_year']
${locType}    //select[@id='type']
${locBtnSearch}    //button[contains(text(),'ค้นหา')]

${locBtnView}    //button[@role='button'][contains(text(),'ดู')][1]
${locBtnEdit}    //button[contains(text(),'แก้ไข')]

${locAmount}    //input[@id='amount']
${locBtnSaveEdit}    //button[contains(text(),'บันทึกข้อมูล')]

${locSum}    //input[@placeholder="รวม"]