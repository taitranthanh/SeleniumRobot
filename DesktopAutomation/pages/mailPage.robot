*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource    masterPage.robot

*** Variables ***
${emailFieldEle}    //input[@id='identifierId']
${nextBtnEle}    //*[@id="identifierNext"]
${passwordNextBtnele}    //*[@id="passwordNext"]
${passwordFieldEle}    //input[@name='Passwd']
${composeBtnEle}    //div[normalize-space(text())='Compose']
${newEmailEle}    //span[normalize-space()='New Message']
${sendToFieldEle}    //div[@aria-label="Search Field"]//input
${subjectFieldEle}    //input[@name="subjectbox"]
${emailBodyEle}    //div[@aria-label='Message Body']
${sendEmailBtnEle}    //div[normalize-space(text())="Send"]
${sendFolderEle}    //a[normalize-space(text())='Sent']
# Define elements on Advance Search View
${searchTypeEle}    //span[@aria-label='Search within']/div[1]
${searchSubjectFieldEle}    //label[normalize-space()='Subject']/following::input[1]
${searchSendToFieldEle}    //label[normalize-space()='To']/following::input[1]
${searchAdvanceBtnEle}    //div[normalize-space(text())="Search" and @role]
${advanceSearchEle}    //button[@aria-label='Advanced search options']
${EMAIL_TITLE}    Email
${PASSWORD_TITLE}    Password
${NEXT_TITLE}    Next
${COMPOSE_TITLE}    Compose
${SEND_TO_TITLE}    Send To
${SUBJECT_TITLE}    Subject
${EMAIL_BODY_TITLE}    Email Body
${SEND_EMAIL_TITLE}    Send Email
${SENT_FOLDER_TITLE}    Sent Folder
${ADVANCE_SEARCH_TITLE}    Advanced search options
${SEARCH_TITLE}    Search
${DEFAULT_SEND_TO_EMAIL}    tthanhtaicntt@gmail.com
${AUTOMATION_SUBJECT}    [AUTOMATION EMAIL]
${AUTOMATION_EMAIL_BODY}    Dear ${DEFAULT_SEND_TO_EMAIL},\n\nThis is email which is sent by automation.\n\nBR,\nAutomation Selenium
    
*** Keywords ***
Input Email Address
    [Arguments]    ${value}=${DEFAULT_USERNAME}
    Input Value To Field Title    ${EMAIL_TITLE}    ${emailFieldEle}    ${value}

Click Next Button
    Click On Element Title    ${NEXT_TITLE}    ${nextBtnEle}
    Wait Until Page Contains Element    ${passwordFieldEle}

Click Password Next Button
    Click On Element Title    ${NEXT_TITLE}    ${passwordNextBtnEle}

Input Password
    [Arguments]   ${value}=${DEFAULT_PASSWORD}
    Input Value To Field Title    ${PASSWORD_TITLE}    ${passwordFieldEle}    ${value}

Click Compose Button
    Click On Element Title     ${COMPOSE_TITLE}    ${composeBtnEle}
    Wait Until Element Is Visible    ${newEmailEle}

Input Send To Email
    [Arguments]    ${value}=${DEFAULT_SEND_TO_EMAIL}
    Input Value To Field Title    ${SEND_TO_TITLE}    ${sendToFieldEle}    ${value}

Input Subject Title
    [Arguments]    ${value}=${AUTOMATION_SUBJECT}
    ${ramdomNumber}    Generate Random String    4    [NUMBERS]
    Set Suite Variable    ${SUBJECT_TITLE}    ${value}#${ramdomNumber}
    Log    ${SUBJECT_TITLE}
    Input Value To Field Title    ${SUBJECT_TITLE}    ${subjectFieldEle}    ${SUBJECT_TITLE}

Input Email Message Body
    [Arguments]    ${value}=${AUTOMATION_EMAIL_BODY}
    Input Value To Field Title    ${EMAIL_BODY_TITLE}    ${emailBodyEle}    ${value}

Click Send Email Button
    Click On Element Title    ${SEND_EMAIL_TITLE}    ${sendEmailBtnEle}

Log In To Gmail
    Input Email Address
    Click Next Button
    Input Password
    Click Password Next Button

Input Email Information For Sending
    Input Send To Email
    Input Subject Title
    Input Email Message Body

Click On Sent Folder
    Click On Element Title    ${SENT_FOLDER_TITLE}    ${sendFolderEle}

Click On Advance Search Option
    Wait Until Page Contains Element    ${advanceSearchEle}
    Click On Element Title    ${ADVANCE_SEARCH_TITLE}    ${advanceSearchEle}

Select Search Type
    [Arguments]    ${value}
    ${option}    Set Variable    //div[@title='${value}']
    Click Element    ${searchTypeEle}
    Scroll Element Into View    ${option}
    Click On Element Title    ${value}    ${option}
    
Input Subject To Advance Search
    [Arguments]    ${value}
    Input Value To Field Title    Subject For Search    ${searchSubjectFieldEle}    ${value}
    Wait Until Page Contains Element    ${searchSendToFieldEle}

Input Send To Email To Advance Search
    [Arguments]    ${value}
    Input Value To Field Title    Send To    ${searchSendToFieldEle}    ${value}

Click On Search Advance Button
    Click On Element Title    ${SEARCH_TITLE}    ${searchAdvanceBtnele}
    Wait Until Element Is Visible    //table[@role='grid']

Verify Message Sent Success Popup
    Element Should Be Visible    //span[normalize-space(text())='${EMAIL_SENT_MESSAGE}']

Verify Email Sent And Saved at Sent Folder
    Click On Advance Search Option
    Input Send To Email To Advance Search    ${DEFAULT_SEND_TO_EMAIL}
    Input Subject To Advance Search    ${SUBJECT_TITLE}
    Select Search Type    Sent Mail
    Click On Search Advance Button
    Verify Sent Email Is Displayed On Sent Folder    ${SUBJECT_TITLE}

Verify Sent Email Is Displayed On Sent Folder
    [Arguments]    ${emailTile}
    Sleep    5
    Wait Until Page Contains Element    //div[@id]//span[normalize-space(text())='${emailTile}']
    Log    Sent Email title "${emailTile}" is displayed at Sent Folder


    