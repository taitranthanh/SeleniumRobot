*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String

*** Variables ***
${BROWSER}    chrome
${PAGE_URL}    https://mail.google.com/mail/u/0/
${DEFAULT_USERNAME}    tthanhtaiautomation@gmail.com
${DEFAULT_PASSWORD}    12345678x@X
${EMAIL_SENT_MESSAGE}    Message sent

*** Keywords ***
Open URL
    Run Keyword If    '${BROWSER}' == 'HeadlessChrome'    Open Headless Chrome Browser to Page
    Run Keyword If    '${BROWSER}' == 'HeadlessFirefox'    Open Headless Firefox Browser to Page
    Run Keyword If    '${BROWSER}' == 'chrome'    Open Browser To Page
Open Browser To Page
    [Arguments]    ${urL}=${PAGE_URL}
    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    ${options.add_argument}=  Set Variable  --allow-running-insecure-content
    ${options.add_argument}=  Set Variable  --disable-web-security
    ${options.add_argument}=  Set Variable  user-data-dir=/Users/tranthanhtai/Practice/VSeeExercises/localhost
    Create WebDriver  Chrome  chrome_options=${options}
    Go To    ${urL}
    Set Selenium Implicit Wait    10
    Maximize Browser Window

Open Headless Chrome Browser to Page
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --disable-web-security
    Call Method    ${chrome_options}    add_argument    test-type
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    # Resolve chrome crash issue
    Call Method    ${chrome_options}    add_argument    --disable-site-isolation-trials
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    # Resolve blank page screen issue
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Call Method    ${chrome_options}    add_argument    --ssl-protocol
    Call Method    ${chrome_options}    add_argument    --allow-insecure-localhost
    Call Method    ${chrome_options}    add_argument    --allow-running-insecure-content
    Call Method    ${chrome_options}    add_argument    --disable-web-security
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Go To    ${PAGE_URL}
    Set Browser Implicit Wait    5

Open Headless Firefox Browser to Page
    ${firefox_options}    Evaluate    sys.modules['selenium.webdriver'].firefox.webdriver.Options()    sys, selenium.webdriver
    Call Method    ${firefox_options}    add_argument    -headless
    Call Method    ${firefox_options}    add_argument    --ignore-certificate-errors
    Call Method    ${firefox_options}    add_argument    --ssl-protocol
    Call Method    ${firefox_options}    add_argument    --allow-insecure-localhost
    Call Method    ${firefox_options}    add_argument    --allow-running-insecure-content
    Call Method    ${firefox_options}    add_argument    --disable-web-security
    Create Webdriver    Firefox    options=${firefox_options}
    Maximize Browser Window
    Go To    ${PAGE_URL}

#Using to input value for element title
Input Value To Field Title
    [Arguments]    ${title}    ${ele}    ${value}
    Wait Until Element Is Visible    ${ele}
    Scroll Element Into View    ${ele}
    Input Text    ${ele}    ${value}
    Log    Input ${value} to field title ${title}

#Using to click on element title
Click On Button Title
    [Arguments]    ${title}    ${ele}
    Wait Until Element Is Visible    ${ele}
    Scroll Element Into View    ${ele}
    Click Button    ${ele}
    Log    Button title ${title} is clicked
    
Click On Element Title
    [Arguments]    ${title}    ${ele}
    Wait Until Element Is Visible    ${ele}
    Scroll Element Into View    ${ele}
    Click Element    ${ele}
    Log    Element title ${title} is clicked

 