*** Variables ***
${url}    http://localhost:8080/vegetable/goLogin
${browser}    chrome

${DataTable}    ProjectTest65/Excel/AddIncome.xlsx
${sheet}    AddIncome
${row}    11

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]
${MouseOver}    //a[contains(text(),'รายรับรายจ่ายของโครงการ')]
${clickLink}    //a[contains(text(), 'บันทึกรายรับ')]
${locProductName}    //select[@id="product_name"]
${locAmount}    //input[@id="amount"]


${locAssetPrice}    //input[@id="asset_price"]
${locSum}    //input[@id='sum']

${butSubmit}    //input[@class="btn btn-success"]


# # alert
# ${locAlertProduct}    //div/table/tbody/tr[3]/td/label
# ${locAlertAmount}    //label[contains(text(),'กรุณากรอกจำนวน')][1]