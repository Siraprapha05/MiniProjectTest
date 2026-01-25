*** Variables ***
${url}    http://localhost:8080/vegetable/dologout
${browser}    chrome

${DataTable}    ProjectTest65/Excel/AddExpense.xlsx
${sheet}    AddExpense
${row}    14

${locClickLogin}    //a[contains(text(),'เข้าสู่ระบบ')]

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]
${MouseOver}    //a[contains(text(),'รายรับรายจ่ายของโครงการ')]
${clickLink}    //a[contains(text(),'บันทึกรายจ่าย')]

${locDeviceName}    css:#equipment_name
${locAssetPrice}    //input[@id='asset_price']
${locAmount}    //input[@id='amount']

${alertProduct_name}    //label[@id='alertProduct_name']
${alertAssetPrice}    //label[@id='alertPrice']
${alertAmount}    //label[@id='alertAmount']

${submit_button}    //input[@id='add']