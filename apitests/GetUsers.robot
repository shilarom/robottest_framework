*** Settings ***
Test Teardown     Clear Expectations
Resource          ../resources/api/api.robot

*** Test Cases ***
001_Verify Get User Schema is correct
    GET    /api/users
    Output Schema    response body    ${CURDIR}/response/response.json
    Expect Response Body    ${CURDIR}/response/response.json

002_Verify Get user service returns the correct user details
    GET    /api/users/1
    Output    response
    Integer    response status    400
    Integer    $.data.id    1
    String    $.data.email    george.bluth@reqres.in
    String    $.data.first_name    George
