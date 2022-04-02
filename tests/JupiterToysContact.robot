*** Settings ***
Documentation     This Test Suite is composed of test cases related to Contacts Form of Jupiter Toys Website
...               Please note that I have split Test Case No. 1 into 2 separate test cases because they are validating two different behaviors. I am using Gherkin style of wring test case and as best practice there should only be 1 behavior per test case.
Test Teardown     Close Browser
Force Tags        CONTACT
Resource          ../resources/contact/contact.robot
Resource          ../resources/common/common.robot

*** Test Cases ***
001a_Validate error messages are displayed in Contact Page when mandatory fields are not populated
    [Tags]    TC1
    Given The Contact Page Is Open
    When User Clicks Submit Button
    Then Error Text Forename Is Required Should Be Displayed
    And Error Text Email Is Required Should Be Displayed
    And Error Text Message Is Required Should Be Displayed

001b_Validate that no error message are displayed when all mandatory fields are populated in Contact form
    [Tags]    TC1
    Given The Contact Page Is Open
    When User Enters A Value In Forename Field
    And User Enters A Value In Email Field
    And User Enters A Value In Message Field
    And User Clicks Submit Button
    Then No Error Message Should Be Displayed

002_Successfully submit contact form with complete details multiple times
    [Tags]    TC2
    Given The Contact Page Is Open
    When User Submits The Contact Form With Complete Details 5 Times
    Then The Success Message with No Errors Should Be Displayed 5 Times As Well
