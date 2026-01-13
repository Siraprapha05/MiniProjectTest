*** Variables ***
${url}    http://localhost:8080/vegetable/goLogin
${browser}    chrome

${DataTable}    ProjectTest65/Excel/AddExpense.xlsx
${sheet}    AddExpense
${row}    14

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]
${MouseOver}    //a[contains(text(),'รายรับรายจ่ายของโครงการ')]
${clickLink}    //a[contains(text(),'บันทึกรายจ่าย')]

${locDeviceName}    //select[@id='equipment_name']
${locAssetPrice}    //input[@id='asset_price']
${locAmount}    //input[@id='amount']
