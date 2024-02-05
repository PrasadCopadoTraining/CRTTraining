*** Settings ***
Library                         QWeb
Library                         QForce
Library                         String


*** Variables ***
${username}                     YOUR USERNAME HERE
${login_url}                    https://YOURDOMAIN.my.salesforce.com                    # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}                     ${login_url}/lightning/page/home


*** Keywords ***
Setup Browser
    Set Library Search Order    QWeb                        QForce
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow


End suite
    Set Library Search Order    QWeb                        QForce
    Close All Browsers


Login
    [Documentation]             Login to Salesforce instance
    Set Library Search Order    QWeb                        QForce
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}                 delay=1
    TypeText                    Password                    ${password}
    ClickText                   Log In


Home
    [Documentation]             Navigate to homepage, login if needed
    Set Library Search Order    QWeb                        QForce
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If              ${login_status}             Login
    ClickText                   Home
    VerifyTitle                 Home | Salesforce

generateAccount
    [Documentation]             generate unique Accounts. generateAccount is a  custom keyword
    [Arguments]                 ${uniqueTimeStamp}          ${uniqueAccountName}
    ClickText                   Accounts
    ClickText                   New
    UseModal                    On
    ${uniqueAccountName}        Catenate  ${uniqueTimeStamp}          ${uniqueAccountName}
    Sleep                       1 sec
    TypeText                    Account Name                ${uniqueAccountName}
    PickList                    Type                        Competitor
    ClickText                   Website
    TypeText                    Website                     www.growmore.org
    ClickText                   Phone
    TypeText                    Phone                       1234567890
    PickList                    Industry                    Banking
    ClickText                   Employees
    TypeText                    Employees                   100
    ClickText                   Save                        partial_match=false
    UseModal                    Off
    [Return]                    ${uniqueAccountName} 


