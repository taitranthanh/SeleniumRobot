*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    SeleniumLibrary
Library    Telnet
Library    Collections

*** Variables ***
${GITHUB_API_URL}    https://api.github.com

*** Keywords ***
Create Github API Session
    Create Session    github_session    ${GITHUB_API_URL}

Close Github API Session
    Close All Connections

API returns 200 status code
    Should Be Equal As Strings    ${response.status_code}    200

Execute GET API Request and Return Respone
    [Arguments]    ${alias}    ${url}    ${headers}
    ${response}    GET On Session    ${alias}    url=${url}    headers=${headers}
    Set Test Variable    ${response}
    Log Many    ${response}
Total Open Issues Are There Across All Repositories
    [Return]    ${total}
    ${total}    Set Variable    0
    ${data}    Convert String To Json    ${response.content}
    Log Many    ${data}
    FOR    ${json}    IN    @{data}
        Log    ${json}
        ${repoName}    Set Variable    ${json['name']}
        Log    ${repoName}
        ${openIssueCount}    Set Variable    ${json['open_issues']}
        Log    ${openIssueCount}
        ${total}    Evaluate    int(${openIssueCount}) + int(${total})
    END
    Log    Total Open Issues Are There Across All Repositories: ${total}

Repository Has The Most Watchers
    [Return]    ${repoName}
    ${maxWatcherCount}    Set Variable    0
    ${repoName}    Set Variable
    ${data}    Convert String To Json    ${response.content}
    FOR    ${json}    IN    @{data}
        ${watchersCount}    Set Variable    ${json['watchers']}
        ${currentRepoName}    Set Variable    ${json['name']}
        ${check}    Evaluate    int(${maxWatcherCount}) < int(${watchersCount})
        ${maxWatcherCount}    Set Variable If    ${check}==${True}    ${watchersCount}    ${maxWatcherCount}
        ${repoName}    Set Variable If    ${check}==${True}    ${currentRepoName}    ${repoName}
    END
    Log    Maximum watchers: ${maxWatcherCount}
    Log    Repository has most watchers is: ${repoName}
    
All Repositories Is Sorted By Date Updated In Descending Order
    [Return]    ${repoSortList}
    ${repoSortList}    Create List
    ${data}    Convert String To Json    ${response.content}
    FOR    ${json}    IN    @{data}
        ${repoName}    Set Variable    ${json['name']}
        Append To List    ${repoSortList}    ${repoName}
    END
    Log    List Of Repositories is sorted: @{repoSortList}
    FOR    ${repo}    IN    @{repoSortList}
        Log    ${repo}
        
    END