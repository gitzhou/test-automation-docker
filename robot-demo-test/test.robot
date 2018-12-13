*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary

Test Teardown  Test End

*** Variables ***


*** Test Cases ***
Open browser and lanch baidu.com
    [Tags]    DEBUG
    Test Preperation
    Test Procedure



*** Keywords ***
Test Preperation
    open browser  https://www.baidu.com

Test Procedure
    wait until page contains  baidu

Test End
    close all browsers
