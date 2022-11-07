*** Settings ***
Resource    ../resources/mainFunctions.robot
Library    OperatingSystem
Suite Teardown    Close Github API Session

*** Variables ***
${OWNER_REPO}    SeleniumHQ

*** Test Cases ***
TC01 - Total open issues are there across all repositories
    [Tags]    TC01
    [Timeout]    2 minutes
    GIVEN Clients Is Connected To Github API
    WHEN Clients is executes GET API to get total open issues
    THEN API returns 200 status code
    AND Return total open issues are there across all repositories

TC02 - Sort the repositories by date updated in descending order.
    [Tags]    TC02
    [Timeout]    2 minutes
    GIVEN Clients Is Connected To Github API
    WHEN Clients is executes GET API to get all repositories with desc sort
    THEN API returns 200 status code
    AND Return repositories by date updated in descending order

TC03 - Repository has the most watchers
    [Tags]    TC03
    [Timeout]    2 minutes
    GIVEN Clients Is Connected To Github API
    WHEN Clients is executes GET API to get repository has the most watchers
    THEN API returns 200 status code
    AND Return repository has the most watchers

*** Keywords ***
Clients Is Connected To Github API
    Create Github API Session

Clients is executes GET API to get total open issues
    ${headers}    Create Dictionary    Content-Type=application/json
    Execute GET API Request and Return Respone    github_session    /orgs/${OWNER_REPO}/repos    ${headers}

Clients is executes GET API to get all repositories with desc sort
    ${headers}    Create Dictionary    Content-Type=application/json
    Execute GET API Request and Return Respone    github_session    /orgs/${OWNER_REPO}/repos?sort=updated&order=desc    ${headers}

Return total open issues are there across all repositories
    Total Open Issues Are There Across All Repositories

Clients is executes GET API to get repository has the most watchers
    ${headers}    Create Dictionary    Content-Type=application/json
    Execute GET API Request and Return Respone    github_session    /orgs/${OWNER_REPO}/repos    ${headers}

Return repository has the most watchers
    Repository Has The Most Watchers

Return repositories by date updated in descending order
    All Repositories Is Sorted By Date Updated In Descending Order