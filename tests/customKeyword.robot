*** Settings ***
Resource                     ../resources/common.robot
Library                      DateTime
Suite Setup                  Setup Browser
Suite Teardown               End suite


*** Test Cases ***
Create Account Growmore
    [Tags]                   Account                     Leveraging Variables
    Appstate                 Home
    LaunchApp                Sales
    ${currentTimestamp}=     Get Current Date
    ${uniqueAccountName}=    generateAccount             ${currentTimestamp}     prasad
    ClickText                Details                     anchor=Related
    VerifyText               ${uniqueAccountName}
    VerifyText               ${uniqueAccountName}        anchor=Account Name     timeout=60s
    VerifyField              Phone                       (123) 456-7890
    VerifyField              Employees                   100
    VerifyField              Website                     www.growmore.org
    VerifyField              Industry                    Banking