*** Settings ***
Library    SeleniumLibrary
Resource    ../pages/mailPage.robot
Suite Teardown    Close All Browsers

*** Test Cases ***
Verify send email from gmail
    [Tags]
    [Timeout]    5 minutes
    GIVEN User is access to gmail
    AND User is login with gmail account
    WHEN User is click compose new email
    AND User is input email information for sending
    AND User is clicks send email button
    THEN Email is sent successfully  

*** Keywords ***
User is access to gmail
    Open URL

User is login with gmail account
    Log In To Gmail

User is click compose new email
    Click Compose Button

User is input email information for sending
    Input Email Information For Sending
User is clicks send email button
    Click Send Email Button

Email is sent successfully
    Verify Message Sent Success Popup
    Verify Email Sent And Saved at Sent Folder