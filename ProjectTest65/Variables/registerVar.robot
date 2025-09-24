*** Variables ***
${url}    http://localhost:8081/project_vegetable/goRegister
${browser}    chrome

${DataTable}    Excel/Register.xlsx
${sheet}    Register
${row}    86

${locaPrefix}    //input[@id="prefix"]
${locFullname}    //input[@id='name']
${locTel}    //input[@id='phone']
${locBirthday}    //input[@id='birthday']
${locTerm}    //select[@id='term']
${locStudentid}    //input[@id='stucode']
${locMajor}   //input[@id='major']
${locFaculty}    //select[@id='faculty']
${locReason}    //textarea[@id='reason']
${locEmail}    //input[@id='email']
${locPassword}    //input[@id='password']
${locbtn}    //input[@type="submit"]    


${alertName}    //label[@id="alertName"]
${alertPhone}    //label[@id="alertPhone"]
${alertBirthday}    //label[@id="alertBirthday"]
${alertTerm}    //label[@id="alertTerm"]
${alertStuID}    //label[@id="alertStuID"]
${alertMajor}    //label[@id="alertMajor"]
${alertFaculty}    //label[@id="alertFaculty"]
${alertReason}    //label[@id="alertReason"]
${alertEmail}    //label[@id="alertEmail"]
${alertPassword}    //label[@id="alertPassword"]