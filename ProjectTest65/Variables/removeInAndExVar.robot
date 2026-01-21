*** Variables ***
${url}    http://localhost:8080/vegetable/goLogin
${browser}    chrome

${DataTable}    ProjectTest65/Excel/RemoveIncomeAndExpense.xlsx
${sheet}    RemoveIncomeAndExpense
${row}    4

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]

${locTerm}    //select[@name='term_year']
${locType}    //select[@id='type']
${locBtnSearch}    //button[contains(text(),'ค้นหา')]

${locDelete}    //button[@role='button'][contains(text(),'ลบ')][1]
                
${locCancel}    //button[@type='button'][contains(text(),'ไม่ใช่')][1]
${locOK}    //button[@name='btnAdd'][contains(text(),'ใช่')][1]