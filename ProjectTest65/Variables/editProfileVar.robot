*** Variables ***
${url}    http://localhost:8080/vegetable/goLogin
${browser}    chrome

${DataTable}    ProjectTest65/Excel/EditProfile.xlsx
${sheet}    editProfile
${row}    23

${locEmail}    //input[@id="email"]
${locPassword}    //input[@id="pwd"]
${locbtnLogin}    //input[@type="submit"]
${MouseOverProfile}    //li[@class="dropdown" and .//i[@class="gg-user"]]
${clickLinkProfile}    //li[@class="dropdown" and .//i[@class="gg-user"]]//a[text()='ข้อมูลส่วนตัว']
${btnEditProfile}    //input[@type="submit"]

${clickEdit}    //a[text()='ข้อมูลส่วนตัว']
${locName}    //input[@id="name"]
${locPhone}    //input[@id="phone"]

${btnSaveEdit}    //input[@class="btn btn-success"]

${alertName}    //label[@id="alertName"]
${alertPhone}    //label[@id="alertPhone"]
${errortext}    //p[@class="mb-0 d-inline-block"]