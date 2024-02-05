*** Settings ***
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         String
Library                         DateTime


*** Test Cases ***
Create Account Growmore
    [Tags]                      Account                     New Account    levaragingVariables
    Appstate                    Home
    LaunchApp                   Sales
    ClickText                   Accounts
    ClickText                   New
    UseModal                    On
    Sleep                       1 sec
    ${currentTimeStamp}=        Get Current Date 
    ${genericName}=             Convert To String           prasad
    ${uniqueAccountsName}=      Catenate                     ${currentTimeStamp}${genericName}
    TypeText                    Account Name                  ${uniqueAccountsName}

    Wait Until Keyword Succeeds                             1 min                   5 sec       TypeText        Account Name    Growmore
    PickList                    Type                        Other
    ClickText                   Website
    TypeText                    Website                     www.growmore.org
    ClickText                   Phone
    TypeText                    Phone                       1234567890
    PickList                    Industry                    Banking
    ClickText                   Employees
    TypeText                    Employees                   100
    ClickText                   Save                        partial_match=false
    UseModal                    Off

    ClickText                   Details                     anchor=Related
    VerifyText                  ${uniqueAccountsName}
    VerifyText                   ${uniqueAccountsName}      anchor=Account Name
    VerifyField                 Phone                       (123) 456-7890
    VerifyField                 Employees                   100
    VerifyField                 Website                     www.growmore.org
    VerifyField                 Industry                    Banking