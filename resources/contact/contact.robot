*** Settings ***
Library           Selenium2Library
Library           String
Library           Collections
Resource          ../common/common.robot
Library           ../../library/CustomLibrary.py
Resource          contact_page_locators.robot

*** Keywords ***
Error Messages Related To Required Fields should be Displayed
    Wait Until Page Contains    We welcome your feedback - but we won't get it unless you complete the form correctly.    30
    Page Should Contain Element    ${FORENAME_ERROR}
    Page Should Contain Element    ${EMAIL_ERROR}
    Page Should Contain Element    ${MESSAGE_ERROR}

User Enters A Value In ${field_name} Field
    ${field_val}=    Get Valid Value    ${field_name}
    Input Field Value    ${field_name}    ${field_val}

Get Valid Value
    [Arguments]    ${field}
    [Documentation]    This keyword generates a valid value for a specified field. The values are randomly generated each time the test is ran.
    ${valid_val} =    Run Keyword If    '${field.lower()}'=='forename'    Generate Name    withLastName=false    gender=female
    ...    ELSE IF    '${field.lower()}'=='email'    Generate Email    emailLength=8
    ...    ELSE IF    '${field.lower()}'=='message'    Create Random String    strLength=15    withSpecialChar=false
    Log    ${valid_val}
    [Return]    ${valid_val}

Submit Contact Form With Complete Details
    [Documentation]    This keyword has all the steps in order to submit a contact form with no errors.
    User Enters A Value In Forename Field
    User Enters A Value In Email Field
    User Enters A Value In Message Field
    User Clicks Submit Button

No Error Message Should Be Displayed
    Resubmit Contact Form If Initial Submit Fails
    Wait Until Element Is Not Visible    ${SEND}    80
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    Thanks ${Forename}, we appreciate your feedback.    30
    Page Should Not Contain Element    ${FORENAME_ERROR}
    Page Should Not Contain Element    ${EMAIL_ERROR}
    Page Should Not Contain Element    ${MESSAGE_ERROR}
    Set Test Variable    ${Success_Displayed}    ${status}

Resubmit Contact Form If Initial Submit Fails
    [Documentation]    This keyword checks if the Contact form was successfully submitted. If not it will click the submit button once again.
    ${submit_visible}    Run Keyword And Return Status    Page Should Not Contain    ${SUBMIT}
    Run Keyword If    ${submit_visible}    Log    Contact Form Has Been Submitted
    ...    ELSE    User Clicks Submit Button

User Submits The Contact Form With Complete Details ${num_of_submission} Times
    [Documentation]    This keyword checks that the contact form can be submitted multiple times. A variable that denotes the number of times the contact form was submitted successfully. This will be used as part of succeeding assertion.
    ${num_of_success}    Convert To Integer    0
    FOR    ${index}    IN RANGE    ${num_of_submission}
        Run Keywords    Submit Contact Form With Complete Details    No Error Message Should Be Displayed    User Clicks Back Button
        Log    Success Displayed = ${Success_Displayed}
        ${num_of_success}    Run Keyword If    ${Success_Displayed}    Set Variable    ${num_of_success+1}
        ...    ELSE    Set Variable    ${num_of_success}
        Log    ${num_of_success}
        Sleep    1
    END
    Set Test Variable    ${NumOfSuccess}    ${num_of_success}

The Success Message with No Errors Should Be Displayed ${expected_num_of_success} Times As Well
    [Documentation]    This keyword checks that the contact form was successfully submitted based on the expected number of times.
    Log    ${expected_num_of_success}
    Run Keyword If    ${expected_num_of_success}==${NumOfSuccess}    Log    Success Message was Displayed ${NumOfSuccess} times
    ...    ELSE    Fail    Contact Form was submitted successfully only ${NumOfSuccess} times
