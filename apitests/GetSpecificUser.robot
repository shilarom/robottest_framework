*** Settings ***
Test Teardown     Clear Expectations
Test Template     Get Specific User
Library           DataDriver    file=../testdata/user.csv
Resource          ../resources/api/api.robot

*** Test Cases ***
Verify user details
    ${relative_url} ${id} ${email} ${first_name} ${last_name}

*** Keywords ***
Get Specific User
    [Arguments]    ${relative_url}    ${id}    ${email}    ${first_name}    ${last_name}
    GET    ${relative_url}
    Output    response
    Integer    response status    200
    Integer    $.data.id    ${id}
    String    $.data.email    ${email}
    String    $.data.first_name    ${first_name}
    String    $.data.last_name    ${last_name}
